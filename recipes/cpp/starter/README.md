# C++ CMake Starter

This starter is a partial implementation of the C++ CMake recipe. It provides project setup files and empty homes for source, public headers, tests, examples, docs, scripts, config, and tasks without inventing application or library code.

## Before Use

Replace these placeholders:

- `starter_project`: CMake project name.
- `STARTER_PROJECT`: uppercase option prefix, such as `MYLIB`.
- `<description>`: one sentence describing the project.
- `<author or team>`: maintainer or owning team.

Then create real targets only when there is real behavior to implement.

## Initial Commands

```bash
make configure
make build
make test
make format-check
make static-analysis
make ci
```

Coverage and sanitizer presets are included but should be enabled after the first real tests exist.

## Included Structure

- root CMake project and presets
- root Makefile aliases
- clang-format and clang-tidy config
- cppcheck suppression file
- placeholder homes for headers, source, tests, examples, docs, scripts, and tasks
- CI that runs the same local `make ci` gate
