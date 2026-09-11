# caramel

A base template for agent-facing architecture documentation. Copy this repository to start
a new project, run the init script, fill in the docs, then point your coding agent at
`docs/AGENTS.md`.

The design rationale is in `docs/decisions/ADR-0001-agent-facing-doc-structure.md`.

## Layout

```
CLAUDE.md              import shim — Claude Code reads this, not AGENTS.md
docs/
  AGENTS.md            entry point — routing table, resolution order, scope rules
  01-product.md        scope, users, non-goals
  02-architecture.md   layers, dependency rules, module map
  03-data.md           domain model, ownership, state
  04-networking.md     transport, auth, errors, retries
  05-design.md         tokens, components, voice
  06-conventions.md    naming, layout, definition of done
  07-buildplan.md      milestones with executable gates
  contracts/           machine-readable sources of truth
  decisions/           ADRs — why the core docs say what they say
  _templates/          platform overlay and ADR skeletons
scripts/
  init-project.sh      stamp project name and platforms into a fresh copy
```

## Two modes

Docs `01`–`07` hold claims intended to be true for any client. Platform-specific decisions
live in one of two places depending on how many platforms you have:

**`single`** — platform decisions go in the trailing `## Platform bindings — <platform>`
section of each core doc. `docs/platforms/` does not exist.

**`multi`** — those sections are cut into `docs/platforms/<platform>.md`, one overlay per
platform, containing deltas only. An agent loads exactly one.

`docs/AGENTS.md` §1 declares which mode is active, and that declaration is what lets one
structure serve both cases: it tells the agent whether a missing overlay is a problem or
the expected state.

Start in `single` even if you expect to expand. Keeping the bindings section filled in as
you go costs nothing at write time and makes `AGENTS.md` §6 promotion a cut-and-paste
instead of an excavation.

## Getting started

```sh
git clone <this> my-project && cd my-project
./scripts/init-project.sh my-project web     # or: ios | android | desktop | "web,ios"
```

Then fill in the `<!-- FILL -->` markers, starting with `01-product.md` — particularly its
non-goals, which is the section that does the most work in keeping an agent's scope honest.

Two placeholders need a real toolchain before they mean anything, so deal with them once
you have chosen one:

- **`07-buildplan.md` milestone gates.** The doc requires each gate to be a command that
  exits zero or an observable behaviour. The shipped milestones are placeholders; a gate
  an agent cannot execute cannot tell it whether a milestone is done.
- **`06-conventions.md` "definition of done".** It references commands that do not exist
  yet. Replace them with your real test, lint, and build invocations.

## Using it

Point your agent at `docs/AGENTS.md` and require that it read the file in full before
anything else. Everything else it needs is reachable from there.

Two habits keep this useful over time. Treat an agent's reported assumptions as a to-do
list for the docs — every assumption is a place the specification was silent. And when you
find yourself correcting the same thing twice in review, the fix belongs in `06-conventions.md`
rather than in another review comment.

## A note on Claude Code

Claude Code loads `CLAUDE.md` from the project root at session start; it does not read
`AGENTS.md`. The root `CLAUDE.md` here is a one-line `@docs/AGENTS.md` import plus a few
Claude Code-specific notes, which keeps a single specification serving both Claude Code and
any other agent that looks for `AGENTS.md`.

Two things to avoid: importing the core docs into `CLAUDE.md` (imports load at launch, which
defeats the routing table and spends context on documents most tasks don't need), and
letting `CLAUDE.md` plus its import grow past ~200 lines, where adherence starts to drop.
The current pair is about 160.

Verify it loaded with `/context` in a session and check the **Memory files** list.

Source: https://code.claude.com/docs/en/memory
