# Task: First Vertical Slice

ID: T001
Status: Proposed
Type: AFK
Depends on: None
Priority: High
Gate: `make ci`
Target module: `include/`, `src/`, `tests/`

## Description

Implement the first real C++ behavior. Keep the scope small enough to include headers or source, tests, documentation, and validation in one change.

## Context

- Relevant recipe: `recipes/cpp/cmake-library.md`
- Related docs: `README.md`
- Related code: `include/`, `src/`, `tests/`
- Requirement IDs: None
- ADR IDs: None
- Specification references: None

## Allowed Changes

- `include/**`
- `src/**`
- `tests/**`
- `examples/**` if a runnable usage path is introduced
- `CMakeLists.txt`
- `cmake/**` if target wiring needs to change
- `README.md`
- `docs/**`
- `tasks/**`

## Barred Changes

- Do not add fake example behavior just to satisfy the scaffold.
- Do not disable warnings, static analysis, sanitizers, or tests to make the first slice pass.
- Do not add vendored third-party code unless the dependency choice is part of the task.

## Acceptance Criteria

- [ ] One real behavior exists.
- [ ] CMake builds the behavior through a named target.
- [ ] Unit tests cover the behavior.
- [ ] Documentation is updated if behavior is user-facing.
- [ ] The local validation gate passes.

## Required Tests

- Unit tests:
- Integration or smoke tests if an executable or public workflow is introduced:
- Sanitizer, coverage, benchmark, or architecture checks if applicable:

## Documentation Required

Update `README.md` or `docs/` if the behavior is user-facing.

## Validation Required

```bash
make ci
```

## Rollback Notes

Remove the new source files, tests, targets, and documentation added for the first behavior.

## Notes

Create C++ files only when implementing real behavior.
