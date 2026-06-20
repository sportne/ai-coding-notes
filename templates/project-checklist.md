# Project Checklist

Use this when asking an AI agent to start or harden a repo.

Before filling this out, choose the closest project-type recipe and use its tooling section:

- [Java Gradle multi-module](../recipes/java/gradle-multi-module.md)
- [Python package and CLI](../recipes/python/package-cli.md)
- [C++ CMake library](../recipes/cpp/cmake-library.md)
- [Demo or harness](../recipes/mixed/demo-harness.md)

## Initial Scaffold

- [ ] `README.md` explains purpose, setup, commands, and directory map.
- [ ] License is present.
- [ ] `.gitignore` covers build output, local virtual environments, caches, and scratch directories.
- [ ] `AGENTS.md` or `AGENT.md` captures repo-specific agent rules.
- [ ] Source, tests, examples, docs, and scripts have clear homes.
- [ ] Root local gate exists: `make ci`, `make check`, or `./gradlew qualityGate`.
- [ ] CI runs the same local gate or documents any difference.
- [ ] Tooling choices follow the selected project-type recipe or document why they differ.
- [ ] Test, format, lint/static analysis, architecture, coverage, and packaging tools are explicitly chosen.
- [ ] If the project is schema-, config-, or data-driven, schemas and sample inputs are checked in and validated.
- [ ] Task tracking uses [task-template.md](task-template.md) or a project-specific format with status, dependencies, acceptance criteria, and validation.
- [ ] Durable design decisions use [adr.md](adr.md) or an equivalent ADR format.
- [ ] Release and compatibility expectations are documented using [release-policy.md](release-policy.md) or an equivalent project policy.

## First Vertical Slice

- [ ] One small feature works end to end.
- [ ] Unit tests cover the feature.
- [ ] At least one example or smoke path demonstrates usage.
- [ ] README setup commands have been verified.
- [ ] Follow-up work is captured in `tasks/`.

## Before The Project Grows

- [ ] Architecture or module boundaries are documented.
- [ ] Significant architecture, dependency, compatibility, or tooling decisions have ADRs.
- [ ] Formatting and linting are automated.
- [ ] Static analysis is part of the normal gate.
- [ ] Coverage threshold is set if useful.
- [ ] Public APIs have examples.
- [ ] Generated files, fixtures, recordings, and scratch data are separated.
- [ ] Optional external services or tools are documented and skipped by default in normal CI.
- [ ] Any AI/provider-backed behavior has deterministic tests with network calls stubbed or gated.

## Before Release

- [ ] Package metadata is complete.
- [ ] Version is represented by a git tag.
- [ ] Backwards compatibility expectations match the documented release policy.
- [ ] Distribution expectations are clear; by default artifacts are not published to central repositories.
- [ ] Artifact smoke test exists.
- [ ] Changelog or release notes exist.
- [ ] Release dry-run or local publication check exists when publishing packages.
- [ ] Security and compatibility notes exist when relevant.
