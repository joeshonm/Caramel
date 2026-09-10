# 07 — Build plan

Order of work with verifiable gates. An agent should be able to determine, without asking,
whether a milestone is complete.

## Rules

- Milestones are sequential. Do not start one before the previous milestone's gate passes.
- A gate is a command that exits zero, or an observable behaviour someone can check. Not an
  opinion about completeness.
- If a gate cannot pass for a reason outside the milestone's scope, stop and report. Do not
  widen scope to make a gate pass.

## M0 — Walking skeleton

<!-- FILL. The goal is one trivial path running end to end through every layer before any
feature work. It surfaces integration problems while they are still cheap. -->

**Deliverable:**
**Gate:**

## M1 — <name>

**Deliverable:**
**Gate:**

## M2 — <name>

**Deliverable:**
**Gate:**

## Deferred

<!-- FILL: work that is real but explicitly not now. Keeping it visible here stops an agent
from either implementing it early or assuming it was forgotten. -->

---

## Platform bindings — PLATFORM

<!-- Toolchain setup, signing, simulator/emulator/browser targets, distribution steps,
platform-specific milestone gates. -->
