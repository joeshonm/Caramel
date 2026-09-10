# ADR-0001 — Agent-facing documentation structure

- **Status:** accepted
- **Date:** 2026-09-10
- **Affects:** all core docs, `AGENTS.md`

## Context

These documents are read primarily by coding agents, which fail in two specific ways.
Given one large document, an agent loads several thousand tokens of mostly irrelevant
context and drifts. Given arbitrarily split documents, it cannot tell which file answers
the question in front of it, so it reads all of them or none.

Agents also treat silence as permission. Any decision absent from the specification will
be invented, plausibly and inconsistently, and the invention will be indistinguishable
from a specified choice once it is in the code.

## Decision

Documentation is a resolution system rather than a document: a single mandatory entry
point (`AGENTS.md`) carrying a routing table and an explicit conflict-resolution order,
platform-neutral core docs, and platform content held either in a trailing
`## Platform bindings` section (`single` mode) or in per-platform overlays (`multi` mode).

Every fact lives in exactly one place. Overlays contain deltas only and must declare any
override by name. Machine-readable contracts outrank prose.

## Alternatives considered

| Alternative | Why not |
| ----------- | ------- |
| One `ARCHITECTURE.md` | Context bloat per task; agent drift; merge contention |
| Split by platform first, shared second | Duplicates every invariant N times; the copies diverge silently |
| Split by feature | Invariants get restated per feature and disagree within a release |
| Prose-only, no contracts | Endpoints and design values drift from their implementations with nothing to arbitrate |

## Consequences

Makes easy: bounded reads per task; unambiguous conflict resolution; adding a platform
without touching invariants; auditing what is genuinely platform-specific.

Makes hard, and this is the real cost: the invariant/binding split is a discipline. Sorting
each claim into "true everywhere" or "true because of this platform" is a judgement call
made on every write. Skipped, `single` mode degrades into a flat document and the promotion
procedure in `AGENTS.md` §6 buys nothing. A project certain to stay single-platform forever
could reasonably drop the convention and accept the flat form.

## Revisit when

Overlays begin accumulating declared overrides against the same core sections — that is
evidence the "invariant" claim was never invariant and belongs in the overlays outright.
