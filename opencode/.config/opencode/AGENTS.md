# General rules

## Go

- Always run `golangci-lint run ./...` after modifying Go code to check for lint errors before finishing the task.

## Python

- Always use `uv` instead of the system `python` or `pip` to run Python scripts, create virtual environments, manage dependencies, and install packages (e.g. `uv run`, `uv venv`, `uv pip install`, `uv add`).
