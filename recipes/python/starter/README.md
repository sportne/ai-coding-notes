# Python Package CLI Starter

This starter is a partial implementation of the Python package and CLI recipe. It provides project setup files and empty places for source, tests, docs, scripts, and tasks without inventing application code.

## Before Use

Replace these placeholders:

- `<project-name>`: distribution name, usually kebab-case.
- `<package_name>`: import package name, usually snake_case.
- `<description>`: one sentence describing the project.
- `<author or team>`: package author metadata.

Then create `src/<package_name>/` only when there is real package code to add.

## Initial Commands

```bash
make setup-venv
make install-dev
make format-check
make lint
make typecheck
make test
```

`make coverage` is included but should be enabled after the first real tests exist.
