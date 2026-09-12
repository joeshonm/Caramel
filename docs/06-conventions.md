# 06 — Conventions

Mechanical rules. Terse on purpose — this document is consulted, not read through.

## Naming

If §Platform bindings names a language style guide, casing per construct comes from there
and is not repeated here. This section covers what a style guide does not: the project's
own vocabulary.

<!-- FILL: the domain vocabulary that must be used verbatim from `03-data.md`, and the
boolean and handler prefixes you want — most style guides, Google's TypeScript guide
included, decline to prescribe those. If no style guide is adopted, state casing per
construct here (types, functions, files, constants, test names). -->

## File and directory layout

<!-- FILL: where a new file of each kind goes. One file per what? Grouped by feature or by
type? Answer this concretely or an agent will pick a different answer each session. -->

```
src/
```

## Imports

<!-- FILL: ordering, grouping, whether relative or absolute paths, barrel files allowed or
forbidden. A style guide may settle relative-vs-absolute and leave ordering and barrels
open; answer whatever it leaves open, and say which it settled so the two are not read as
contradicting each other. -->

## Comments and documentation

<!-- FILL: what warrants a comment. Public API documentation requirements. A useful default
is: comment why, never what. -->

## Dependencies

<!-- FILL: may an agent add a dependency without asking? Answer plainly — this is the
single most common thing an agent does that nobody sanctioned. If the answer is "ask
first", say what qualifies as small enough to skip asking, or the rule gets ignored under
deadline. Name the libraries already chosen for common jobs (dates, HTTP, validation,
testing), because an agent that cannot find yours will add a second one alongside it. State
what disqualifies a candidate: unmaintained, wrong licence, too large, one-maintainer. -->

| Job | Use | Not |
| --- | --- | --- |
|     |     |     |

## Commits and branches

<!-- FILL: message format, branch naming, whether an agent may commit directly, what must
never be committed. -->

## Definition of done

<!-- FILL: the checklist that must pass before work is reported complete. Include the exact
commands to run. -->

- [ ] Builds with no new warnings
- [ ] New behaviour has a test; changed behaviour has an updated one
- [ ] Tests pass: `<command>`
- [ ] Lint and format pass: `<command>`
- [ ] Specification is self-consistent: `./scripts/check-docs.sh`
- [ ] No hardcoded design values
- [ ] Loading, empty, and error states handled
- [ ] Assumptions and gaps reported per `AGENTS.md` §7

## Anti-patterns

Owns code-level prohibitions for the whole project (`AGENTS.md` §3). Architectural
prohibitions — layering and dependency violations — live in `02-architecture.md` §Forbidden.

<!-- FILL: specific things you do not want to see, each with the correct alternative beside
it. A prohibition with no alternative gets worked around rather than obeyed. -->

| Do not | Do instead | Enforced by |
| ------ | ---------- | ----------- |
|        |            |             |

`Enforced by` is a lint rule, a formatter, a CI check, or "review only". A prohibition list
that nothing checks grows stale silently — the rules stay written down while the code drifts.

---

## Platform bindings — CARAMEL_PLATFORM

<!-- Language style guide, linter and formatter config, package manager, platform-specific
file naming. -->

### Language baseline

Name the style guide this project adopts, then record only where you deviate from it.
Do not restate its rules here: a copy drifts the moment the source is updated, and the
copy is what an agent will read. One line naming the guide, plus a table of deviations,
is the whole section.

<!-- FILL: the guide and its URL. For TypeScript the default is the Google TypeScript
Style Guide (https://google.github.io/styleguide/tsguide.html). Delete the example rows
below and replace them with your actual deviations, or write "None" if there are none. -->

**Baseline:** <guide name and URL>

| Rule | Baseline says | This project | Why |
| ---- | ------------- | ------------ | --- |
| File naming | `snake_case` | | |
| Return type annotations | Author's choice | | |
| | | | |

The baseline distinguishes requirements from preferences by keyword: **must** and
**must not** are binding, **should** and **prefer** are stylistic. Treat that split as the
default for the `Enforced by` columns elsewhere in this document — a **must** the linter
does not check is a rule that will quietly stop being true.

### What a style guide does not settle

A language style guide covers syntax and naming. It does not answer these, and an agent
will invent an answer for each one it needs:

<!-- FILL: answer each, or delete the row if genuinely not applicable. -->

| Question | Answer |
| -------- | ------ |
| Barrel files (`index.ts` re-exports): allowed or forbidden? | |
| Import ordering and grouping: enforced how? | |
| One exported thing per file, or many? | |
| Where do shared types live? | |
| `any` — permitted anywhere, or never? | |

### CSS

Applies to any project that ships stylesheets, whatever the framework.

**Architectural principles, always in force.** Source: CSS Guidelines
(https://cssguidelin.es), Harry Roberts. These hold regardless of how the project scopes
its styles, and most are mechanically satisfied by a utility-first or component-scoped
setup rather than requiring discipline:

- Keep specificity as low as possible. Do not nest, qualify, or chain selectors.
- No IDs in CSS. They are non-reusable and create specificity anomalies that later rules
  can only beat with worse ones. IDs in HTML and JavaScript are fine.
- `!important` proactively only — on a utility whose whole purpose is to win. Reactive
  `!important`, added to defeat a rule you did not expect, means the architecture is
  already wrong; fix the specificity instead.
- One responsibility per rule. Compose small rules rather than extending large ones.

**Scoping strategy — declare exactly one.** BEM naming, utility-first, CSS Modules, and
framework-scoped styles all solve the same problem: making it impossible for one
component's styles to leak into another. A project needs one of them. Running two is the
failure this section exists to prevent, and it happens by accident — a utility-first
project acquires a hand-written stylesheet, and neither convention holds any more.

caramel does not prescribe which. It does require that you name it, because an agent with
no scoping rule invents one per component.

<!-- FILL: name the strategy and what it means concretely here. If utility-first, say
which utilities are permitted and when a component class is warranted instead. If BEM or
another naming convention, state the syntax. If the framework scopes styles for you, say
so and say what happens when a style must escape that scope — that exception is where
leakage starts. -->

**Scoping strategy:** <one of: BEM | utility-first | CSS Modules | framework-scoped | other>

Design *values* — colour, spacing, radius, elevation, type — are not settled here.
`05-design.md` §Tokens owns them, and `contracts/tokens.json` is authoritative. This
section governs how CSS is written; that one governs what values it may contain.
