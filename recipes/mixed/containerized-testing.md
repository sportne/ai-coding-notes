# Containerized Testing Pattern

Use this when tests need a dependency or operating environment that is too
heavy, stateful, or machine-specific for the default fast gate: databases,
service APIs, GUI stacks, native toolchains, external implementations, or
cross-runtime interop.

The pattern in the sibling projects is consistent:

1. Keep the normal local gate fast and host-friendly.
2. Put container-backed checks behind explicit commands.
3. Make startup, readiness, artifacts, and teardown part of the test contract.
4. Treat missing container prerequisites as reported infrastructure state, not
   as a vague skip or false pass.

## Directory Shape

```text
.
|-- README.md
|-- Makefile or build.gradle
|-- docs/
|   `-- ci.md or verification.md
|-- containers/ or interop/container/
|   |-- <lane>/Dockerfile
|   `-- entrypoint.sh
|-- docker-compose.yml
|-- scripts/
|   `-- live-*.sh or integration-*.sh
|-- tests/
|   |-- unit/
|   `-- integration/
`-- .github/workflows/
```

Not every project needs every piece. Use `docker-compose.yml` for service
dependencies, a dedicated `containers/<lane>/Dockerfile` for a reproducible
execution environment, and a manifest-driven `interop/` area when testing
against approved external implementations.

## Three Useful Shapes

### Service Dependency

Use Compose when the project tests against a real server but the application
code still runs on the host.

Observed example: `python-sonarqube-api` starts SonarQube with
`docker-compose up -d` from a session-scoped pytest fixture, polls
`/api/system/status` until the service is `UP`, runs a scanner container, then
calls `docker-compose down` during teardown. Its `make test` command excludes
`tests/integration`; `make test-integration` is the explicit container-backed
lane.

Rules:

- Keep unit tests independent of Compose.
- Start the dependency from the test harness or a named script, not manually.
- Poll a real readiness endpoint before running assertions.
- Tear the dependency down on failure as well as success.
- Use stable ports only when the developer workflow needs them; otherwise
  prefer isolated networks and generated ports.

### Live Environment

Use a dedicated image when the test needs a full OS-level environment, not just
a backing service.

Observed example: `motif-tap-harness` builds
`containers/live-loop/Dockerfile` and runs real Motif/X11 workflows under Xvfb
and a window manager. The default `make check` stays fast. The live-loop lane is
invoked explicitly with:

```bash
docker build -f containers/live-loop/Dockerfile -t motif-tap-live-loop .
docker run --rm motif-tap-live-loop scripts/live-loop-demo.sh
```

It supports Podman with the same Dockerfile, writes artifacts under
`MOTIF_TAP_LIVE_ARTIFACT_DIR`, and documents bind-mount commands for preserving
logs after the container exits.

Rules:

- Name the lane after the behavior it proves, such as `live-loop`, not just
  `docker`.
- Put orchestration in scripts that can run inside the image and in CI.
- Keep runtime artifacts out of source control and make the artifact directory
  configurable by environment variable.
- Document Docker and Podman commands when both work.
- Trigger CI only for paths that can affect the lane, and upload artifacts on
  failure.

### External Peer Interop

Use a manifest-driven harness when tests involve third-party implementations,
licensed artifacts, or expensive live compatibility claims.

Observed example: `mundane-java-orb` keeps peer source and binaries out of the
repo. Its interop harness validates approved artifact caches, digest-pinned base
images, Docker/Podman availability, prepared peer images, mounted scenario IDL,
IOR/log/report paths, and peer health commands before live execution. It has
`--dry-run` commands by default and requires `--require-live` for real peer
execution. Missing cache, runtime, base image, peer image, or live approval
produces deterministic structured reports such as
`"missingPrerequisite": "container-runtime"`.

Rules:

- Default to dry-run metadata checks when live execution is expensive or
  externally gated.
- Require an explicit live flag for claims about external compatibility.
- Pin base images by digest before real builds.
- Validate artifact provenance and checksums before staging container builds.
- Write structured reports for infrastructure failures and missing
  prerequisites.
- Do not vendor peer source, binaries, generated peer outputs, or raw live
  evidence unless the project has an explicit policy allowing it.

## Root Commands

Expose the split clearly:

```makefile
check: lint format-check test

test:
	$(PYTHON) -m pytest --ignore=tests/integration

test-integration:
	$(PYTHON) -m pytest tests/integration --run-integration

container-live:
	docker build -f containers/live-loop/Dockerfile -t project-live-loop .
	docker run --rm project-live-loop scripts/live-loop-demo.sh
```

Add `make doctor` or an equivalent task when container-backed tests are common.
It should fail for prerequisites required by the fast gate and warn for optional
container/live prerequisites.

## Documentation Checklist

Document these before relying on the lane in CI:

- The exact local command to build and run the container-backed check.
- Whether Docker, Podman, or Compose is supported.
- Which tests are excluded from the fast gate and why.
- Readiness behavior and timeout.
- Teardown behavior.
- Artifact location, retention policy, and how to bind-mount artifacts locally.
- Environment variables for runtime selection, cache paths, ports, and live
  approval.
- CI trigger paths, timeout, cancellation behavior, and artifact upload policy.
- The difference between a product failure, infrastructure failure, unsupported
  scenario, and missing prerequisite.

## CI Guidance

Put container-backed checks in CI only after they are reproducible locally.

- Fast lane: run on every push and pull request.
- Service dependency lane: run on relevant source/test changes, or on every PR
  if startup time is acceptable.
- Live environment lane: run on paths that affect the harness, scripts,
  examples, container image, tests, or workflows.
- External peer lane: run dry-run validation by default; run live compatibility
  only with approved caches, pinned images, and explicit live approval.

When CI does not run the live lane for every change, say that directly in
`docs/ci.md` or `docs/verification.md` and give the local command maintainers
should run before making compatibility claims.
