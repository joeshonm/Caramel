# 04 — Networking

Transport, auth, and failure. `contracts/openapi.yaml` is authoritative for endpoints and
payloads; `contracts/errors.md` is authoritative for error codes. Prose that contradicts
either is a bug — report it rather than following it.

## Transport

<!-- FILL: protocol(s), base URLs per environment, content type, versioning scheme,
compression, timeouts. -->

| Environment | Base URL |
| ----------- | -------- |
| local       |          |
| staging     |          |
| production  |          |

## Authentication

<!-- FILL: the scheme, where credentials are stored, token lifetime, refresh mechanism, and
what happens on refresh failure. Be precise about the refresh race: concurrent 401s must not
trigger concurrent refreshes. -->

## Request policy

<!-- FILL: required headers, correlation/request IDs, idempotency keys for unsafe methods,
pagination convention, whether requests are batched or coalesced. -->

## Error handling

<!-- FILL: map transport-level outcomes to domain errors. Which are retried, which surface to
the user, which are silent. Include the retry policy concretely: which status codes, how many
attempts, what backoff, what jitter, what cap. Vague retry guidance produces either no retries
or a thundering herd. -->

| Condition | Retry | Surface to user | Notes |
| --------- | ----- | --------------- | ----- |
| network unreachable |  |  |  |
| 401 |  |  |  |
| 429 |  |  |  |
| 5xx |  |  |  |

## Offline and degraded behaviour

<!-- FILL: what works with no connectivity, what is queued, how long a queue survives, how
conflicts resolve on reconnect. If offline is unsupported, state that plainly. -->

## Realtime

<!-- FILL: sockets, SSE, or polling. Reconnection and backoff. How realtime updates reconcile
with cached state. Omit if not applicable, but say so. -->

## Observability

<!-- FILL: what is logged, at what level, and what must never appear in logs. -->

---

## Platform bindings — CARAMEL_PLATFORM

<!-- HTTP client library, certificate pinning, cookie vs header auth, CORS, background
transfer APIs, connectivity detection, platform-imposed request limits. -->
