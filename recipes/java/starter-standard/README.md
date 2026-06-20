# Java Gradle Multi-Module Starter

This starter is a partial implementation of the Java Gradle multi-module recipe without application or library source code.

## Before Use

Replace these placeholders:

- `<project-name>`: root project name.
- `<group-id>`: Maven group, such as `com.example`.
- `<version>`: project version.
- `project-api`, `project-core`, `project-testkit`, `project-architecture-tests`: module names that fit the project.

Then add Java packages and source files only when there is real behavior to implement.

## Initial Commands

```bash
gradle wrapper
./gradlew qualityGate --console=plain
```

If the Gradle wrapper is not created yet, run commands with `gradle` instead of `./gradlew`.

## Included Structure

- root Gradle settings and quality gate tasks
- version catalog
- included `build-logic` convention plugins
- Checkstyle, SpotBugs, Spotless, Error Prone, JUnit, JaCoCo, and ArchUnit wiring
- empty module placeholders
- docs and task placeholders
- optional GitLab, Bitbucket, and Jenkins examples in `ci-examples/`
