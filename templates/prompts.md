# Prompt Templates

Reusable prompts for common coding-agent workflows. Replace task IDs, paths, command names, and environment details before use.

## Exhaustive Library Test Expansion

Use this when a library needs broad unit coverage plus a small set of integration-style tests that still run inside the normal unit test framework.

```text
I want you to exhaustively test every aspect of this library in the form of both unit tests and limited integration tests, with integration tests still using the unit testing framework.

To do this, spawn a pool of subagents for accomplishing this for each individual class, with you orchestrating the process. You should handle the higher-level integration tests yourself.

If a subagent runs into a problem, they should only be allowed to edit the one production class that maps to the test class they are working on.
```

## Sequential Task Batch With Review And Commit Gates

Use this when a known task range should be completed one task at a time, with tests, review, and commits after each task.

```text
I want you to make a plan to complete tasks <first-task-id> through <last-task-id>, tackling them one by one.

For each task:
- ensure all tests are successfully executed and quality gates met
- once you think the task is complete, spawn a subagent to perform a code review based on the git diff plus new files
- wait for that review results to be completed and then address the review findings
- propose a commit message and then make a commit with that message, ensuring that all tests have successfully executed and quality gates have been met prior to commit
- follow all other normal project development conventions

Upon completion of all tasks:
- push all of the commits to the remote; this should be the only push, you are not permitted to make multiple pushes, only one
- review the CI build results and if there are failures then stage fixes, but do not commit or push again; I want to review before anything like that
- review the overall state of the project and identify any future tasks that should be completed; don't put those tasks into files yet, just include them in your final response to me so that I can pick and choose what should be done next
```

Example task range:

```text
g0-001 through g0-008
```

## Next Task Planning

Use this when returning to a project and deciding the next concrete implementation task.

```text
Review the project status and docs to identify the next task to complete as well as a plan for how to design and implement that task. If you determine that there is no obvious next task, document that.
```

## Diff Review And Commit Message

Use this before committing a completed change.

```text
Review your changes as described by git and then suggest a commit message.
```

## Project Reflection And Topic Prioritization

Use this when the next work is unclear and the project needs a broader strategy pass.

```text
Now I'd like you to take a deep dive in reflecting on the current state of the project in order to identify what to do next.

A few ideas I have, that I do not want you to limit the analysis to but to include in it, are:
- reviewing other projects doing functionally similar things, specifically looking at their GitHub or other git issue tracking systems, past and current issues, to mine for problems other people have had and how they were addressed in order to look for those issues in our project
- reviewing performance of both the generation of code and the code that is generated; maybe our current performance is great, but maybe it is terrible, I do not know
- reviewing the current design and implementation complexity; do we have substantial unnecessary complexity right now, and could we refactor for simplicity? Recall that simplicity is a fundamental goal of this project.

I'm sure there are many other things that can be looked into. I'm not asking you to take a deep dive into each of these topics. I'm asking you to review the project to create a prioritized list of topics that we can explore.

As part of your response, provide me with a table of the topics you considered, how you think they should be prioritized, and why.
```
