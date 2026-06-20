# CI Examples

These files are examples for CI systems other than GitHub Actions. Copy the file for the platform you use to the repository root and rename it if needed:

- `gitlab-ci.yml` -> `.gitlab-ci.yml`
- `bitbucket-pipelines.yml` -> `bitbucket-pipelines.yml`
- `Jenkinsfile` -> `Jenkinsfile`

Each example installs the C++ tool stack and runs `make ci`, matching the local validation gate.
