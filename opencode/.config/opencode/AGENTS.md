# General Rules

## Go

- Run `golangci-lint run ./...` after any Go change.

## Python

- Use `uv` for everything (`uv run`, `uv venv`, `uv pip install`, `uv add`). Never use system `python` or `pip`.

## Package Management

- Prefer `mise` (`mise use`, `mise install`) over `brew` or other managers. Docker is also acceptable.
- NEVER run `brew install` without explicit user permission.

## C++

- Prefer move semantics and `std::move` over copies. Use sink-by-value idiom.
- Avoid heap allocations; prefer stack, `std::array`, `emplace_back`/`emplace`.
- Favor O(1)/O(N) algorithms. Prefer `ankerl::unordered_dense` or similar high-performance libraries over `std::unordered_map`/`std::unordered_set`.
- Pass large types by `const&` (read-only) or by value (sink). Use `std::string_view`/`std::span` for non-owning access.
- Call `reserve()` when size is known. Use `std::back_inserter` with STL algorithms.
- Prefer range-based `for`, structured bindings, `constexpr`/`const` aggressively.
- Use smart pointers (`std::unique_ptr`, `std::shared_ptr`) and `std::make_unique`/`std::make_shared`. Use `unique_ptr` with custom deleters for C-style resources.
- RAII for all resources. No manual `new`/`delete`.
- Use `[[nodiscard]]` on functions whose return values must not be ignored.

## Code Quality

- Avoid N+1 queries. Prefer batch/bulk operations and eager loading.
- Minimal, effective changes. Modern, clean, concise style.
