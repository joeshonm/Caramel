# 05 — Design

Visual and interaction language. `contracts/tokens.json` is authoritative for values; this
document is authoritative for how they are used.

## Direction

<!-- FILL: two or three sentences on the intended character, with a concrete reference point.
"Dense and utilitarian, closer to Linear than to Notion" gives an agent more to work with
than "clean and modern", which is the default it would have produced anyway. -->

## Tokens

Values live in `contracts/tokens.json`. Never hardcode a colour, spacing value, radius, or
font size in component code — reference a token. If a needed token does not exist, add it to
the contract rather than inlining a literal.

<!-- FILL: name the scales you use and their steps: spacing, radius, elevation, type. -->

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
build, so specify them as first-class rather than as edge cases. -->

## Accessibility

<!-- FILL: the floor you commit to. Minimum target sizes, focus visibility, screen reader
expectations, dynamic type support, contrast. State it as a requirement, not an aspiration. -->

## Voice

<!-- FILL: how the product talks. Sentence case or title case, person, tense, whether errors
apologise. Include two or three example strings — an agent matches examples far more reliably
than it matches adjectives. -->

---

## Platform bindings — PLATFORM

<!-- Native idioms to honour, navigation chrome, platform typography defaults, gesture
conventions, per-platform token emitters. -->
