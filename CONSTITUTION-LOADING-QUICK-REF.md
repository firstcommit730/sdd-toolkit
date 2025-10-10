# Quick Reference: Constitutional Loading Strategies

## Script Usage

```bash
# Location
.specify/scripts/bash/load-constitution.sh

# Presets
load-constitution.sh backend    # Backend projects
load-constitution.sh frontend   # Frontend projects
load-constitution.sh infra      # Infrastructure projects
load-constitution.sh core       # Minimal (core + branching)
load-constitution.sh full       # All sections (use sparingly)

# Explicit sections
load-constitution.sh "core,testing,security"
load-constitution.sh "architecture,observability"
```

## Prompt-Specific Strategies

### @specify

**Strategy**: Project type preset
**Default**: `backend`
**Sections**: core, testing, security, observability, architecture, branching
**Tokens**: ~12,000

### @plan

**Strategy**: Planning-focused
**Sections**: `core,architecture,testing,branching`
**Tokens**: ~10,000

### @tasks

**Strategy**: Context-aware
**Detection**: Based on plan.md and artifacts

- Testing: `testing,branching`
- API/services: `core,architecture,security,branching`
- Infrastructure: `core,operations,security,branching`
  **Tokens**: ~5,000

### @implement

**Strategy**: Just-in-time per file
**Detection**: Based on file being implemented

- `*.test.*`: `testing,branching`
- `*service*`: `core,architecture,observability,branching`
- `*auth*`: `core,security,branching`
- `*model*`: `core,architecture,branching`
- `*route*`: `core,architecture,security,branching`
- `*.yml`: `operations,security,branching`
  **Tokens**: ~4,000 per task

### @audit

**Strategy**: Progressive 3-phase

- **Phase 1** (always): `core,testing,security,branching`
- **Phase 2** (if issues): Add `architecture`, `observability`, or `operations`
- **Phase 3** (if score < 80%): Add `optional`
  **Tokens**: 8,000-20,000 depending on quality

## Section Contents Quick Reference

| Section           | Contains                                              | Use When                 |
| ----------------- | ----------------------------------------------------- | ------------------------ |
| **core**          | Tech stack, coding standards, linting, error handling | Always (fundamental)     |
| **testing**       | Coverage, test org, security tests, mocking           | Writing/reviewing tests  |
| **security**      | Auth, secrets, validation, encryption                 | Security-sensitive code  |
| **observability** | Logging, metrics, tracing                             | Services, monitoring     |
| **architecture**  | Patterns, API design, database                        | Design decisions         |
| **operations**    | Versioning, toggles, dependencies                     | Deployment, config       |
| **optional**      | Docs, glossary, roadmap                               | Documentation work       |
| **branching**     | Git workflow, commits                                 | Branch/commit operations |

## Best Practices

1. **Use presets** when possible (backend, frontend, infra)
2. **Load only needed sections** for specific operations
3. **Re-load on context change** (different file types in @implement)
4. **Start minimal** and add sections if needed
5. **Track token usage** to optimize further

## File Locations

```
Constitution Sections:
.specify/templates/constitution/
├── core.md
├── testing.md
├── security.md
├── observability.md
├── architecture.md
├── operations.md
└── optional.md

Branching Standards:
.specify/memory/branching-standards.md

Loading Script:
.specify/scripts/bash/load-constitution.sh
```

## Common Patterns

### Loading for API development

```bash
load-constitution.sh "core,architecture,security,observability,branching"
```

### Loading for test writing

```bash
load-constitution.sh "testing,branching"
```

### Loading for infrastructure

```bash
load-constitution.sh "core,operations,security,branching"
```

### Loading for full audit

```bash
# Phase 1
load-constitution.sh "core,testing,security,branching"

# Phase 2 (if issues)
load-constitution.sh "architecture"
load-constitution.sh "observability"
load-constitution.sh "operations"

# Phase 3 (if score < 80%)
load-constitution.sh "optional"
```
