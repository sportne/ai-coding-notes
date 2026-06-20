# Common Project Layout

Use this for any new repo before choosing a language-specific layout.

```text
.
├── README.md
├── LICENSE
├── AGENTS.md or AGENT.md
├── docs/
│   ├── architecture.md
│   ├── scope.md
│   ├── verification.md
│   └── adr/
├── examples/
├── scripts/
├── tasks/
│   ├── README.md
│   └── 0001-first-vertical-slice.md
├── tests/
└── .github/workflows/
```

## What Each Directory Is For

- `docs/`: durable decisions, architecture, scope, validation strategy, release notes, compatibility, and user-facing usage notes.
- `examples/`: runnable examples that prove the public workflow, not just snippets.
- `scripts/`: repeatable support commands that are too large or awkward for a build file.
- `tasks/`: AI-friendly implementation chunks. Each task should include acceptance criteria and validation commands.
- `tests/`: normal automated tests. Keep generated fixtures and large corpora in clearly named subdirectories.
- `.github/workflows/`: CI that runs the same root command used locally.

## Root Files To Add Early

- `README.md`: purpose, setup, core commands, repository map.
- `AGENTS.md`: coding-agent instructions specific to the repo.
- `.gitignore`: language build outputs and local scratch directories.
- `.editorconfig`: indentation and newline policy.
- `LICENSE`: decide early so generated files and package metadata are consistent.

## Local Quality Gate

Every project should expose one memorable root command:

| Ecosystem | Preferred command |
| --- | --- |
| Java/Gradle | `./gradlew qualityGate` |
| Python | `make ci` |
| C++/CMake | `make ci` or `cmake --workflow --preset ci-local` |
| Small prototype | `make check` |

Ask the agent to keep CI and the local gate aligned. If CI does more than the local gate, capture the difference in `docs/verification.md`.

## AI Prompt Recipe

Use this shape when starting a project:

```text
Create the initial scaffold for a <language/project type> repo.

Follow the project layout in ai-coding-notes/<recipe>.
Add one small working vertical slice with tests and examples.
Add root commands for setup, format-check, lint, test, coverage, and ci/qualityGate.
Document the structure in README.md and record follow-up work in tasks/.
Keep the implementation narrow and verify it locally.
```
