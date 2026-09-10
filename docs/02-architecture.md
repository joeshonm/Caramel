# 02 — Architecture

Structure and dependency rules. Claims above the bindings section are intended to hold
for any client of this product.

## Shape

<!-- FILL: name the pattern and its layers in one short list. Do not describe an
architecture you are not going to enforce. -->

| Layer | Responsibility | May depend on |
| ----- | -------------- | ------------- |
|       |                |               |

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

| Module | Owns | Must not know about |
| ------ | ---- | ------------------- |
|        |      |                     |

## Composition and dependency injection

<!-- FILL: how are dependencies supplied? Where is the wiring done? What is constructed at
startup vs lazily? An agent needs this to add a new service without inventing a second
pattern alongside yours. -->

## Concurrency model

<!-- FILL: what runs off the main thread, what is forbidden on it, how cancellation works,
what "done" means for a background task. -->

## Error strategy

<!-- FILL: which errors are recoverable, which crash, which surface to the user and how.
Where is the boundary that converts low-level failures into domain errors? -->

## Testing strategy

<!-- FILL: what must be tested and at which layer. Name the seams that make testing
possible. State what you deliberately do not test. -->

## Forbidden

<!-- FILL: patterns that are out of bounds regardless of convenience. Singletons for mutable
state, business logic in view code, direct network calls from UI, whatever you have been
bitten by. Explicit prohibitions outperform implied ones. -->

---

## Platform bindings — PLATFORM

<!-- Framework choice, project/target layout, build system, module boundaries the platform
imposes, lifecycle and process model, threading primitives. -->
