# Python Package And CLI Recipe

Use this for Python libraries, CLIs, repo-analysis tools, API wrappers, GUI utilities, and AI/provider-backed tooling.

For a copyable partial scaffold, see [starter](starter/).

## Directory Shape

```text
.
├── AGENTS.md
├── README.md
├── Makefile
├── pyproject.toml
├── src/
│   └── <package>/
│       ├── __init__.py
│       ├── py.typed
│       └── cli.py
├── tests/
│   ├── conftest.py
│   └── test_<feature>.py
├── docs/
├── examples/
├── scripts/
├── tasks/
└── .github/workflows/
```

For workspace-style projects, use `packages/*` and declare the workspace in `pyproject.toml`.

## Tooling Defaults

Prefer:

- `pyproject.toml` as the single source of package metadata and tool config.
- `src/` layout for imports.
- Ruff for formatting and linting.
- mypy for static checks.
- Vulture for mature packages where dead code matters.
- pytest plus coverage.
- `Makefile` for setup and local CI commands.
- `scripts/check_coverage.py` when plain coverage thresholds are not expressive enough.

## Makefile Targets

Use this target set unless the project has a reason to diverge:

```make
VENV ?= $(HOME)/.venvs/<project>
PYTHON := $(VENV)/bin/python

SRC_DIR := src
TEST_DIR := tests
PACKAGE := <package>
PYTEST_FLAGS ?= -s

.PHONY: setup-venv install-dev format format-check lint typecheck test coverage coverage-report package clean ci

$(PYTHON):
	mkdir -p "$(dir $(VENV))"
	python3 -m venv "$(VENV)"

setup-venv: $(PYTHON)

install-dev: $(PYTHON)
	"$(PYTHON)" -m pip install --upgrade pip
	"$(PYTHON)" -m pip install -e .[dev]

format:
	"$(PYTHON)" -m ruff format $(SRC_DIR) $(TEST_DIR) scripts

format-check:
	"$(PYTHON)" -m ruff format --check $(SRC_DIR) $(TEST_DIR) scripts

lint:
	"$(PYTHON)" -m ruff check $(SRC_DIR) $(TEST_DIR) scripts

typecheck:
	"$(PYTHON)" -m mypy $(SRC_DIR)

test:
	"$(PYTHON)" -m pytest $(PYTEST_FLAGS)

coverage-report:
	"$(PYTHON)" -m pytest $(PYTEST_FLAGS) --cov=$(PACKAGE) --cov-report=term-missing --cov-report=json:coverage.json

coverage: coverage-report
	"$(PYTHON)" scripts/check_coverage.py --input coverage.json --threshold 90

package:
	"$(PYTHON)" -m build --no-isolation

clean:
	rm -rf build dist .coverage .mypy_cache .pytest_cache .ruff_cache *.egg-info src/*.egg-info coverage.json htmlcov
	find . -type d -name __pycache__ -prune -exec rm -rf {} +

ci: format-check lint typecheck coverage
```

If the project is intentionally simple, a lighter version with `.venv`, Black, isort, Ruff, mypy, pytest, and package targets is acceptable.

## Pyproject Sections

Include these sections early:

- `[build-system]`
- `[project]`
- `[project.optional-dependencies] dev = [...]`
- `[project.scripts]` for CLIs
- `[tool.ruff]`, `[tool.ruff.lint]`, `[tool.ruff.format]`
- `[tool.mypy]`
- `[tool.pytest.ini_options]`
- `[tool.coverage.run]` and `[tool.coverage.report]`
- package discovery for setuptools or hatchling

## AI Workflow

1. Ask the agent to create package metadata, `src/<package>`, `tests/`, and `Makefile`.
2. Add the CLI entrypoint before the project has many internals.
3. Keep examples in `examples/` and smoke tests in `scripts/` or dedicated `make smoke-*` targets.
4. Ask for strict typing once the API shape stabilizes.
5. For AI/provider projects, keep optional provider extras separate, such as `openai`, `anthropic`, `gemini`, or `ollama`.

## Useful Variants

- CLI artifact: add `pex` and `make artifact` / `make artifact-smoke`.
- App with local UI: keep UI resources under package data and add smoke tests that do not require live credentials by default.
- API wrapper: generate endpoint docs into `documentation/` and examples into `examples/`.
- Mixed Python/C harness: keep C code under `c/`, expose `make build-hook`, and add `make doctor`.
- GUI app: keep GUI tests deterministic with stubs or headless-safe marks, and use a dedicated pytest marker for tests that need display support.
- LLM/provider app: store runtime config in YAML, keep provider smoke commands opt-in, and stub provider clients in normal tests.

## Default Tool Stack

| Concern | Default |
| --- | --- |
| Test | pytest |
| Formatting | Ruff format |
| Linting | Ruff check |
| Typing | mypy |
| Dead code | Vulture once the package is no longer a prototype |
| Coverage | pytest-cov; 90 percent for mature packages, 80 percent acceptable for wrappers/prototypes |
| Packaging | `python -m build` |
| Artifact | PEX for standalone CLIs |
| CI | `make format-check`, `make lint`, `make typecheck` or `make reachability`, `make coverage` |

Use Black + isort when inheriting an existing repo that already has those tools. For new Python projects, prefer Ruff format plus Ruff import sorting to reduce the tool count.

## Config And Schema Projects

For tools that operate on structured project data, add these early:

- `spec/` or `schemas/` for JSON Schema or DSL references.
- `examples/*.json` or `examples/*.yaml` for representative inputs.
- validation tests that fail on stale examples.
- report-generation smoke tests if the tool writes Markdown, PDF, or other rendered artifacts.

Use this pattern when the tool operates on checked-in schemas, project metadata, prompts, structured examples, or generated reports.
