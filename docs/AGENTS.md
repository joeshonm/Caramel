# AGENTS.md — read this first, in full

You are implementing **CARAMEL_PROJECT**. This directory is the specification. Code that
contradicts these documents is wrong, even if it works.

---

## 1. Platform declaration

```yaml
project: CARAMEL_PROJECT
platforms: [CARAMEL_PLATFORM]     # e.g. [web] | [ios] | [web, ios, android] | [desktop]
mode: UNSET               # single | multi  — must match the length of `platforms`
```

`mode` is not decoration. It changes how you resolve every subsequent document:

| `mode`   | Where platform decisions live                                    | `docs/platforms/`        |
| -------- | ---------------------------------------------------------------- | ------------------------ |
| `single` | In the final `## Platform bindings — <platform>` section of each core doc | **Does not exist.** Do not look for it. Its absence is expected, not an error. |
| `multi`  | In `docs/platforms/<platform>.md`, one overlay per platform      | Exists. Load exactly one. |

If `mode: UNSET`, this repository has not been initialised for a project yet.
Stop and ask the human to run `scripts/init-project.sh` or fill in this block by
hand. Do not guess a platform and do not begin implementation.

---

## 2. Reading order

1. This file, completely.
2. `01-product.md` — always. You cannot judge a tradeoff without knowing the non-goals.
3. The core docs relevant to your task (see routing table below).
4. **In `multi` mode only:** exactly one overlay from `docs/platforms/`.
5. Any `contracts/` file referenced by the docs you just read.

Do not read every document for every task. Do not read a second overlay.

Nothing enforces this table. No tool checks that you consulted it, and an agent that reads
everything will produce work that looks the same as one that routed correctly — until the
context it wasted is context it needed. Treat it as binding anyway. When a task genuinely
spans the whole set, say so in your report (§7) rather than routing to everything silently.

### Routing table

| Your task involves                                    | Read                                          |
| ----------------------------------------------------- | --------------------------------------------- |
| Scope, priorities, "should we build X"                | `01-product.md`                               |
| Layers, modules, dependency direction, new subsystem  | `02-architecture.md`                          |
| Choosing a language, runtime, or framework            | `02-architecture.md` §Stack; `decisions/ADR-0003` if the choice is still open |
| Domain types, persistence, caching, state ownership   | `03-data.md`, `contracts/schema.sql`          |
| Images, video, audio, fonts, asset delivery           | `03-data.md` §Media and assets                |
| API calls, auth, errors, retries, offline             | `04-networking.md`, `contracts/openapi.yaml`, `contracts/errors.md` |
| Who may do what; roles, scopes, gated UI              | `04-networking.md` §Authorization             |
| Adding or replacing a library                         | `06-conventions.md` §Dependencies             |
| Any user-visible surface, styling, copy               | `05-design.md`, `contracts/tokens.json`       |
| Naming, file placement, "where does this go"          | `06-conventions.md`, and `02-architecture.md` §Module map for which module owns it |
| What to build next, whether a milestone is done       | `07-buildplan.md`                             |
| "Why is it done this way" / reversing a past decision | `decisions/`                                  |

---

## 3. Resolution order

When two sources disagree, the higher entry wins:

1. A direct instruction from the human in the current conversation.
2. `contracts/` — machine-readable files are the source of truth for their subject.
   If `openapi.yaml` and prose in `04-networking.md` conflict, the schema wins and
   the prose is a bug. Report it.
3. The loaded platform overlay, **but only where it declares an override by name**
   (see §4).
4. Core docs `01`–`07`, which rank equally with each other. Where two of them cover the
   same decision, the owning doc below wins.
5. `decisions/` — records rationale. It explains the core docs; it does not outrank them.
6. Your own priors and framework conventions. Lowest. If a core doc contradicts the
   idiomatic approach for your framework, the core doc wins.

### Topic ownership

