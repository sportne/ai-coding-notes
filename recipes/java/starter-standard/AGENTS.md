# Agent Instructions

## Project Priorities

- Keep the scaffold free of fake implementation code.
- Add Java source files only when implementing real behavior.
- Keep module boundaries explicit.
- Keep `qualityGate` aligned with CI.
- Add tests with behavior changes.

## Local Commands

- Full gate: `./gradlew qualityGate --console=plain`
- All checks: `./gradlew checkAll --console=plain`
- Coverage: `./gradlew jacocoTestCoverageVerification --console=plain`

## Directory Rules

- Production modules live under `modules/`.
- Runnable examples live under `examples/`.
- Shared Gradle conventions live under `build-logic/`.
- Durable design notes live under `docs/`.
- Task breakdowns live in `tasks/`.
