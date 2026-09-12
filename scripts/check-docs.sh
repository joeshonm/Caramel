#!/usr/bin/env bash
# Verify the specification is internally consistent.
#
#   ./scripts/check-docs.sh
#
# Exits zero when every claim below holds, non-zero with a report when one does not.
# 07-buildplan.md requires a gate to be "a command that exits zero, or an observable
# behaviour someone can check". This is that command for the specification itself.
#
# What it checks, and why each one is here rather than invented:
#   1. Every `NN-name.md` §Section reference resolves to a heading that exists.
#      (contracts/errors.md pointed at a 05-design.md section that did not exist.)
#   2. Every contracts/, decisions/, and reference/ path referenced actually exists.
#   3. 05-design.md's list of token scales matches contracts/tokens.json's keys.
#      (The prose named an `elevation` scale the contract did not carry.)
#   4. Every error code in contracts/errors.md has a row in 05-design.md §Error copy.
#   5. contracts/tokens.json parses, and openapi.yaml parses if a YAML parser is present.
#   6. Every core doc named in the AGENTS.md routing table exists.
#   7. CLAUDE.md plus its import stays under the stated line ceiling.

set -uo pipefail
cd "$(dirname "$0")/.."

FAIL=0
note() { printf '  %s\n' "$1"; }
fail() { printf 'FAIL  %s\n' "$1"; FAIL=1; }
pass() { printf 'ok    %s\n' "$1"; }

LINE_CEILING=200

# ---------------------------------------------------------------- 1 + 2. references
python3 - <<'PY' || FAIL=1
import re, sys, pathlib

docs = pathlib.Path("docs")
md = sorted(docs.rglob("*.md"))
# _templates holds placeholder text, not live references.
md = [p for p in md if "_templates" not in p.parts]

headings = {}
for p in md:
    headings[p.name] = {
        line.lstrip("#").strip()
        for line in p.read_text().splitlines()
        if line.startswith("#")
    }

bad = []
# `NN-name.md` optionally followed by §Section (bare or "quoted").
ref = re.compile(r'`((?:\d{2}-[a-z]+|AGENTS)\.md)`(?:\s+§("?)([A-Za-z][A-Za-z -]*?)\2(?=[\s,.;:]|$))?')
def live_lines(path):
    """Yield (lineno, text), skipping fenced blocks: examples are not references."""
    fenced = False
    for n, line in enumerate(path.read_text().splitlines(), 1):
        if line.lstrip().startswith("```"):
            fenced = not fenced
            continue
        if not fenced:
            yield n, line

for p in md:
    for n, line in live_lines(p):
        for doc, _q, sec in ref.findall(line):
            if doc not in headings:
                bad.append(f"{p}:{n} -> {doc} does not exist")
                continue
            if not sec:
                continue
            sec = sec.strip()
            # Trailing prose can bleed into a bare reference; accept a prefix match.
            if not any(h == sec or h.startswith(sec) or sec.startswith(h)
                       for h in headings[doc]):
                bad.append(f'{p}:{n} -> {doc} has no section "{sec}"')

path_ref = re.compile(r'`((?:contracts|decisions|reference)/[A-Za-z0-9._-]+)`')
for p in md:
    for n, line in live_lines(p):
        for rel in path_ref.findall(line):
            rel = rel.rstrip(".")
            target = docs / rel
            if target.exists():
                continue
            # ADR references are often written without the full slug.
            if rel.startswith("decisions/ADR-") and list((docs/"decisions").glob(rel.split("/")[1] + "*")):
                continue
            bad.append(f"{p}:{n} -> {rel} does not exist")

if bad:
    print("FAIL  cross-references")
    for b in bad:
        print("  " + b)
    sys.exit(1)
print("ok    cross-references resolve")
PY

# ---------------------------------------------------------------- 3 + 4. contracts vs prose
python3 - <<'PY' || FAIL=1
import json, re, sys, pathlib

problems = []
tokens = json.loads(pathlib.Path("docs/contracts/tokens.json").read_text())
scales = {k for k in tokens if not k.startswith("$")}
design = pathlib.Path("docs/05-design.md").read_text()

m = re.search(r'contract carries \w+ scales?: (.+?)\.', design, re.S)
if not m:
    problems.append("05-design.md no longer states which token scales the contract carries")
else:
    named = set(re.findall(r'`([a-z]+)`', m.group(1)))
    if named != scales:
        for extra in sorted(named - scales):
            problems.append(f"05-design.md names token scale `{extra}` that tokens.json lacks")
        for missing in sorted(scales - named):
            problems.append(f"tokens.json has scale `{missing}` that 05-design.md does not name")

codes = set(re.findall(r'^\| `([a-z_]+)` \|', pathlib.Path("docs/contracts/errors.md").read_text(), re.M))
copy = design.split("## Error copy", 1)
if len(copy) == 1:
    problems.append("05-design.md has no Error copy section; contracts/errors.md points at one")
else:
    listed = set(re.findall(r'^\| `([a-z_]+)` \|', copy[1], re.M))
    for c in sorted(codes - listed):
        problems.append(f"error code `{c}` has no row in 05-design.md Error copy")

if problems:
    print("FAIL  contracts vs prose")
    for p in problems:
        print("  " + p)
    sys.exit(1)
print("ok    contracts agree with prose")
PY

# ---------------------------------------------------------------- 5. contracts parse
python3 -c "import json;json.load(open('docs/contracts/tokens.json'))" 2>/dev/null \
  && pass "tokens.json parses" || fail "tokens.json does not parse"

if python3 -c "import yaml" 2>/dev/null; then
  python3 -c "import yaml;yaml.safe_load(open('docs/contracts/openapi.yaml'))" 2>/dev/null \
    && pass "openapi.yaml parses" || fail "openapi.yaml does not parse"
else
  note "skip  openapi.yaml (no yaml module)"
fi

# ---------------------------------------------------------------- 6. routing targets
missing=$(grep -oE '`[0-9]{2}-[a-z]+\.md`' docs/AGENTS.md | tr -d '`' | sort -u |
  while read -r f; do [ -f "docs/$f" ] || echo "$f"; done)
if [ -n "$missing" ]; then
  fail "routing table names documents that do not exist"
  echo "$missing" | while read -r f; do note "$f"; done
else
  pass "routing table targets exist"
fi

# ---------------------------------------------------------------- 7. line budget
lines=$(cat CLAUDE.md docs/AGENTS.md | wc -l | tr -d ' ')
if [ "$lines" -gt "$LINE_CEILING" ]; then
  fail "CLAUDE.md plus its import is $lines lines, over the $LINE_CEILING ceiling"
  note "adherence drops as this grows; move reference material out rather than raising it"
else
  pass "CLAUDE.md plus its import is $lines lines (ceiling $LINE_CEILING)"
fi

echo
[ "$FAIL" -eq 0 ] && echo "specification is internally consistent." \
                  || echo "specification has inconsistencies; see above."
exit "$FAIL"
