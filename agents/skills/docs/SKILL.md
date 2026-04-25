---
name: docs
description: Explain a library/framework concept with primary source documentation references
context: fork
---

Explain: $ARGUMENTS

## Process

1. Identify the language, library, or framework the concept belongs to.

2. Find the installed version - search for `package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, `flake.lock`, `mix.exs`, or equivalent in the current working directory.

3. Gather primary sources in priority order:
   - **Official documentation**: fetch version-matched docs via WebFetch. Quote directly - include section heading or URL.
   - **Closed-source libraries**: documentation quotes are the primary evidence. Be precise - include exact wording, section titles, and version.

4. Build the explanation - every major claim anchored to a source. Flag inferences explicitly.

## Output format

- 1-2 sentence summary of the concept.
- Organized around primary sources: quote or cite, then explain significance.
- For source references, give enough path to locate the file
  (e.g., `net/http/server.go` not just `server.go`).
- If version could not be determined, note it and state which version applies.
