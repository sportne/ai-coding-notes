# Java Gradle Multi-Module Recipe

Use this for Java libraries, JVM-adjacent tooling, modular applications, and projects that may need publishing, architecture tests, or native-image checks later.

Copyable partial scaffolds:

- [starter-standard](starter-standard/) for normal JVM library or application projects.
- [starter-native-image](starter-native-image/) for projects that need GraalVM Native Image wiring.

## Directory Shape

```text
.
├── AGENT.md or AGENTS.md
├── README.md
├── build.gradle
├── settings.gradle
├── gradle.properties
├── gradle/
│   ├── libs.versions.toml
│   └── wrapper/
├── build-logic/
│   ├── build.gradle
│   ├── settings.gradle
│   └── src/main/groovy/
├── config/
│   ├── checkstyle/
│   ├── spotbugs/
│   ├── spotless/
│   ├── errorprone/
│   └── archunit/
├── docs/
│   ├── architecture/
│   ├── adr/
│   ├── verification/
│   ├── charter.md
│   ├── scope.md
│   └── roadmap.md
├── modules/
│   ├── <project>-bom/
│   ├── <project>-api/
│   ├── <project>-core/
│   ├── <project>-testkit/
│   └── <project>-architecture-tests/
├── examples/
├── scripts/
└── .github/workflows/
```

## Module Naming

Prefer modules that describe boundaries, not implementation details:

- `*-api`: public interfaces and stable types.
- `*-core`: main implementation.
- `*-generator` or `*-codegen`: source generation.
- `*-cli`: command-line entrypoint.
- `*-testkit`: reusable fixtures and assertions.
- `*-architecture-tests`: ArchUnit or boundary checks.
- `*-bom`: Maven dependency management for published libraries.
- `examples:*`: runnable examples that are not published as library artifacts.

## Gradle Settings Pattern

Use `settings.gradle` to centralize repositories and include modules.

```groovy
pluginManagement {
    includeBuild 'build-logic'
    repositories {
        gradlePluginPortal()
        mavenCentral()
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        mavenCentral()
    }
}

rootProject.name = '<project-name>'

include ':modules:<project>-api'
include ':modules:<project>-core'
include ':modules:<project>-testkit'
include ':modules:<project>-architecture-tests'
include ':examples:basic'
```

For projects that need repeatable offline work, add an explicit `-P<shortname>.offlineRepo=/path/to/repo` property and document it.

## Root Tasks

Recent Java projects converge on these root tasks:

- `checkAll`: runs every included module's `check`.
- `qualityGate`: local and CI default; usually docs validation, checks, formatting, coverage, and Javadoc.
- `nativeSmoke`: optional GraalVM lane when native-image matters.
- `releaseDryRun` or `verifyReleaseDryRun`: for publishable artifacts.
- `printPublishedArtifacts`: simple audit of coordinates before release.

Example root task shape:

```groovy
tasks.register('checkAll') {
    group = 'verification'
    dependsOn checkedProjects.collect { "${it}:check" }
}

tasks.register('qualityGate') {
    group = 'verification'
    dependsOn 'checkAll'
    dependsOn checkedProjects.collect { "${it}:spotlessCheck" }
    dependsOn checkedProjects.collect { "${it}:jacocoTestCoverageVerification" }
}

tasks.named('check') {
    dependsOn tasks.named('qualityGate')
}
```

## AI Workflow

1. Ask the agent to create the Gradle skeleton with wrapper, `build-logic`, and one `api` plus one `core` module.
2. Require `./gradlew qualityGate` to pass after every meaningful milestone.
3. Add `docs/architecture` and `docs/verification` before adding more than three modules.
4. Add `examples/basic` once the first public API exists.
5. Add `architecture-tests` when package boundaries or dependencies become part of the design.

## When To Keep It Smaller

For small Java experiments, use one `app/` or `lib/` module, root `build.gradle`, `settings.gradle`, Gradle wrapper, `config/`, `docs/`, and `tasks/`. Still keep a single root `check` or `qualityGate`.

## Default Tool Stack

| Concern | Default |
| --- | --- |
| Test | JUnit Jupiter through the JUnit BOM |
| Formatting | Spotless |
| Style | Checkstyle in `config/checkstyle` |
| Static analysis | Error Prone at compile time, SpotBugs after compile |
| Architecture | ArchUnit in `modules/*-architecture-tests` |
| Coverage | JaCoCo report and `jacocoTestCoverageVerification` |
| Dependency hygiene | version catalog, dependency locking, `RepositoriesMode.FAIL_ON_PROJECT_REPOS` |
| Release hygiene | BOM module, sources jar, Javadoc jar, local release dry-run |
| Native checks | GraalVM Native Build Tools, only for native-sensitive projects |

Default mature gate:

```text
./gradlew qualityGate --console=plain
```

Add PMD/CPD only when the project has enough algorithmic or generated-like code for duplicate detection to pay for itself.
