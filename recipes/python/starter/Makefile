VENV ?= $(HOME)/.venvs/<project-name>
PYTHON := $(VENV)/bin/python

SRC_DIR := src
TEST_DIR := tests
PACKAGE := <package_name>
PYTEST_FLAGS ?= -s

.PHONY: help setup-venv install-dev format format-check lint typecheck test coverage coverage-report package clean ci

help:
	@echo "Common commands:"
	@echo "  make setup-venv     - Create the virtual environment"
	@echo "  make install-dev    - Install editable package with dev dependencies"
	@echo "  make format         - Run Ruff formatter"
	@echo "  make format-check   - Check Ruff formatting"
	@echo "  make lint           - Run Ruff linting"
	@echo "  make typecheck      - Run mypy"
	@echo "  make test           - Run pytest"
	@echo "  make coverage       - Run pytest with coverage gate"
	@echo "  make package        - Build source and wheel distributions"
	@echo "  make clean          - Remove local build and test artifacts"
	@echo "  make ci             - Run the local quality gate"

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
