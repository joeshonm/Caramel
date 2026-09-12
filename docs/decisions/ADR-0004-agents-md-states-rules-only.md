# ADR-0004 — `AGENTS.md` states rules; this directory explains them

- **Status:** accepted
- **Date:** 2026-09-12
- **Affects:** `AGENTS.md`, `CLAUDE.md`

## Context

`AGENTS.md` is read in full before every task, so every line in it is paid for on every
task. It had accumulated two kinds of content that do not earn that price.

The first is justification. Rules were stated and then argued for — the scope-boundary rule
carried "'I refactored the shared helper while I was in there' is the failure this rule
exists to prevent", and the resolution order explained why improvisation is costly. The
writing is good and the reasoning is real, but a rule and the argument for it are different
artifacts with different audiences. An agent applying a rule needs the rule.

The second is duplication. "Contracts outrank prose" appeared in `CLAUDE.md`, in
`AGENTS.md` §3, and in `contracts/README.md`. Assumption reporting appeared in `CLAUDE.md`
and in §7. Because `CLAUDE.md` imports `AGENTS.md`, both copies loaded together on every
task, so the repetition cost context without adding information — and three prose copies of
one rule can drift apart without `check-docs.sh` noticing, since it verifies references
rather than meaning.

## Decision

`AGENTS.md` states rules. `decisions/` explains them. A rule that needs defending gets an
ADR; the rule itself stays one sentence.

`CLAUDE.md` contains only what is true of Claude Code specifically and is not stated in
`AGENTS.md`. It does not restate repository rules, because it imports the document that
owns them.

Where a rule's reasoning is genuinely load-bearing — where an agent that does not
understand *why* will misapply the rule — the reasoning stays. The test is whether removing
it changes behaviour, not whether it is interesting.

## Recorded rationale

The justifications removed from `AGENTS.md`, preserved because they explain decisions that
are still in force:

**Why a task scoped to one platform may not touch another platform's source tree.** The
failure is not malice but helpfulness: an agent fixing something in one platform notices a
shared helper that would be cleaner if refactored, refactors it, and silently changes
behaviour for platforms it was never asked to consider and cannot test. "I refactored the
shared helper while I was in there" is the failure the rule prevents. The rule is absolute
because the judgement call — is this change small enough to be safe? — is exactly the one
an agent is worst positioned to make.

**Why overlays may not reference each other.** "Same as web, except…" reads as economical.
It creates a dependency that nobody maintains: when the web overlay changes, the iOS
overlay silently describes something that no longer exists. Two overlays that reference each
other become two independent specifications that agree only by coincidence.

**Why an absent decision means stopping rather than choosing.** An agent treats silence as
permission. A decision absent from the specification will be invented — plausibly,
consistently, and indistinguishably from a specified one once it is in the code. A wrong
guess written into code costs more than a question, because the question is answered in a
minute and the guess is discovered in a month.

**Why the routing table is binding despite being unenforceable.** No tool checks that an
agent consulted it. Work produced by an agent that read everything looks the same as work
produced by one that routed correctly — until the wasted context turns out to be context
the task needed.

## Alternatives considered

| Alternative | Why not |
| ----------- | ------- |
| Leave the justifications in place | They are paid for on every task, including the majority that never touch the rule being justified |
| Delete them outright | The reasoning is real and some of it is not obvious; an ADR costs nothing to keep |
| Move them to inline HTML comments | Comments are stripped from the memory injection but still consume the file when read directly, which is the case that matters |

## Consequences

Makes easy: a shorter document that is read in full more reliably; one home for each rule;
reasoning that survives without being re-paid for on every task.

Makes hard, and this is the cost: a rule separated from its reason is easier to dismiss as
arbitrary. An agent reading "do not modify another platform's source tree" without the
refactoring example may weigh it as a preference. The mitigation is that the rules stayed
imperative and absolute in tone; the risk is real anyway.

## Revisit when

A rule stripped of its justification gets misapplied, or an agent reports a rule as
arbitrary. That is evidence the reasoning was load-bearing and belongs back inline.
