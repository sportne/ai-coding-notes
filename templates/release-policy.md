# Release Policy

Use this as `docs/release-policy.md` in a project.

## Versioning

Versions are represented by git tags.

Use semantic version numbers for tags:

```text
vMAJOR.MINOR.PATCH
```

Examples:

```text
v0.1.0
v0.2.0
v1.0.0
```

## Backwards Compatibility

Before `v1.0.0`, backwards compatibility is intentionally ignored. APIs, configuration formats, schemas, file layouts, command names, generated output, and task conventions may change freely when doing so makes the project simpler or better.

At `v1.0.0` and later, compatibility expectations must be documented before making breaking changes. Breaking changes should be called out in release notes or a migration note.

## Distribution

By default, releases are not published to central package repositories such as PyPI, Maven Central, npm, crates.io, or system package registries.

Release artifacts, if any, are attached to repository releases, documented as build-from-source outputs, or distributed through project-specific channels.

If a project starts publishing to a central repository, record that decision in an ADR and update this policy.

## Release Checklist

- [ ] Full local quality gate passes.
- [ ] CI is green for the release commit.
- [ ] Version tag is created from the intended commit.
- [ ] Release notes summarize user-visible changes.
- [ ] Compatibility impact is documented for `v1.0.0` or later.
- [ ] Artifact smoke test passes if artifacts are produced.
