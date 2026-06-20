# C++ CMake Library Recipe

Use this for C++ libraries, native agents, and performance-heavy code. It reflects `cpp-helper-libs` and `jvmpg`.

## Directory Shape

Library workspace:

```text
.
├── AGENTS.md
├── README.md
├── Makefile
├── CMakeLists.txt
├── CMakePresets.json
├── cmake/
├── libs/
│   ├── <library-a>/
│   └── <library-b>/
├── examples/
├── tests/
├── third_party/
├── docs/
└── .github/workflows/
```

Native app or agent:

```text
.
├── CMakeLists.txt
├── CMakePresets.json
├── include/
├── src/
├── tests/
│   ├── unit/
│   └── integration/
├── scripts/
├── policy/
├── docs/
└── .github/workflows/
```

## CMake Defaults

Use presets instead of ad hoc build directories:

- `clang-debug`
- `clang-release`
- `clang-debug-asan-ubsan`
- `gcc-coverage`
- `clang-static-analysis`
- `benchmark` when performance evidence matters

Expose toggles in `CMakeLists.txt`:

```cmake
option(<PROJECT>_BUILD_TESTS "Build test targets" ON)
option(<PROJECT>_BUILD_EXAMPLES "Build examples" ON)
option(<PROJECT>_ENABLE_WARNINGS "Enable compiler warnings" ON)
option(<PROJECT>_WARNINGS_AS_ERRORS "Treat warnings as errors" ON)
option(<PROJECT>_ENABLE_SANITIZERS "Enable sanitizers" OFF)
option(<PROJECT>_ENABLE_COVERAGE "Enable coverage" OFF)
option(<PROJECT>_ENABLE_CLANG_TIDY "Enable clang-tidy" OFF)
```

## Root Makefile Aliases

Keep CMake commands discoverable:

```make
.PHONY: debug release asan coverage static-analysis format format-check ci configure build test clean distclean

debug:
	cmake --workflow --preset debug

release:
	cmake --workflow --preset release

asan:
	cmake --workflow --preset asan

coverage:
	cmake --workflow --preset coverage

static-analysis:
	cmake --workflow --preset static-analysis

format-check:
	cmake --workflow --preset format-check

format:
	cmake --workflow --preset format

ci:
	cmake --workflow --preset ci-local

configure:
	cmake --preset clang-debug

build:
	cmake --build --preset build-clang-debug

test:
	ctest --preset test-clang-debug

distclean:
	cmake -E rm -rf build
```

## Docs To Add

- `docs/architecture.md`
- `docs/build-and-test.md`
- `docs/verification_and_validation_plan.md`
- `docs/requirements.md`
- `docs/performance-benchmarks.md` when benchmarks exist
- `docs/policy_schema.md` or similar when config/policy drives behavior

## AI Workflow

1. Ask the agent to create presets before writing much code.
2. Add a tiny target, unit test, and `ctest` path in the first slice.
3. Add formatting and static analysis targets as CMake custom targets, not one-off commands in docs.
4. Add sanitizer and coverage presets before the code becomes pointer-heavy.
5. Keep third-party dependencies in `third_party/` as submodules or documented external packages.

## Boundary Choice

Use `libs/` when the repo is a collection of reusable libraries. Use `include/` plus `src/` when the repo builds one main native product or agent.

## Default Tool Stack

| Concern | Default |
| --- | --- |
| Build | CMake with `CMakePresets.json` |
| Test | GoogleTest and CTest |
| Formatting | clang-format |
| Warnings | compiler warning interface target, warnings-as-errors for first-party code |
| Static analysis | clang-tidy, cppcheck, include-what-you-use |
| Coverage | GCC coverage preset plus gcovr |
| Sanitizers | Clang ASan/UBSan preset; TSAN for threaded agents |
| Benchmarks | Google Benchmark for performance-sensitive libraries |
| Duplication | PMD CPD when large algorithm libraries start repeating logic |
| CI | format-check, static-analysis, build/test matrix, coverage |

Keep `make ci` mapped to the closest local equivalent of CI. For large native repos, that usually means configure/build/test, static analysis, sanitizer tests, and coverage in a predictable order.
