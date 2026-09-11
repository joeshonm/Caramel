# 05 — Design

Visual and interaction language. `contracts/tokens.json` is authoritative for values; this
document is authoritative for how they are used.

## Direction

<!-- FILL: two or three sentences on the intended character, with a concrete reference point.
"Dense and utilitarian, closer to Linear than to Notion" gives an agent more to work with
than "clean and modern", which is the default it would have produced anyway. -->

## Tokens

Values live in `contracts/tokens.json`. Never hardcode a colour, spacing value, radius,
elevation, or font size in component code — reference a token. If a needed token does not
exist, add it to the contract rather than inlining a literal.

The contract carries six scales: `color`, `space`, `radius`, `elevation`, `type`, `motion`.
This list and the contract's top-level keys must agree; if they diverge, the contract wins
and this line is the bug (`AGENTS.md` §3).

<!-- FILL: state the steps of each scale and what each step is for. A step with no stated
role gets used arbitrarily. If a scale is unused — a flat design needs no elevation beyond
`none` — say so explicitly rather than leaving it, or an agent will find a use for it. -->

## Typography

<!-- FILL: families, the type scale with its intended role per step, line heights, and the
rules for weight and emphasis. -->

## Colour

<!-- FILL: semantic roles rather than raw hues — surface, on-surface, primary, danger, muted.
Include the contrast floor you hold to and dark mode behaviour. -->

## Layout

<!-- FILL: grid or spacing system, breakpoints or size classes, maximum content widths,
safe-area handling. -->

## Components

<!-- FILL: the inventory an agent should build from and reuse. For each: purpose, variants,
states (default, hover, focus, active, disabled, loading, empty, error). An agent that has no
component inventory will produce a new bespoke button per screen. -->

| Component | Variants | States |
| --------- | -------- | ------ |
|           |          |        |

## Motion

<!-- FILL: durations, easing, what animates and what must not. Reduced-motion behaviour. -->

## Empty, loading, and error states

<!-- FILL: the required treatment for each. These are the states most often omitted from a
build, so specify them as first-class rather than as edge cases. State the shape, not just
the intent: skeleton or spinner, at what delay, does the error offer a retry, what occupies
the space when a list is empty. "Handle the empty state" is not implementable; "empty list
shows the section heading plus one line of muted body copy and no illustration" is. -->

## Error copy

`contracts/errors.md` is authoritative for error *codes*; this section is authoritative for
the *string a user sees* for each one. Every code in that contract needs a row here, or an
agent will invent the wording at the call site.

<!-- FILL: one row per code in contracts/errors.md. Write the string, do not describe it —
the agent copies what it sees here. Follow the rules in "Voice" below. Never surface the
API's own `message` field; it is diagnostic. -->

| Code | User-facing string | Recovery affordance |
| ---- | ------------------ | ------------------- |
| `unauthenticated` |  | |
| `forbidden` |  | |
| `not_found` |  | |
| `rate_limited` |  | |
| `internal` |  | |

## Accessibility

<!-- FILL: the floor you commit to. Minimum target sizes, focus visibility, screen reader
expectations, dynamic type support, contrast. State it as a requirement, not an aspiration. -->

## Voice

<!-- FILL: how the product talks. Sentence case or title case, person, tense, whether errors
apologise. Include two or three example strings — an agent matches examples far more reliably
than it matches adjectives. -->

---

## Platform bindings — CARAMEL_PLATFORM

<!-- Native idioms to honour, navigation chrome, platform typography defaults, gesture
conventions, per-platform token emitters. -->
