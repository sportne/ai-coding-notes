# Agent Instructions

## Project Priorities

- Keep the scaffold free of fake implementation code.
- Add Java source files only when implementing real behavior.
- Keep native-image behavior opt-in until the application entrypoint exists.
- Keep `qualityGate` aligned with CI.
- Add JVM tests first, then native smoke checks when behavior crosses the native boundary.

## Local Commands

- Full gate: `./gradlew qualityGate --console=plain`
- All JVM checks: `./gradlew checkAll --console=plain`
- Native smoke: `./gradlew nativeSmoke --console=plain`
- Coverage: `./gradlew jacocoTestCoverageVerification --console=plain`

## Directory Rules

- Production modules live under `modules/`.
- Native-sensitive application code lives under `modules/project-app/`.
- Native compatibility tests live under `modules/project-native-tests/`.
- Shared Gradle conventions live under `build-logic/`.
- Durable design notes live under `docs/`.
- Task breakdowns live in `tasks/`.
