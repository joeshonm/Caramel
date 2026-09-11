#!/usr/bin/env bash
# Stamp a fresh copy of the caramel template with a project name and platform list.
#
#   ./scripts/init-project.sh <project-name> <platform[,platform...]>
#
# One platform  -> single mode: bindings stay inline in the core docs.
# Two or more   -> multi mode: overlays are generated in docs/platforms/ and you must
#                  cut each core doc's "Platform bindings" section into them by hand
#                  (AGENTS.md section 6, step 1). That step is judgement, not mechanics.

set -euo pipefail

if [ $# -ne 2 ]; then
  sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'
  exit 64
fi

NAME="$1"
PLATFORM_CSV="$2"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DOCS="$ROOT/docs"

IFS=',' read -ra PLATFORMS <<< "$PLATFORM_CSV"
COUNT=${#PLATFORMS[@]}
PRIMARY="$(echo "${PLATFORMS[0]}" | tr -d '[:space:]')"

if [ "$COUNT" -gt 1 ]; then MODE=multi; else MODE=single; fi

LIST="$(printf '%s, ' "${PLATFORMS[@]}" | sed 's/, $//' | tr -d ' ')"

# Portable in-place sed (GNU and BSD).
sedi() { if sed --version >/dev/null 2>&1; then sed -i "$@"; else sed -i '' "$@"; fi; }

# Escape a string for use on the right-hand side of s///: backslash, the / delimiter,
# and & (which sed expands to the matched text). Without this, a project named "A&B"
# stamps itself as "AcaramelB".
rhs() { printf '%s' "$1" | sed -e 's/[\\/&]/\\&/g'; }

NAME_RHS="$(rhs "$NAME")"
PRIMARY_RHS="$(rhs "$PRIMARY")"
LIST_RHS="$(rhs "$LIST")"

echo "Project : $NAME"
echo "Platform: $LIST"
echo "Mode    : $MODE"
echo

# CARAMEL_PROJECT / CARAMEL_PLATFORM are distinct placeholder tokens rather than the
# literal words "caramel" and "PLATFORM", so substitution cannot touch prose that merely
# mentions the template by name (ADR-0001 discussing caramel, say, or the word "platform"
# in a sentence). Rename the template freely; only these tokens are load-bearing.
while IFS= read -r -d '' f; do
  sedi "s/CARAMEL_PROJECT/$NAME_RHS/g" "$f"
  sedi "s/CARAMEL_PLATFORM/$PRIMARY_RHS/g" "$f"
done < <(find "$DOCS" "$ROOT/README.md" -type f \
  \( -name '*.md' -o -name '*.yaml' -o -name '*.json' -o -name '*.sql' \) \
  -not -path "$DOCS/_templates/*" -print0)

sedi "s/^platforms: .*/platforms: [$LIST_RHS]/" "$DOCS/AGENTS.md"
sedi "s/^mode: .*/mode: $MODE/" "$DOCS/AGENTS.md"
sedi "s/^project: .*/project: $NAME_RHS/" "$DOCS/AGENTS.md"

if [ "$MODE" = multi ]; then
  mkdir -p "$DOCS/platforms"
  for p in "${PLATFORMS[@]}"; do
    p="$(echo "$p" | tr -d '[:space:]')"
    dest="$DOCS/platforms/$p.md"
    if [ -e "$dest" ]; then
      echo "skip   docs/platforms/$p.md (exists)"
    else
      sed "s/CARAMEL_PLATFORM/$(rhs "$p")/g" "$DOCS/_templates/platform-overlay.md" > "$dest"
      echo "create docs/platforms/$p.md"
    fi
  done
  echo
  echo "Multi mode: move each core doc's 'Platform bindings' content into the matching"
  echo "overlay section, then delete the emptied headings (AGENTS.md section 6)."
else
  echo "Single mode: platform decisions stay in each core doc's trailing"
  echo "'Platform bindings - $PRIMARY' section. docs/platforms/ intentionally absent."
fi

echo
echo "Next: fill the FILL markers in docs/01-product.md, non-goals first."
