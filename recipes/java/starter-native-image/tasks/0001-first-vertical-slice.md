# Task: First Native-Capable Vertical Slice

ID: T001
Status: Proposed
Type: AFK
Depends on: None
Priority: High
Gate: `./gradlew qualityGate --console=plain`
Target module: `modules/project-api`, `modules/project-core`, `modules/project-app`

## Description

Implement the first real behavior and application entrypoint. Keep the scope small enough to include JVM tests, documentation, and validation in one change. Add native smoke validation only after the entrypoint exists.

## Context

- Relevant recipe: `recipes/java/gradle-multi-module.md`
- Related docs: `README.md`
- Related code: `modules/project-api/`, `modules/project-core/`, `modules/project-app/`
- Requirement IDs: None
- ADR IDs: None
- Specification references: Native Image compatibility requirements, if any

## Allowed Changes

- `modules/project-api/**`
- `modules/project-core/**`
- `modules/project-app/**`
- `modules/project-native-tests/**` if native compatibility tests are needed
- `modules/project-architecture-tests/**` if boundaries are introduced
- `README.md`
- `docs/**`
- `tasks/**`
- `build-logic/src/main/groovy/java-application-conventions.gradle` to set the real main class

## Barred Changes

- Do not add unrelated modules.
- Do not add fake example behavior just to satisfy the scaffold.
- Do not make native-image checks part of `qualityGate` until they are reliable in the target environment.
- Do not lower quality gates to make the first slice pass.

## Acceptance Criteria

- [ ] One real API or application behavior exists.
- [ ] The app module has a real main class.
- [ ] JVM tests cover the behavior.
- [ ] Native Image compatibility impact is documented.
- [ ] The local JVM validation gate passes.

## Required Tests

- Unit tests:
- Native smoke tests after the entrypoint exists:
- Architecture tests if boundaries are introduced:

## Documentation Required

- Update `README.md` or `docs/` with native-image prerequisites if needed.

## Validation Required

```bash
./gradlew qualityGate --console=plain
# After a real application entrypoint exists:
./gradlew nativeSmoke --console=plain
```

## Rollback Notes

Remove the new source files, tests, documentation, and main-class configuration added for the first behavior.

## Notes

Create Java package directories only when implementing real behavior.
