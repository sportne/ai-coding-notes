# Task: First Vertical Slice

ID: T001
Status: Proposed
Type: AFK
Depends on: None
Priority: High
Gate: `make ci`
Target module: `<package_name>`

## Description

Implement the first real behavior for this project. Keep the scope small enough to include source, tests, documentation, and validation in one change.

## Context

- Relevant recipe: `recipes/python/package-cli.md`
- Related docs: `README.md`
- Related code: `src/<package_name>/`, `tests/`
- Requirement IDs: None
- ADR IDs: None
- Specification references: None

## Allowed Changes

- `src/<package_name>/**`
- `tests/**`
- `README.md`
- `docs/**`
- `tasks/**`
- Build or tooling files only if required by the first real behavior.

## Barred Changes

- Do not add unrelated framework setup.
- Do not add fake example behavior just to satisfy the scaffold.
- Do not lower quality gates to make the first slice pass.

## Acceptance Criteria

- [ ] One real behavior exists and is reachable through the intended API or CLI.
- [ ] Tests cover the behavior.
- [ ] README or docs explain the behavior if it is user-facing.
- [ ] The local validation gate passes.

## Required Tests

- Unit tests:
- Integration or smoke tests:
- Architecture, schema, native, benchmark, or security tests if applicable:

## Documentation Required

- Update `README.md` or `docs/` if the behavior is user-facing.

## Validation Required

```bash
make format-check
make lint
make typecheck
make test
make coverage
```

## Rollback Notes

Remove the new source files, tests, and documentation added for the first behavior.

## Notes

Create package files only when implementing the real behavior.
