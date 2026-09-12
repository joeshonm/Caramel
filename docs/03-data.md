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

Owns reconciliation for the whole project (`AGENTS.md` §3): when two copies of the same
state disagree, this section says which wins. §Caching below covers TTL and invalidation;
`04-networking.md` §Realtime and §Offline cover transport and queueing. Neither decides a
conflict.

<!-- FILL: for each entity, is the server or the client authoritative? What happens when they
disagree — last-write-wins, server-wins, merge, prompt the user? Answer this before writing
any sync or caching code. -->

## Local persistence

<!-- FILL: what is stored locally and why. What survives restart, what survives reinstall,
what must never be written to disk. Note anything sensitive and its required protection. -->

## Media and assets

Images, video, audio, fonts, and downloads. Distinct from §Local persistence because these
are usually large, usually served from somewhere other than your API, and usually the
dominant share of what a user actually downloads.

<!-- FILL: for each kind of asset — where it is stored, how it is delivered, what
transformation happens and when, and the size budget. Name the ceiling: "hero images under
200KB after optimization" is checkable, "optimized images" is not. If large media is
uploaded by a non-technical editor, say where it goes, since content tools rarely accept
files this big. If the project has no media beyond a logo, say so explicitly and delete the
table — otherwise an agent will build a pipeline you did not ask for. -->

| Asset kind | Stored where | Delivered how | Transform | Budget |
| ---------- | ------------ | ------------- | --------- | ------ |
|            |              |               |           |        |

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
