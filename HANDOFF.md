# Handoff

Context from the claude.ai session that produced this repository. Delete this file once
the open items below are resolved; it is scaffolding, not documentation.

## What this repository is

A reusable base template for architecture documentation written to be consumed by coding
agents, not primarily by humans. It is documentation only — no application source yet.

The full rationale, including its cost, is in
`docs/decisions/ADR-0001-agent-facing-doc-structure.md`. The short version: agents fail
either by loading one huge document and drifting, or by not knowing which of many files
answers the question in front of them. So the docs are a resolution system — one mandatory
entry point with a routing table and an explicit conflict-resolution order — rather than a
document.

## Design decisions worth not re-litigating

**Invariant core plus platform deltas.** Docs `01`–`07` hold claims intended to be true for
any client. Platform-specific decisions live either in each core doc's trailing
`## Platform bindings — <platform>` section (`single` mode) or in `docs/platforms/<p>.md`
overlays (`multi` mode). `AGENTS.md` §1 declares which mode is active. That declaration is
what lets one structure serve both cases: it tells the agent whether a missing overlay is a
problem or the expected state.

**`mode: UNSET` is a deliberate tripwire.** A fresh copy declares no platform and
`AGENTS.md` instructs the agent to stop rather than infer one. Without it, an agent handed
an uninitialised template will guess a platform from the first request and write code
against assumptions nobody made.

**Overrides must be declared by name.** An overlay contradicting a core doc without saying
so is a documentation bug; the core doc wins and the conflict gets reported. Being
platform-specific is not by itself permission to diverge.

**Overlays may not reference each other.** No "same as web, except…". This is the rule that
stops two overlays from becoming two independent, drifting specifications.

**Contracts outrank prose.** `docs/contracts/` is machine-readable and shared by every
platform. Prose disagreeing with it is a bug.

## State

- One commit, tagged `template-v0.1.0`, plus whatever added `CLAUDE.md` and this file.
- `scripts/init-project.sh` tested in both modes: `init-project.sh notebook web` produces
  single mode with no `platforms/` directory; `init-project.sh atlas web,ios` generates both
  overlays and prints the reminder that cutting bindings across is manual.
- `contracts/tokens.json` and `contracts/openapi.yaml` both parse. Contents are stubs.
- Every core doc is a skeleton of headings plus `<!-- FILL: … -->` guidance. The structural
  content (resolution rules, ADR-0001, the contracts' rules) is real and intended to be kept.

## Open items

1. **Not yet initialised.** `AGENTS.md` §1 still reads `mode: UNSET`. Decide whether this
   checkout is the reusable template or the first real project. If it is the template, leave
   it uninitialised and copy it per project.
2. **Untested promotion path.** `AGENTS.md` §6 single→multi promotion has been executed only
   as far as the script automates it (steps 2–4). Step 1, cutting bindings sections into
   overlays, and step 5, re-checking that remaining claims are genuinely platform-neutral,
   have never been run against filled-in docs. Expect to refine the procedure the first time.
3. **Milestone gates are placeholders.** `07-buildplan.md` demands gates that are commands
   exiting zero or observable behaviour. None exist yet because there is no build.
4. **`06-conventions.md` "definition of done" references commands that do not exist.** Fill
   in real ones when a toolchain is chosen.

## Suggested first move

Fill in `01-product.md` before anything else, and make the non-goals specific. That single
section prevents more agent scope drift than the rest of the core docs together — without
it, an agent will add multi-tenancy, offline sync, i18n, and a plugin system to a
single-user note app, helpfully and consistently.
