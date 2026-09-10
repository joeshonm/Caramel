# contracts/

Machine-readable sources of truth. These outrank prose in every core document
(`AGENTS.md` §3).

| File | Authoritative for | Owner |
| ---- | ----------------- | ----- |
| `openapi.yaml` | endpoints, payloads, status codes | backend |
| `schema.sql` | server-side persisted shape | backend |
| `errors.md` | error codes and client handling | backend |
| `tokens.json` | all design values | design |

Rules:

- Shared by every platform by definition. A change here affects all of them and must be
  called out explicitly in any task summary.
- Never fork a contract per platform. If a platform genuinely needs different values,
  that is a platform binding referencing the contract, not a copy of it.
- If prose in a core doc disagrees with a file here, the file wins and the prose is a
  documentation bug to be reported.
