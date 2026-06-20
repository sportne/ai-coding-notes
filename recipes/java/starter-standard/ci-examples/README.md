# CI Examples

These files are examples for CI systems other than GitHub Actions. Copy the file for the platform you use to the repository root and rename it if needed:

- `gitlab-ci.yml` -> `.gitlab-ci.yml`
- `bitbucket-pipelines.yml` -> `bitbucket-pipelines.yml`
- `Jenkinsfile` -> `Jenkinsfile`

The examples use the Gradle container image because this starter does not include a checked-in wrapper. After generating and committing a wrapper, replace `gradle qualityGate --console=plain` with `./gradlew qualityGate --console=plain`.
