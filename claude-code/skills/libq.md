---
description: Explain a concept with primary source references
---

Explain: $ARGUMENTS

## Process

**1. Identify** the language, library, or framework the concept belongs to.

**2. Check the installed version** in this project — look in `package.json`,
`pyproject.toml`, `go.mod`, `Cargo.toml`, `flake.lock`, or equivalent. Use
this version when fetching or quoting documentation so references are accurate.

**3. Gather primary sources** in priority order:

- **Source code** (preferred when available): Search the library source with
  Grep/Read. Cite file paths relative to the library's source root (e.g.,
  `src/runtime/chan.go`, `lib/active_record/relation.rb`). Quote directly from
  source comments, type signatures, or implementation where they illuminate
  the concept.
- **Official documentation**: Fetch version-matched docs. Quote directly — do
  not paraphrase when a direct quote is more precise. Include the section
  heading or URL.
- **Closed-source libraries**: Source is unavailable, so documentation quotes
  are the primary evidence. Be precise — include exact wording, section
  titles, and version.

**4. Build the explanation around the sources** — every major claim should be
anchored to a specific reference. If something is your inference rather than
directly stated in a source, say so explicitly.

## Output format

- Open with a 1–2 sentence summary of the concept.
- Organize around the primary sources: quote or cite, then explain significance.
- For source references, give enough path to locate the file
  (e.g., `net/http/server.go` not just `server.go`).
- If the installed version cannot be determined, note that and state which
  version the references apply to.