Some decisions are legitimately visible from more than one document. Exactly one owns each;
the others describe their own slice and defer. If a non-owning doc contradicts the owner,
the owner wins and the other is a bug to report (§7).

| Topic | Owner | The others cover |
| ----- | ----- | ---------------- |
| What a user sees when a request fails | `04-networking.md` §Error handling, keyed to `contracts/errors.md`; strings in `05-design.md` §Error copy | `02` §Error strategy: only the recoverable/fatal/crash split and where failures convert to domain errors |
| Prohibited patterns | `06-conventions.md` §Anti-patterns | `02` §Forbidden: architectural prohibitions only — layering and dependency violations |
| Never building it vs. not building it yet | `01-product.md` §Non-goals is "never, and why"; `07-buildplan.md` §Deferred is "real, but not now" | An item may not appear in both. If it moves from Deferred to Non-goals, delete the Deferred row |
| Reconciling cached, local, and server state | `03-data.md` §Source of truth | `03` §Caching: TTL and invalidation. `04` §Realtime and §Offline: transport mechanics and queue behaviour, not who wins a conflict |
| Styling | `05-design.md` §Tokens owns the values, `contracts/tokens.json` is authoritative | `06-conventions.md` §CSS: how stylesheets are written — specificity, scoping strategy, naming. It never names a value |

A collision not listed here is a gap in this table, not a licence to choose. Follow the doc
whose routing-table entry (§2) matches your task, and report the collision (§7).

Nothing in this repository is an invitation to improvise. If a needed decision is
absent from all of the above, stop and ask. A wrong guess written into code costs
more than a question.

---

## 4. Overrides must be declared

An overlay may only contradict a core doc by naming what it is overriding:

```markdown
> **Overrides** `03-data.md` §Caching: iOS retains cached media for 30 days, not 7,
> because cellular re-fetch is expensive.
```

An undeclared contradiction in an overlay is a documentation bug. Follow the core
doc and report the conflict. Being platform-specific is not by itself permission to
diverge from the core.

---

## 5. Scope boundaries

**`multi` mode only.** A task scoped to one platform may modify:

- that platform's source tree
- `docs/contracts/` (with the change called out in your summary, since every other
  platform is affected)

Modifying another platform's source tree requires stopping and asking first, even
when the change is small, obviously correct, or would make your own change cleaner.
"I refactored the shared helper while I was in there" is the failure this rule exists
to prevent.

**Overlays may not reference each other.** No "same as web, except…". If a rule holds
for more than one platform, move it into the core doc. This is what stops two overlays
from silently becoming two independent, drifting specifications.

---

## 6. Changing the platform list

Adding a platform to a `single`-mode project means moving each core doc's
`## Platform bindings` content into `docs/platforms/<platform>.md` overlays and setting
`mode: multi` in §1. There is deliberately no step-by-step procedure for this: the work is
deciding which claims in the core docs are genuinely platform-neutral, which is judgement,
not mechanics. Do it by hand, once, and expect to move some claims that turned out never to
have been invariant.

Keeping each bindings section filled in as you go is what makes this cheap. That is the
whole reason `single` mode has the sections at all.

---

## 7. Reporting back

End every non-trivial task with:

- what you built, in one or two lines
- which documents you read
- every assumption you made where the docs were silent
- any conflict, gap, or staleness you hit

The last two are the most valuable output you produce. They are how this
specification gets fixed. Do not smooth them over.

Name the document and section each one belongs in — "assumed X; belongs in `03-data.md`
§Caching, which does not say" is a defect someone can file. "I made some assumptions" is
not. If no section is the right home, say that too: it means the gap is structural, and
`reference/not-covered.md` is where it goes.

### What these documents do not prompt for

A number of topics are deliberately absent from `01`–`07` — deployment, CI, i18n,
analytics, routing structure, secrets beyond user credentials, and others.
`reference/not-covered.md` lists them with the doc that should own each one if your project
needs it. Needing something on that list is a report under this section, not a licence to
improvise.
