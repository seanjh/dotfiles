---
description: Propose and iterate on test coverage before writing tests
---

## Process

You will guide me through a **test coverage planning** workflow. The goal is to agree on *what* to test before writing any test code. 100% coverage is not the goal — focus on the major code paths and edge cases that matter for correctness. Prefer unit tests (tightest feedback loop), but consider a very limited number of integration, e2e, or browser tests where appropriate.

### Phase 1: Propose Coverage

1. Analyze the code I specify (new or modified code)
2. Identify **entry points / code paths** that need coverage
3. For each entry point, propose specific **test cases** with concrete assertions (expected inputs and outputs)
4. Present the coverage plan as a structured list

### Phase 2: Iterate

- We discuss the plan back and forth
- I may add, remove, or refine test cases
- DO NOT write any test code during this phase
- DO NOT create TODO items yet

### Phase 3: TODOs

Once I approve the coverage plan:

1. Create a TODO (checklist item) for each test case
2. Each TODO should reference the specific test case and its assertions
3. Present the TODOs for my final approval

### Phase 4: Implement

Once TODOs are approved:

1. Implement tests **one TODO at a time**
2. Show the implementation before moving to the next
3. After each TODO, run **only that test case** to confirm it passes

### Phase 5: Verify

After all new tests are implemented and each passes individually:

1. **Run the full test suite** for the affected module/package — confirm everything passes together
2. **Run linters, formatters, and type checkers** — ensure all configured tooling passes cleanly (e.g. `ruff`, `mypy`, `tsc`, `eslint`)
3. **Check for regressions** — run any *pre-existing* test files in the same package/module directory (tests not created or modified during this session). Report any failures immediately.

## Rules

- ALWAYS propose test cases with specific assertions (expected inputs/outputs)
- ALWAYS wait for my feedback before moving to the next phase
- NEVER write test code during Phase 1 or 2
- NEVER skip the TODO creation step
- ALWAYS prioritize clarity of *what* is being tested over *how*
- ALWAYS test what the code does, not how it does it — assert against public contracts, not internal implementation
- ALWAYS use `/docs` to anchor framework/library testing conventions in official documentation
- NEVER modify the code under test — tests must cover existing behavior. If a test reveals a bug or a change to the code under test is needed, stop and discuss before making any changes.
