# Agent Instructions

## Project Priorities

- Keep the scaffold free of fake implementation code.
- Add source files only when implementing real behavior.
- Keep root commands aligned with CI.
- Add tests with behavior changes.
- Keep docs and task files current when scope changes.

## Local Commands

- Setup: `make setup-venv && make install-dev`
- Format: `make format`
- Format check: `make format-check`
- Lint: `make lint`
- Type check: `make typecheck`
- Test: `make test`
- Coverage: `make coverage`
- Full gate: `make ci`

## Directory Rules

- Source code lives in `src/<package_name>/`.
- Tests live in `tests/`.
- Durable design notes live in `docs/`.
- Task breakdowns live in `tasks/`.
- Support scripts live in `scripts/`.
- Local build and test artifacts should stay ignored by git.
