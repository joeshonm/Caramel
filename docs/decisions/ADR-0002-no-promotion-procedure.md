# ADR-0002 — No single-to-multi promotion procedure

- **Status:** accepted
- **Date:** 2026-09-11
- **Affects:** `AGENTS.md` §6, `README.md`, `scripts/init-project.sh`
- **Amends:** ADR-0001 (the invariant/binding split stands; only the migration procedure is withdrawn)

## Context

`AGENTS.md` §6 documented a five-step procedure for promoting a `single`-mode project to
`multi`. Steps 2–4 are what `init-project.sh` already automates. Step 1 — cutting each core
doc's bindings section into an overlay — and step 5 — re-reading every remaining claim to
check it is genuinely platform-neutral — had never been executed against filled-in docs, only
against the empty skeleton. §6 therefore shipped carrying a caveat saying it might not work.

ADR-0001 §Consequences cites the procedure as part of what the invariant/binding discipline
buys. That claim was never tested.

A documented procedure an agent can follow mechanically, attached to a warning that it is
unverified, is worse than no procedure. The warning is prose; the steps are imperative. An
agent follows the steps.

## Decision

There is no promotion procedure. `AGENTS.md` §6 states what changing the platform list
involves and says explicitly that it is done by hand because the work is judgement.

The two modes remain. The invariant/binding split remains. Only the automated migration
path between them is withdrawn.

## Alternatives considered

| Alternative | Why not |
| ----------- | ------- |
| Keep §6 and test it against filled-in docs | Would validate it, but no project needs promotion yet; testing a procedure against a throwaway project proves it works for throwaway projects |
| Keep §6 with its caveat | Ships imperative steps under an advisory warning. The steps win |
| Drop `multi` mode entirely | The overlay split is the part that earns its keep with two real platforms; only the migration was unproven |

## Consequences

Makes easy: §6 no longer promises more than it has demonstrated. One fewer unverified path
for an agent to execute confidently.

Makes hard, and this is the cost: a project that does outgrow `single` mode gets no
checklist. It gets a description of the work and a warning that the hard part is judgement.
Someone will have to think it through the first time, and whatever they learn is not
captured anywhere until they write it down.

Revisit when a real project performs the migration — at that point the procedure can be
written from evidence rather than from theory.

## Revisit when

Any project actually promotes from `single` to `multi`. Write the procedure from what
happened, and supersede this ADR.
