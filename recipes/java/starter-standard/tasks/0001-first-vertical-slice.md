# Task: First Vertical Slice

ID: T001
Status: Proposed
Type: AFK
Depends on: None
Priority: High
Gate: `./gradlew qualityGate --console=plain`
Target module: `modules/project-api`, `modules/project-core`

## Description

Implement the first real API and implementation behavior. Keep the scope small enough to include code, tests, documentation, and validation in one change.

## Context

- Relevant recipe: `recipes/java/gradle-multi-module.md`
- Related docs: `README.md`
- Related code: `modules/project-api/`, `modules/project-core/`
- Requirement IDs: None
- ADR IDs: None
- Specification references: None

## Allowed Changes

- `modules/project-api/**`
- `modules/project-core/**`
- `modules/project-testkit/**` if shared test helpers are needed
- `modules/project-architecture-tests/**` if boundaries are introduced
- `README.md`
- `docs/**`
- `tasks/**`

## Barred Changes

- Do not add unrelated modules.
- Do not add fake example behavior just to satisfy the scaffold.
- Do not lower quality gates to make the first slice pass.

## Acceptance Criteria

- [ ] One real API behavior exists.
- [ ] The core module implements that behavior.
- [ ] Unit tests cover the behavior.
- [ ] Documentation is updated if behavior is user-facing.
- [ ] The local validation gate passes.

## Required Tests

- Unit tests:
- Architecture tests if boundaries are introduced:

## Documentation Required

- Update `README.md` or `docs/` if the behavior is user-facing.

## Validation Required

```bash
./gradlew qualityGate --console=plain
```

## Rollback Notes

Remove the new source files, tests, and documentation added for the first behavior.

## Notes

Create Java package directories only when implementing real behavior.
