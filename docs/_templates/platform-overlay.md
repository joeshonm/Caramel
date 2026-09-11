# Platform overlay — CARAMEL_PLATFORM

Deltas only. Anything true for every platform belongs in a core doc, not here.

**Rules for this file** (`AGENTS.md` §4–5):

- A contradiction of a core doc must be declared by name, or it is a documentation bug.
- Never reference another overlay. No "same as web, except…".
- Headings below mirror the core docs so provenance stays obvious. Delete unused ones.

---

## From 01-product.md

<!-- Platform-specific scope: store requirements, support floor, install friction. -->

## From 02-architecture.md

<!-- Framework, project layout, build system, lifecycle, threading primitives. -->

## From 03-data.md

<!-- Storage engine, encryption at rest, background refresh limits, quotas. -->

## From 04-networking.md

<!-- HTTP client, pinning, auth transport, CORS, background transfer, connectivity API. -->

## From 05-design.md

<!-- Native idioms, navigation chrome, gestures, token emitter. -->

## From 06-conventions.md

<!-- Style guide, linter, formatter, package manager. -->

## From 07-buildplan.md

<!-- Toolchain, signing, targets, distribution, platform-specific gates. -->

---

## Declared overrides

<!-- Every override, collected here as well as inline, so the divergence surface is visible
in one place. If this list grows long, the core doc is probably wrong. -->

- None.
