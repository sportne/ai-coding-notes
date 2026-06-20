# Demo Or Harness Recipe

Use this when a project is more than a normal library: GUI automation, generated tests, containers, external tools, examples, recordings, language interop, assets, or benchmark harnesses.

## Directory Shape

```text
.
├── README.md
├── Makefile or build.gradle
├── docs/
│   ├── architecture.md
│   ├── limitations.md
│   ├── local-porting-checklist.md
│   ├── recording-and-translation.md
│   └── test-automation-approach.md
├── examples/
│   ├── README.md
│   ├── generated_tests/
│   ├── recordings/
│   └── <demo-app>/
├── scripts/
├── tasks/
├── containers/
├── assets/
├── c/ or native/
├── src/
└── tests/
```

## What Makes Harness Projects Different

- They depend on local machine state: GUI libraries, external solvers, container runtimes, X11, audio, assets, or native compilers.
- They need `make doctor` or equivalent environment checks.
- They benefit from examples that are runnable and inspectable.
- They should separate generated output from checked-in source.
- They need docs for limitations and porting, not just architecture.

## Useful Root Commands

- `make doctor`: report missing local prerequisites.
- `make check`: run lint, format-check, tests, and native helper builds.
- `make build-hook` or `make build-native`: compile small native parts.
- `make demo-*`: run a deterministic demo path.
- `make clean`: remove generated artifacts and native build outputs.

## AI Workflow

1. Ask the agent to identify local prerequisites and encode them in `make doctor`.
2. Create one deterministic example before broadening the harness.
3. Keep captured recordings, generated tests, and translated artifacts in named subdirectories.
4. Add docs for what is known not to work.
5. Make CI run the headless or dependency-light path; document manual lanes separately.

## Prompt Starter

```text
Create a harness-style project scaffold.

Include docs for architecture, limitations, local setup, and validation.
Add examples/, recordings or generated output directories as appropriate, scripts/, tasks/, and tests/.
Add make doctor, make check, and one deterministic demo command.
Keep external tools optional unless the first slice requires them, and document each prerequisite.
```

## Default Tool Stack

| Concern | Default |
| --- | --- |
| Fast tests | pytest or the primary ecosystem's normal test runner |
| Formatting | Ruff format for Python; native formatter for C/C++/Java parts |
| Static checks | Ruff check plus compiler warnings |
| Native helper build | dedicated `make build-*` target |
| Environment validation | `make doctor` |
| Containers | separate Docker/Podman workflow |
| GUI/live-loop | separate manual or scheduled workflow |
| Generated artifacts | deterministic examples plus reviewable output directories |

The fast gate should avoid machine-specific failures. Put X11, external solver, live service, hardware, and provider-backed checks behind explicit target names.
