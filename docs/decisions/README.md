# decisions/

Why the core docs say what they say. Rationale, not authority: `decisions/` explains the
core docs and never outranks them (`AGENTS.md` §3).

- One file per decision, `ADR-NNNN-kebab-title.md`, numbered sequentially.
- Never edit an accepted ADR to change its outcome. Write a new one and mark the old
  superseded.
- When a core doc changes for a non-obvious reason, add an ADR. Agents asked to reverse a
  decision read this directory first.

Start from `../_templates/ADR-template.md`.
