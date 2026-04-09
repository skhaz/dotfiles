# General rules

## Go

- Always run `golangci-lint run ./...` after modifying Go code to check for lint errors before finishing the task.

## Python

- Always use `uv` instead of the system `python` or `pip` to run Python scripts, create virtual environments, manage dependencies, and install packages (e.g. `uv run`, `uv venv`, `uv pip install`, `uv add`).

## Package Management

- Always prefer installing tools and runtimes via `mise` (e.g. `mise use`, `mise install`) instead of `brew` or other package managers.
- NEVER run `brew install` autonomously. Always ask for explicit user permission before installing anything via `brew`.
- When suggesting installation of any CLI tool, language runtime, or development dependency, check if it can be managed by `mise` first.
