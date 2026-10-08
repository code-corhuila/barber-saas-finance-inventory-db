# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-10-08

User stories: code-corhuila/barber-saas-docs#10, code-corhuila/barber-saas-docs#11, code-corhuila/barber-saas-docs#59

### Added

- deploy: add the migration runner with its own changelog tables
- ddl: create the finance_inventory schema
- ddl: create finance record
- ddl: create inventory product
- ddl: create inventory movement
- ddl: create idempotency key
- dcl: create roles
- dcl: grant the writer role to the domain user

### Changed

- ddl: create indexes

### Documentation

- readme: point the header to Barber Saas and barber-saas-docs
- readme: explain the schema, how to migrate it and where the data is

### Tests

- ci: rebuild the schema from an empty database on every pull request

### Maintenance

- db: ignore local env files and liquibase output
- github: add the pull request template
- github: track the story environment on the board
- liquibase: add the master changelog and the ddl, dml, dcl and tcl families

[2.0.0]: https://github.com/code-corhuila/barber-saas-finance-inventory-db/releases/tag/v2.0.0
