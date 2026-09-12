@docs/AGENTS.md

## Claude Code

The import above is the specification for this project. Read it in full before any task.
Everything else you need is reachable from its routing table (§2) — read those documents
on demand rather than at startup, so each task loads only what it needs.

Do not import the core docs (`docs/01`–`07`) into this file. They load at launch if
imported, which defeats the routing table and spends context on documents most tasks do
not need.

The core docs carry authoring guidance in HTML comments (`<!-- FILL: … -->`), which are
stripped from the memory injection but visible via the Read tool. Open the file; do not
rely on the import.

Repository rules live in the imported specification, not here. This file holds only what
is specific to Claude Code (ADR-0004).
