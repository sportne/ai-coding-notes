# Agent Instructions Template

Use this as `AGENTS.md` or `AGENT.md` in a new repo.

## Project Priorities

- Keep changes scoped to the active task.
- Prefer existing project patterns over new abstractions.
- Add or update tests for behavior changes.
- Keep root commands working and documented.
- Do not leave generated artifacts checked in unless the README says they are part of the project.

## Local Commands

- Setup: `<setup command>`
- Format: `<format command>`
- Lint: `<lint command>`
- Type/static checks: `<typecheck command>`
- Test: `<test command>`
- Full gate: `<ci or qualityGate command>`

## Directory Rules

- Source code lives in `<source root>`.
- Tests live in `<test root>`.
- Durable design notes live in `docs/`.
- Task breakdowns live in `tasks/`.
- Examples live in `examples/`.
- Scratch/generated local files live in `<scratch dir>` and should be ignored by git.

## Validation Rule

Every task should end with the narrowest relevant validation command and, before merge/release, the full local gate.
