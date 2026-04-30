# General Rules

## Go

- Run `golangci-lint run ./...` after any Go change.

## Python

- Use `uv` for everything (`uv run`, `uv venv`, `uv pip install`, `uv add`).
- Always use a uv virtual env (`uv venv` to create, activate before running). Never install packages globally.

## Package Management

- NEVER run `brew install`. Use Docker instead.

## Docker

- If Docker is not running, run `orb start` and wait until it becomes available again before proceeding.

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
- Create functions/methods only when strictly necessary, reused more than once, or needed to simplify a complex statement. Otherwise inline the code — extra indirection forces the reader to jump around and hurts readability.

## Performance

- Always adopt best practices for performance and memory usage, regardless of language or domain.
- Prefer efficient algorithms and data structures (favor O(1)/O(log N)/O(N) over higher complexity).
- Minimize allocations: reuse buffers, avoid unnecessary copies, prefer streaming over loading-all-in-memory.
- Release resources deterministically (RAII, `defer`, context managers, `using`, etc.).
- Profile before optimizing hot paths; avoid premature optimization but never write knowingly wasteful code.
- Prefer lazy evaluation, batching, and caching where appropriate; avoid redundant work and repeated computation.

## No Shortcuts

- Shortcuts, hacks, workarounds, and quick fixes are strictly forbidden.
- Problems must be solved with clean, clear, modern code.
- Never mask symptoms: identify the root cause and fix it properly.
- No `TODO`/`FIXME` left for later — resolve it now or open a tracked issue.

## Code Style

- Always leave a blank line after closing a statement block (`}`, `end`, function, if, for, while, etc.). Applies whether next line is another statement, a variable declaration, or anything else.

## Git Commits

- NEVER add co-authors to commits. No `Co-authored-by` trailers, ever. No exceptions.

## Emojis

- No emojis, anywhere, ever. Not in code, comments, commit messages, PR descriptions, documentation, chat output, file names, or any other context. Zero exceptions.

## Backend Workflow Orchestration
- **Always prefer temporal.io whenever possible for backend work.** Use Temporal workflows and activities for any backend orchestration, retries, scheduling, long-running processes, or distributed coordination instead of ad-hoc cron jobs, queues, or custom retry logic.

## Authorization (OpenFGA)
- **Always use OpenFGA whenever it is useful.** For any fine-grained authorization, relationship-based access control (ReBAC), role/permission checks, resource ownership, sharing, or multi-tenant access decisions, use OpenFGA instead of building custom authorization logic. Never reinvent the wheel — model the authorization in OpenFGA and call its API.

## Parallel Agent Sessions
- Use git worktrees to run multiple agent sessions in parallel.

