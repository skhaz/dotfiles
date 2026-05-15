# General Rules

## Go

- Run `golangci-lint run ./...` after any Go change.

## Python

- Use `uv` for everything (`uv run`, `uv venv`, `uv pip install`, `uv add`).
- Always work inside a `uv` virtual env. Never install globally.

## Package Management

- NEVER run `brew install`. Use Docker instead.

## Docker

- If Docker is not running, run `orb start` and wait until it is ready.

## C++

- RAII everywhere: smart pointers, no manual `new`/`delete`. Prefer move semantics, stack allocation, `emplace_back`, `reserve()`.
- Modern idioms: range-based `for`, structured bindings, `constexpr`/`const`, `std::string_view`/`std::span`, `[[nodiscard]]`. Pass large types by `const&` or by value (sink).
- Performance-first: prefer O(1)/O(N) algorithms and `ankerl::unordered_dense` over `std::unordered_map`/`std::unordered_set`.

## CLI Tools

- Run CLI tools via Docker instead of installing on the host.

## External API Access

- GitHub: use `gh` CLI exclusively. Never web fetch.
- GitLab (git.spiralscout.com): use `glab` CLI exclusively. Never web fetch.

## Code Quality

- Avoid N+1 queries. Use batch/bulk operations and eager loading.
- Minimal, effective changes. Modern, clean, concise style.
- Inline code by default. Extract a function only when reused or needed to clarify a complex statement.

## Linting and Static Analysis - ALWAYS

- Run a linter (and *also* an LSP) after every change, on every file type.
- Use each ecosystem's standard tooling.
- Fix all errors and warnings before finishing.

## Performance

- Adopt performance and memory best practices regardless of language.
- Prefer efficient algorithms and data structures (O(1)/O(log N)/O(N)).
- Minimize allocations: reuse buffers, avoid copies, prefer streaming.
- Release resources deterministically (RAII, `defer`, context managers, `using`).
- Profile before optimizing hot paths. Avoid premature optimization, but never write knowingly wasteful code.
- Prefer lazy evaluation, batching, and caching where appropriate.

## No Shortcuts

- No hacks, workarounds, or quick fixes.
- Fix root causes, not symptoms.
- **NEVER** leave `TODO` or `FIXME` comments. Everything must be resolved immediately, no exceptions.

## Code Style

- Always leave a blank line after closing a statement block (`}`, `end`, function, if, for, while, etc.).

## Comments - CRITICAL

- **COMMENTS ARE STRICTLY FORBIDDEN.** Zero exceptions, except the one below.
- The **ONLY** acceptable comment is one that justifies a genuine workaround or hack, and even then it must be the absolute last resort.
- Do **NOT** write explanatory, descriptive, redundant, or "what the code does" comments. Code must be self-explanatory through clear naming and structure.

## CI Cost - CRITICAL

- **CI IS EXTREMELY EXPENSIVE. DO NOT WASTE IT.**
- **ALWAYS** test, lint, type-check, and validate locally **BEFORE** any commit. No exceptions.
- Reproduce the full CI pipeline locally whenever possible (build, tests, linters, static analysis).
- **ONLY** commit after local validation passes. If local validation is impossible, state that explicitly.
- **GROUP** related changes into a single commit whenever possible. Avoid noisy commit chains that re-trigger CI repeatedly.
- After pushing, **MONITOR** the CI run until it completes. Do not walk away from a red or pending pipeline.
- A failing CI run caused by something that could have been caught locally is a serious mistake.

## Git Branches and Pull/Merge Requests

- **NEVER, EVER** create a git branch without explicit permission. Always ask first.
- **NEVER, EVER** create a pull request or merge request without explicit permission. Always ask first.
- This applies to all tools and CLIs (`git`, `gh`, `glab`, etc.). No exceptions.

## Git Commits

- **NEVER, EVER** commit without explicit permission. Always ask first.
- Before committing, you **MUST** have conclusive, empirical proof that the code is correct: tests passing, linters clean, type-checks green, and the feature manually verified when applicable. No guessing, no "should work".
- Do not waste reviewer time or pollute history with speculative, unverified, or work-in-progress commits.
- **NEVER** add co-authors to commits. No `Co-authored-by` trailers, ever.
- Keep commit messages brief and non-verbose. A few lines, covering only what is critical for the reader.

## Pull Request / Merge Request Descriptions

- Always brief and non-verbose. A few lines, covering only what is critical for the reader.
- For UI changes (web browser), include screenshots with captions.
- For changes to a service with a CLI, include logs and command-line examples.

## Emojis

- No emojis, anywhere, ever. Zero exceptions.

## Backend Workflow Orchestration

- Prefer temporal.io for backend orchestration, retries, scheduling, long-running processes, and distributed coordination. No ad-hoc cron, queues, or custom retry logic.

## Authorization (OpenFGA)

- Use OpenFGA for fine-grained authorization, ReBAC, role/permission checks, ownership, sharing, and multi-tenant access. Do not build custom authorization logic.

## Cross-Platform Portability

- Code must run on Windows, Linux, and macOS, on both x64 and ARM.
- Avoid OS-specific APIs, paths, or shell commands. Use cross-platform abstractions (`filepath`, `pathlib`, `std::filesystem`).
- Avoid architecture-specific assumptions: word size, endianness, pointer size, SIMD intrinsics without portable fallbacks.
- Test or build for all target OS/arch combinations before finishing.

