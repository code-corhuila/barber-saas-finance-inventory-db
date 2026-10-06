# barber-saas-finance-inventory-db

> finance-inventory bounded context: database (schema, seeds, migrations)

Part of the **Barber Saas** distributed system — team `barber-saas`, Grupo 2.
Governance and documentation live in [`barber-saas-docs`](https://github.com/code-corhuila/barber-saas-docs).

## Branching

Three permanent branches. **None of them accepts a direct commit** — you enter through a child
branch and leave through a Pull Request.

```
develop  <--PR--  feat/... fix/... chore/...
qa       <--PR--  qa/...
main     <--PR--  release/...  hotfix/...
```

Promotion happens **by re-application** (`git cherry-pick -x`), never by merging one permanent
branch into another: `merge develop -> qa` and `merge qa -> main` do not exist in this model.

`main` requires **1 approval from `ariel5253`**. On `develop` and `qa` the team sets its own review
rule.

Full policy: `00-governance/branching-policy.md` in `barber-saas-docs`.

---

## BarberSaaS — what this repository is

The `finance_inventory` schema (a barbershop's income and expenses, its inventory products and
their stock movements, idempotency keys) versioned with Liquibase (ADR-007), following annex A
and Annex J: it has **no database instance of its own**. Its runner applies the changesets to the
single PostgreSQL instance of `barber-saas-infra-postgres`, with its own changelog tables
(`databasechangelog_finance_inventory`). Model: `06-data/models.md` §8 and §10 in `barber-saas-docs`.

### How to run the migrations

From `barber-saas-infra-postgres`, with the platform up:

```bash
docker compose --env-file env/dev.env run --rm finance-inventory-db-migrate            # update
docker compose --env-file env/dev.env run --rm finance-inventory-db-migrate status --verbose
docker compose --env-file env/dev.env run --rm finance-inventory-db-migrate rollback-count 1
```

### Where the data is

Schema `finance_inventory` in database `barbersaas` of the shared instance. The service reads and
writes it as `finance_inventory_app` (granted `finance_inventory_writer` in `03_dcl/`); nobody else
writes it. Money is in cents (`amount_cents`, ADR-010) and always positive: `type` gives the sign
(`chk_finance_record_amount`). Stock is `numeric(12,2)` and can never go negative
(`chk_inventory_product_stock`); it changes only through `inventory_movement`, which reaches the
tenant through its product. The appointment of a record and the user of a movement are referenced
by id with no foreign key.

### How it is tested

`.github/workflows/db-ci.yml` builds the schema from an empty database, checks that a second
update applies nothing, rolls everything back and applies it again.

### What is missing

No seed data: records and products are created through `barber-saas-finance-inventory-api`.
