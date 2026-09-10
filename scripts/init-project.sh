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

echo "Project : $NAME"
echo "Platform: $LIST"
echo "Mode    : $MODE"
echo

find "$DOCS" -type f \( -name '*.md' -o -name '*.yaml' -o -name '*.json' -o -name '*.sql' \) \
  -not -path "$DOCS/_templates/*" -print0 |
  while IFS= read -r -d '' f; do
    sedi "s/caramel/$NAME/g" "$f"
    sedi "s/PLATFORM/$PRIMARY/g" "$f"
  done

sedi "s/^platforms: .*/platforms: [$LIST]/" "$DOCS/AGENTS.md"
sedi "s/^mode: .*/mode: $MODE/" "$DOCS/AGENTS.md"
sedi "s/^project: .*/project: $NAME/" "$DOCS/AGENTS.md"

if [ "$MODE" = multi ]; then
  mkdir -p "$DOCS/platforms"
  for p in "${PLATFORMS[@]}"; do
    p="$(echo "$p" | tr -d '[:space:]')"
    dest="$DOCS/platforms/$p.md"
    if [ -e "$dest" ]; then
      echo "skip   docs/platforms/$p.md (exists)"
    else
      sed "s/PLATFORM/$p/g" "$DOCS/_templates/platform-overlay.md" > "$dest"
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
