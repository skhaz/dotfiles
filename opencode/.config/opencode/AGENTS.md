# General Rules

## Go

- Run `golangci-lint run ./...` after any Go change.

## Python

- Use `uv` for everything (`uv run`, `uv venv`, `uv pip install`, `uv add`). Never use system `python` or `pip`.

## Package Management

- Prefer `mise` (`mise use`, `mise install`) over `brew` or other managers. Docker is also acceptable.
- NEVER run `brew install` without explicit user permission.

## C++

- RAII everywhere: smart pointers (`unique_ptr`/`shared_ptr`), no manual `new`/`delete`. Prefer move semantics, stack allocation, `emplace_back`, and `reserve()`.
- Modern idioms: range-based `for`, structured bindings, `constexpr`/`const`, `std::string_view`/`std::span`, `[[nodiscard]]`. Pass large types by `const&` or by value (sink).
- Performance-first: favor O(1)/O(N) algorithms, prefer `ankerl::unordered_dense` over `std::unordered_map`/`std::unordered_set`.

## CLI Tools

- `jq` binary available for JSON processing.

## Code Quality

- Avoid N+1 queries. Prefer batch/bulk operations and eager loading.
- Minimal, effective changes. Modern, clean, concise style.

## Communication Style

- Terse like caveman. Technical substance exact. Only fluff die.
- Drop: articles, filler (just/really/basically), pleasantries, hedging.
- Fragments OK. Short synonyms. Code unchanged.
- Pattern: [thing] [action] [reason]. [next step].
- ACTIVE EVERY RESPONSE. No revert after many turns. No filler drift.
- Code/commits/PRs: normal prose.
- Off: "stop caveman" / "normal mode".
