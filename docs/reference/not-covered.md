# What the core docs do not prompt for

The core docs cover what most projects need most of the time. The topics below are
deliberately absent — not overlooked. If your project needs one, it has no home in
`01`–`07`, and the right move is to add a section to the doc that owns the nearest
territory rather than scatter the decision across whichever documents happen to touch it.

| Topic | Nearest owner if you add it |
| ----- | --------------------------- |
| Deployment, release, rollback | `07-buildplan.md` |
| CI: what runs on push, what blocks merge | `06-conventions.md`, next to §Definition of done |
| Versioning and changelog | `07-buildplan.md` |
| Feature flags and runtime configuration | `03-data.md`, or `04-networking.md` if server-driven |
| Internationalisation and localisation | `05-design.md`, next to §Voice |
| Analytics and event taxonomy | `03-data.md` |
| Form validation rules | `05-design.md` for presentation, `03-data.md` for the rules themselves |
| Client-side state-management mechanism | `02-architecture.md`, next to §Composition |
| Navigation, routing, deep links | `02-architecture.md` for structure, `05-design.md` for chrome |
| Performance budgets per layer | `01-product.md` §Success criteria carries the top-level ones |
| Secrets handling beyond user credentials | `06-conventions.md` |
| Data retention, PII classification, deletion | `03-data.md` |
| Code generation from `contracts/` | `06-conventions.md` |
| Observability beyond request logging | `04-networking.md` §Observability covers only the request path |

Some of these are genuinely project-specific and belong in a filled-in document rather than
a prompt in the template. Others are simply gaps. Both are worth reporting under
`AGENTS.md` §7: a topic listed here that you needed and had to invent is exactly the report
that section asks for.
