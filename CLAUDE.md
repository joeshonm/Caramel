@docs/AGENTS.md

## Claude Code

The import above is the specification for this project. Read it in full before any task.
Everything else you need is reachable from its routing table (§2) — read those documents
on demand rather than at startup, so each task loads only what it needs.

Do not import the core docs (`docs/01`–`07`) into this file. They load at launch if
imported, which defeats the routing table and spends context on documents most tasks do
not need.

The core docs carry authoring guidance in HTML comments (`<!-- FILL: … -->`). Those are
stripped from anything injected as memory, but remain visible when you open the file with
the Read tool. Read the file; do not rely on the import.

Repository conventions:

- `docs/contracts/` outranks prose in every core doc. Prose that disagrees with a contract
  is a bug to report, not a rule to follow.
- Report every assumption made where the docs were silent (`AGENTS.md` §7). Those reports
  are how the specification gets fixed.
