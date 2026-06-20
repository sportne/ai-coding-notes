# Task: <Title>

ID: <T001 or short id>
Status: Proposed
Type: AFK | HITL
Depends on: <task ids or None>
Priority: <High | Medium | Low | Not specified>
Gate: <local validation gate or milestone gate>
Target module: <module/package/app area or None>

## Description

Short goal and why it matters.

## Context

- Relevant recipe: `<recipe path>`
- Related docs: `<docs or README paths>`
- Related code: `<source/test paths>`
- Requirement IDs: `<REQ ids or None>`
- ADR IDs: `<ADR ids or None>`
- Specification references: `<schema/spec/standard/benchmark references or None>`

## Allowed Changes

- Paths the implementer may change.
- Any explicitly allowed behavior changes.

## Barred Changes

- Paths or behavior that must not be changed.
- Out-of-scope refactors.
- Expensive or external checks that should not become part of the fast gate.

## Acceptance Criteria

- [ ] Concrete outcome.
- [ ] Concrete outcome.
- [ ] README, docs, or examples are updated if user-facing behavior changes.

## Required Tests

- Unit tests:
- Integration or smoke tests:
- Architecture, schema, native, benchmark, or security tests if applicable:

## Documentation Required

- Docs to add or update.
- Changelog, release note, migration note, or compatibility note if applicable.

## Validation Required

```bash
# Commands or manual checks required before marking done.
```

## Rollback Notes

How to revert or disable the change if it causes problems.

## Notes

Implementation guidance, known risks, useful references, and any assumptions the agent should preserve.

## Status Vocabulary

- `Proposed`: task is defined but not started.
- `In Progress`: someone is actively implementing the task.
- `Blocked`: work cannot continue without an explicit dependency or decision.
- `Done`: acceptance criteria and validation are complete.
- `Superseded`: replaced by another task or design.

## Type Vocabulary

- `AFK`: implementable without further human decisions.
- `HITL`: requires a human decision, review, credential, external service, or manual observation before completion.
