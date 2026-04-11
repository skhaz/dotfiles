# General rules

## Go

- Always run `golangci-lint run ./...` after modifying Go code to check for lint errors before finishing the task.

## Python

- Always use `uv` instead of the system `python` or `pip` to run Python scripts, create virtual environments, manage dependencies, and install packages (e.g. `uv run`, `uv venv`, `uv pip install`, `uv add`).

## Package Management

- Always prefer installing tools and runtimes via `mise` (e.g. `mise use`, `mise install`) instead of `brew` or other package managers. Or use Docker.
- NEVER run `brew install` autonomously. Always ask for explicit user permission before installing anything via `brew`.
- When suggesting installation of any CLI tool, language runtime, or development dependency, check if it can be managed by `mise` first.

## C++

- Prefer move semantics over copies. Use `std::move` to transfer ownership whenever an object is no longer needed at the call site.
- Avoid unnecessary heap allocations. Prefer stack allocation, `std::array`, and in-place construction (`emplace_back`, `emplace`) over `new` or redundant `std::vector` resizing.
- Favor O(1) or O(N) algorithms. Avoid O(N²) or worse unless proven necessary and documented. Prefer hash-based containers (`std::unordered_map`, `std::unordered_set`) when lookup performance matters.
- Avoid copies of non-trivial objects. Pass large or owning types by `const&` for read-only access, and by value when the function will consume (sink) the argument — the "sink by value" / "pass-by-value-then-move" idiom.
- Use the sink parameter idiom: accept parameters by value and `std::move` them into their final destination. This lets callers choose whether to copy or move while keeping the API simple.
- Prefer `std::string_view` and `std::span` for non-owning read-only access instead of `const std::string&` or raw pointer + size pairs.
- Always call `reserve()` on containers (`std::vector`, `std::string`, etc.) when the final size is known or can be estimated, to avoid repeated reallocations and copies during growth.
- Use `std::back_inserter` with STL algorithms (e.g. `std::copy`, `std::transform`) to append to containers without manual indexing or pre-sizing, keeping code concise and safe.
- Prefer range-based `for` loops and structured bindings (`auto& [key, value]`) for cleaner iteration over containers and maps.
- Use `constexpr` and `const` aggressively. Mark functions, variables, and expressions `constexpr` whenever possible to enable compile-time evaluation.
- Prefer smart pointers (`std::unique_ptr`, `std::shared_ptr`) over raw owning pointers. Use `std::make_unique` and `std::make_shared` for exception-safe construction.
- When wrapping C-style resources or handles that require a specific cleanup function (e.g. `fclose`, `SDL_DestroyWindow`, OpenSSL handles), use `std::unique_ptr` with a custom deleter to ensure automatic and exception-safe cleanup.
- Prefer RAII (Resource Acquisition Is Initialization) for all resource management — files, locks, memory, sockets. Avoid manual `new`/`delete` and explicit cleanup logic.
- Use `[[nodiscard]]` on functions whose return values should not be silently ignored (e.g. error codes, allocated resources, computed results).

## Code Quality & Performance

- Avoid N+1 query problems at all costs. Always prefer batch/bulk operations, eager loading, or preloading over iterative individual queries.
- Always seek minimal and effective changes with a focus on performance and elegance.
- Favor a modern, minimalist coding style — clean, concise, and intentional.
