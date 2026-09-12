# ADR-0003 — How a project selects its stack

- **Status:** accepted
- **Date:** 2026-09-11
- **Affects:** `02-architecture.md` §Stack

## Context

`02-architecture.md` assumed the framework was already known. Nothing prompted anyone to
choose one or to record why, so the largest architectural decision a project makes was the
one the specification never asked about.

The obvious fix — a table scoring frameworks against project types — fails for two reasons.
It dates immediately: verifying the comparison below turned up three frameworks widely
believed to have shipped that had not, and a major release roughly six weeks out. And it
answers the wrong question. Scores rank options; they do not say which options were
admissible in the first place.

Size is also the wrong primary axis. "Small, medium, large" is an output of the decision
rather than an input, and it changes over a project's life while the framework does not. A
small site with a non-technical editor has more in common with a large CMS-driven site than
with a small developer-maintained one.

## Decision

Stack selection runs as an elimination funnel. Earlier stages remove options; only the last
stage ranks what survives.

**1. Hard constraints eliminate.** Each of these removes whole categories, and each is a
fact about the project rather than a preference:

| Constraint | Eliminates |
| ---------- | ---------- |
| Must work offline | Server-rendered hypermedia (Livewire, LiveView, htmx-style) |
| Real-time multi-user editing of shared documents | Everything until a sync engine is chosen; pick that first, the framework second |
| Must run on-prem, air-gapped, or in a named region | Anything whose happy path is one vendor's edge network |
| Continuous high-frequency input — drag, canvas, games | Server round-trip-per-event architectures |
| Crawlers, link unfurlers, or LLM readers must read it without running JS | Client-only rendering |

**2. Interactivity topology selects the category.** The question is whether interactive
state is *locally* scoped — mostly static markup with isolated controls — or *globally*
scoped, where one change updates half the page. Static, islands of local state, shared
client state, and real-time multi-user are four different architectures. Project size does
not predict which one applies.

**3. Content authority and indexability select the rendering model, per route.** Who edits,
and do they write code? A non-technical editor forces a CMS and, more importantly, a
draft/preview workflow — the requirement teams discover last. Rendering is a per-route
decision: marketing pages, product pages, search, and an authenticated dashboard can each
want a different model. A framework's real differentiator is whether it lets you mix them.

**4. Rank the survivors.** Only here do comparisons apply, and the tiebreakers are:
reversal cost (below), maintenance burden for whoever actually maintains it, and fitness
for how the code will be written.

### Reversal cost is layered, so apply caution unevenly

| Cost | What |
| ---- | ---- |
| Days | Styling, component library, build tool, deploy target |
| Weeks | Swapping meta-framework within the same UI library |
| Months | Changing the UI library itself |
| Effectively permanent | Rendering model baked into data-fetching; hosting-coupled framework features; the language/runtime boundary |

Be conservative where reversal is expensive and experimental where it is cheap. Betting on
the infrastructure layer is safer than betting on the framework layer.

### Agent fitness and human fitness diverge — choose deliberately

They do not rank the same, and this ADR does not resolve it for you. The framework with the
highest developer satisfaction is not the one coding agents handle best. State which you are
optimising for in `02` §Stack, because the honest answer differs by project: work you will
maintain by hand for years weighs differently from work an agent will largely write.

Agent-fitness criteria, strongest evidence first:

- **Training-data density.** Mainstream choices produce working code more reliably.
- **Recency of a breaking paradigm shift.** The most overlooked criterion. Models blend old
  and new syntax after a major API redesign, producing plausible code that fails subtly —
  worse than not knowing, because it looks right. Penalise a framework for 12–24 months
  afterwards. Worst case is a framework that supports both old and new syntax indefinitely:
  the old form never errors, so nothing corrects it.
- **One obvious way** to do a thing, versus two supported patterns an agent can mix.
- **Type safety**, which converts runtime errors into pre-execution ones an agent can act on.
- **Error quality.** An agent can only respond to what the error says.

## Alternatives considered

| Alternative | Why not |
| ----------- | ------- |
| A framework × project-type scoring grid | Dates on every release; ranks options without saying which were admissible |
| Size as the primary axis (small/medium/large) | An output of the decision, not an input; changes while the framework does not |
| One blessed default for every project | The evidence does not support a single answer; the constraints differ too much |
| No guidance — let each project decide unaided | The gap that produced this ADR |

### Evidence behind the funnel

Verified 2026-09-11 against package registries and vendor documentation rather than search
results. Deliberately unversioned: **re-verify before relying on any of it.**

Frameworks fell into three groups, and the grouping is more durable than the ranking:

- **Content-first** (Astro, Eleventy, static): zero or near-zero baseline JavaScript, ideal
  where payload is the product. Astro adds typed content collections and a growth path;
  Eleventy has no request lifecycle at all, so authentication later means a second codebase.
- **Application frameworks** (Next.js, React Router, TanStack Start, Nuxt, SvelteKit): the
  range where auth, data, and dashboards are first-class. Nuxt scored best on the specific
  axis of a content site *becoming* an app, because its backend primitives are stable and
  present from day one.
- **Batteries-included backends** (Laravel, Rails, Django, Phoenix, ASP.NET Core): strongest
  where background jobs, non-trivial authorization, server-side billing, or an admin
  interface for non-technical staff are needed. All scored poorly on static marketing sites
  — a runtime and a database for content that could be flat files.

Three findings worth carrying:

1. **Satisfaction falling while usage stays high** is the clearest leading indicator of a
   framework past its peak. Usage lags sentiment because switching costs are real.
2. **Corporate backing cuts both ways.** It buys maintainer depth that independent projects
   cannot match, and it couples the roadmap to a vendor's commercial interest. Check who
   holds the governance role, not just who signs the cheques.
3. **Conventions help an agent place files; they do not help it infer unstated
   requirements.** The one framework-level agent benchmark that exists found near-ceiling
   performance on atomic tasks and roughly a third of that on feature-sized ones, because
   tickets do not describe edge cases and models do not fill them in. This is the argument
   for specifying a project properly, and it applies whatever stack you pick.

## Consequences

Makes easy: eliminating wrong options before arguing about right ones; a stack choice with
a recorded reason; guidance that survives a release cycle.

Makes hard, and this is the cost: a funnel gives no answer, only a shorter list. Someone
still has to choose, and the evidence section will drift out of date faster than the funnel
will. A scoring grid would have felt more decisive while being wrong sooner.

## Revisit when

The funnel misroutes a real project — a stage eliminates something that turns out to have
been right, or admits something obviously wrong. That is evidence a stage is mis-ordered or
a constraint is missing, and it is worth more than any amount of further comparison.
