# 02 — Architecture

Structure and dependency rules. Claims above the bindings section are intended to hold
for any client of this product.

## Stack

The language, runtime, and framework everything else assumes. Record what you chose and
the constraint that forced it — a choice with no stated reason gets relitigated every time
someone new arrives, agent or human.

`decisions/ADR-0003` describes how to select one if the choice is still open. Once made,
the answer lives here and the ADR is only rationale.

<!-- FILL: language, runtime, framework, and the one constraint that decided it. Name the
constraint, not the preference: "non-technical editors need a draft preview" is a reason,
"it is the modern choice" is not. If a serious alternative was rejected, say which and why
in one line, or an agent will propose it again. -->

| Choice | What | Because |
| ------ | ---- | ------- |
| Language / runtime |  |  |
| Framework |  |  |
| Rejected alternative |  |  |

## Shape

<!-- FILL: name the pattern and its layers in one short list. Do not describe an
architecture you are not going to enforce. -->

| Layer | Responsibility | May depend on | Enforced by |
| ----- | -------------- | ------------- | ----------- |
|       |                |               |             |

`Enforced by` is a lint rule, a CI check, a compiler boundary, or the honest answer
"review only". A rule nobody checks is a preference, and an agent will eventually treat it
as one. Writing "review only" is fine; leaving the cell blank is not.

## Dependency rules

<!-- FILL: the rules that make the table above real. Be absolute; an agent will honour a
hard rule and negotiate with a soft one. -->

- Dependencies point in one direction: …
- The domain layer imports no framework, platform, or transport types.
- Cross-module access goes through a module's public surface only.

## Module map

<!-- FILL: every top-level module, one line each: what it owns and what it must never know
about. This is the single most useful section for preventing an agent from putting code in
a plausible-but-wrong place. -->

| Module | Owns | Must not know about | Enforced by |
| ------ | ---- | ------------------- | ----------- |
|        |      |                     |             |

## Composition and dependency injection

<!-- FILL: how are dependencies supplied? Where is the wiring done? What is constructed at
startup vs lazily? An agent needs this to add a new service without inventing a second
pattern alongside yours. -->

## Concurrency model

<!-- FILL: what runs off the main thread, what is forbidden on it, how cancellation works,
what "done" means for a background task. -->

## Error strategy

Owns the recoverable/fatal split and the conversion boundary only. What a user sees when a
request fails is owned by `04-networking.md` §Error handling (`AGENTS.md` §3).

<!-- FILL: which errors are recoverable and which are fatal. Where is the boundary that
converts low-level failures into domain errors? What crashes the process, and what is
caught? Do not specify user-facing behaviour here. -->

## Testing strategy

<!-- FILL: what must be tested and at which layer. Name the seams that make testing
possible. State what you deliberately do not test. -->

## Forbidden

Architectural prohibitions only — violations of the layering and dependency rules above.
General code prohibitions belong in `06-conventions.md` §Anti-patterns, which owns them
(`AGENTS.md` §3). If a rule is not about layering, put it there.

<!-- FILL: the architectural patterns that are out of bounds regardless of convenience.
Business logic in view code, direct network calls from UI, a module reaching past a public
surface. Explicit prohibitions outperform implied ones. -->

---

## Platform bindings — CARAMEL_PLATFORM

<!-- Framework choice, project/target layout, build system, module boundaries the platform
imposes, lifecycle and process model, threading primitives. -->
