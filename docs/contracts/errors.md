# Error contract

Authoritative for error codes and the client's required handling. Adding a row here is a
breaking change for every platform.

## Envelope

<!-- FILL: the exact error body shape returned by the API. -->

```json
{
  "error": {
    "code": "string",
    "message": "human-readable, not for display without review",
    "details": {}
  }
}
```

## Codes

<!-- FILL. `Client must` is a requirement, not a suggestion — it is what an agent implements. -->

| Code | HTTP | Meaning | Client must | Retryable |
| ---- | ---- | ------- | ----------- | --------- |
| `unauthenticated` | 401 | Token missing, invalid, or expired | Attempt one refresh; on failure, clear session and route to sign-in | No |
| `forbidden` | 403 | Authenticated but not permitted | Surface; do not retry | No |
| `not_found` | 404 | Resource absent or not visible to caller | Surface as empty state, not error | No |
| `rate_limited` | 429 | Quota exceeded | Honour `Retry-After`; backoff | Yes |
| `internal` | 500 | Server fault | Retry per `04-networking.md`, then surface generic failure | Yes |

## Rules

- `message` is diagnostic. User-facing copy comes from `05-design.md`, keyed by `code`.
- An unrecognised code is treated as `internal` and reported, never swallowed.
- `details` is advisory; never branch on it without a row above describing its shape.
