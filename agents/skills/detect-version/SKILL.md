---
name: detect-version
description: Determine the installed version and canonical documentation URL of a technology framework or language in the current project
context: fork
agent: Explore
arguments: [framework]
---

Determine the installed version and documentation URL of $0:

1. Search the project for version indicators:
   - JavaScript/Node: package.json, package-lock.json, yarn.lock, pnpm-lock.yaml
   - Python: pyproject.toml, requirements.txt, Pipfile.lock, setup.py
   - Go: go.mod
   - Rust: Cargo.toml, Cargo.lock
   - Elixir: mix.exs, mix.lock
   - Nix: flake.lock
   - Ruby: Gemfile, Gemfile.lock
   - And equivalent for the target ecosystem

2. Extract the exact installed version. If multiple packages match (e.g. monorepo), prefer the version in the current working directory or the primary package.

3. Determine the canonical documentation URL for this specific version:
   - For frameworks with versioned docs (Django, Rails, Laravel, etc.), construct the version-specific URL using known patterns (e.g. `https://docs.djangoproject.com/en/{version}/`).
   - For libraries with unversioned docs or single canonical sites, return the base URL (e.g. `https://react.dev/`).
   - If the pattern is uncertain, use WebFetch to confirm the correct URL structure for this version.
   - If the framework has no centralized docs, return the package registry or repository URL from package metadata.

4. Return ONLY in this exact format:
   ```
   VERSION: <version>
   DOCS_URL: <url>
   ```
   If undetermined:
   ```
   VERSION: unknown
   DOCS_URL: unknown
   ```
