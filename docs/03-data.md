# 03 — Data

Domain model, ownership, and state. `contracts/schema.sql` is authoritative for anything
persisted server-side; this document explains and constrains it.

## Domain model

<!-- FILL: the core entities and their relationships. Names here are the vocabulary for the
whole codebase — an agent will use them for types, tables, endpoints, and UI labels, so
choose them once and use them everywhere. -->

| Entity | Meaning | Key fields | Relationships |
| ------ | ------- | ---------- | ------------- |
|        |         |            |               |

## Ownership

<!-- FILL: for each piece of state, exactly one owner. Ambiguous ownership is the root cause
of most state bugs an agent will introduce. -->

| State | Owner | Lifetime | Who may mutate |
| ----- | ----- | -------- | -------------- |
|       |       |          |                |

## Source of truth

<!-- FILL: for each entity, is the server or the client authoritative? What happens when they
disagree? Answer this before writing any sync or caching code. -->

## Local persistence

<!-- FILL: what is stored locally and why. What survives restart, what survives reinstall,
what must never be written to disk. Note anything sensitive and its required protection. -->

## Caching

<!-- FILL: what is cached, keyed how, valid for how long, invalidated by what. If there is no
cache, say so explicitly — an agent will otherwise add one. -->

## Migrations

<!-- FILL: how schema changes are versioned and applied. What is the policy for a user who
skips several versions? -->

## Derived state

<!-- FILL: what is computed rather than stored, and where. Prevents an agent from persisting
values that should be derived and then drifting out of sync. -->

---

## Platform bindings — CARAMEL_PLATFORM

<!-- Storage engine and library, on-device encryption, background refresh limits, quota
behaviour, local schema if it diverges from the server's. -->
