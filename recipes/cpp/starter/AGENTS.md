# Agent Instructions

## Project Priorities

- Keep the scaffold free of fake implementation code.
- Add C++ source files only when implementing real behavior.
- Keep CMake presets and Makefile aliases aligned.
- Keep `make ci` aligned with CI.
- Add tests with behavior changes.
- Keep docs and task files current when scope changes.

## Local Commands

- Configure: `make configure`
- Build: `make build`
- Test: `make test`
- Format: `make format`
- Format check: `make format-check`
- Static analysis: `make static-analysis`
- Sanitizers: `make asan`
- Coverage: `make coverage`
- Full gate: `make ci`

## Directory Rules

- Public headers live in `include/`.
- First-party source lives in `src/`.
- Tests live in `tests/`.
- Runnable examples live in `examples/`.
- Durable design notes live in `docs/`.
- Task breakdowns live in `tasks/`.
- Support scripts live in `scripts/`.
- Local build, coverage, and analysis artifacts should stay ignored by git.
