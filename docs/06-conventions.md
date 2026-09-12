# 06 — Conventions

Mechanical rules. Terse on purpose — this document is consulted, not read through.

## Naming

<!-- FILL: casing per construct (types, functions, files, constants, test names), and the
domain vocabulary that must be used verbatim from `03-data.md`. Include the boolean and
handler prefixes you want. -->

## File and directory layout

<!-- FILL: where a new file of each kind goes. One file per what? Grouped by feature or by
type? Answer this concretely or an agent will pick a different answer each session. -->

```
src/
```

## Imports

<!-- FILL: ordering, grouping, whether relative or absolute paths, barrel files allowed or
forbidden. -->

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
- [ ] Tests pass: `<command>`
- [ ] Lint and format pass: `<command>`
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
