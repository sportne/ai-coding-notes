# Java Gradle Native Image Starter

This starter is a partial implementation of the Java Gradle multi-module recipe for projects that need GraalVM Native Image compatibility.

It does not include application source code. Native Image tasks become runnable after you add a real application entrypoint and replace the placeholder main class.

## Before Use

Replace these placeholders:

- `<project-name>`: root project name.
- `<group-id>`: Maven group, such as `com.example`.
- `<version>`: project version.
- `<main-class>`: fully qualified application main class.
- `project-api`, `project-core`, `project-app`, `project-native-tests`, `project-architecture-tests`: module names that fit the project.

Then add Java packages and source files only when there is real behavior to implement.

## Initial Commands

```bash
gradle wrapper
./gradlew qualityGate --console=plain
```

After real application code exists:

```bash
./gradlew nativeSmoke --console=plain
```

If the Gradle wrapper is not created yet, run commands with `gradle` instead of `./gradlew`.

## Included Structure

- root Gradle settings and quality gate tasks
- version catalog
- included `build-logic` convention plugins
- Checkstyle, SpotBugs, Spotless, Error Prone, JUnit, JaCoCo, ArchUnit, and GraalVM Native Build Tools wiring
- application and native-test module placeholders
- docs and task placeholders
- optional GitLab, Bitbucket, and Jenkins examples in `ci-examples/`
