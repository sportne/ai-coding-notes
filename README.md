# AI Coding Notes

This repo is a cookbook for starting new coding projects with AI assistance. It captures reusable project setup patterns, tooling choices, and task formats for quickly scaffolding new work.

Use it as a starting point when asking an AI coding agent to scaffold, harden, or extend a project. Pick the closest recipe, copy the directory shape, then ask the agent to fill in the first small vertical slice before expanding the system.

## Start Here

- [Common project layout](recipes/common-project-layout.md) captures the baseline directories that show up across languages.
- [Java Gradle multi-module recipe](recipes/java/gradle-multi-module.md) is the strongest current pattern in the workspace.
- [Python package and CLI recipe](recipes/python/package-cli.md) covers the `src/`, `tests/`, `Makefile`, and `pyproject.toml` style.
- [C++ CMake recipe](recipes/cpp/cmake-library.md) covers CMake presets, `include/`, `src/`, `tests/`, and local quality gates.
- [Demo or harness recipe](recipes/mixed/demo-harness.md) covers projects that combine scripts, generated examples, C helpers, containers, or GUI/live-loop validation.

## Directory Map

```text
recipes/
  common-project-layout.md
  java/
    gradle-multi-module.md
    starter-standard/
    starter-native-image/
  python/
    package-cli.md
    starter/
  cpp/
    cmake-library.md
    starter/
  mixed/
    demo-harness.md
templates/
  agent-instructions.md
  project-checklist.md
  task-template.md
```

## How To Use With An AI Agent

1. Choose the closest recipe for the project type.
2. Create the directory skeleton before asking for feature work.
3. Ask the agent to add one working end-to-end slice: code, tests, docs, and local verification.
4. Keep a task list in `tasks/` and require each task to name its validation command.
5. Promote repeated build/test setup into `Makefile`, Gradle root tasks, or CMake presets early.

The most reusable local habit is not a specific framework. It is asking the agent to make the project self-explaining: root commands, explicit docs, focused examples, architecture checks where useful, and a local quality gate that mirrors CI.
