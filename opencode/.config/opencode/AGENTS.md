# General Rules

## Go

- Run `golangci-lint run ./...` after any Go change.

## Python

- Use `uv` for everything (`uv run`, `uv venv`, `uv pip install`, `uv add`).
- Always use a uv virtual env (`uv venv` to create, activate before running). Never install packages globally.

## Package Management

- NEVER run `brew install`. Use Docker instead.

## C++

- RAII everywhere: smart pointers (`unique_ptr`/`shared_ptr`), no manual `new`/`delete`. Prefer move semantics, stack allocation, `emplace_back`, and `reserve()`.
- Modern idioms: range-based `for`, structured bindings, `constexpr`/`const`, `std::string_view`/`std::span`, `[[nodiscard]]`. Pass large types by `const&` or by value (sink).
- Performance-first: favor O(1)/O(N) algorithms, prefer `ankerl::unordered_dense` over `std::unordered_map`/`std::unordered_set`.

## CLI Tools

- Prefer running CLI tools via Docker (`docker run --rm -it <image>` or `docker exec` into existing container) instead of installing on host.

## External API Access

- GitHub: Use `gh` CLI exclusively. Never web fetch.
- GitLab (git.spiralscout.com): Use `glab` CLI exclusively. Never web fetch.
- Rule: Always use CLIs for git platform APIs. No direct HTTP fetch.

## Code Quality

- Avoid N+1 queries. Prefer batch/bulk operations and eager loading.
- Minimal, effective changes. Modern, clean, concise style.

## Code Style

- Always leave a blank line after closing a statement block (`}`, `end`, function, if, for, while, etc.). Applies whether next line is another statement, a variable declaration, or anything else.

## Git Commits

- NEVER add co-authors to commits. No `Co-authored-by` trailers, ever. No exceptions.

