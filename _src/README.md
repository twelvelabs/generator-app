# {{ .ProjectName }}

[![build](https://github.com/{{ .GithubUsername }}/{{ .ProjectDir }}/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/{{ .GithubUsername }}/{{ .ProjectDir }}/actions/workflows/build.yml)
[![codecov](https://codecov.io/gh/{{ .GithubUsername }}/{{ .ProjectDir }}/branch/main/graph/badge.svg?token=AVI3Z0Y6WE)](https://codecov.io/gh/{{ .GithubUsername }}/{{ .ProjectDir }})

{{ .ProjectDescription }}

## Installation

Choose one of the following:

- Download and install the latest
  [release](https://github.com/{{ .GithubUsername }}/{{ .ProjectDir }}/releases/latest) :octocat:

- Install with [Docker](https://www.docker.com) 🐳

  ```shell
  docker pull ghcr.io/{{ .GithubUsername }}/{{ .ProjectDir }}:latest
  ```

- Install with [Homebrew](https://brew.sh/) 🍺

  ```bash
  brew install {{ .GithubUsername }}/tap/{{ .ProjectDir }}
  ```

- Install from source 💻

  ```bash
  go install github.com/{{ .GithubUsername }}/{{ .ProjectDir }}@latest
  ```

## Documentation

TODO

## Development

```shell
git clone git@github.com:{{ .GithubUsername }}/{{ .ProjectDir }}.git
cd {{ .ProjectDir }}

# Ensures all required dependencies are installed
# and bootstraps the project for local development.
make setup

make build
make test
make install

# Show help.
make
```
