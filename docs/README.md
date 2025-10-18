# SDD Workflow Documentation

Complete flow diagrams and documentation for the Specification Driven Development (SDD) workflow.

## Overview

The SDD workflow consists of six main prompts that work together to transform a natural language feature description into a working implementation:

### Core Development Workflow

1. **[@ssd-specify](flow-specify.md)** - Create feature specification
2. **[@ssd-plan](flow-plan.md)** - Design implementation with artifacts
3. **[@ssd-tasks](flow-tasks.md)** - Generate dependency-ordered task list
4. **[@ssd-implement](flow-implement.md)** - Execute the implementation

### Quality & Compliance

5. **[@audit](flow-audit.md)** - Validate implementation quality
6. **[@ssd-drift](flow-drift.md)** - Detect project-wide constitutional drift

See [Workflow Overview](workflow-overview.md) for a complete end-to-end diagram.

---

## Flow Diagrams

### 1. [@ssd-specify Flow](flow-specify.md)

Creates a feature specification from natural language description.

**Key Features**:

- Validates branching standards compliance
- Creates Git branch automatically
- Optional reference context loading
- Stores metadata for downstream prompts

**Output**: `.specify/specs/feature-name/spec.md`

[View Full Diagram →](flow-specify.md)

---

### 2. [@ssd-plan Flow](flow-plan.md)

Generates implementation plan with design artifacts.

**Key Features**:

- Phase-based execution (Research → Design → Tasks)
- Gate checks between phases
- Constitutional standards loading
- Multiple design artifacts generated

**Outputs**:

- `plan.md` - Implementation plan
- `research.md` - Technical decisions
- `data-model.md` - Data structures
- `contracts/` - API specifications
- `quickstart.md` - Test scenarios

[View Full Diagram →](flow-plan.md)

---

### 3. [@ssd-tasks Flow](flow-tasks.md)

Creates dependency-ordered, executable task list.

**Key Features**:

- Context-aware constitutional loading
- Parallel task detection [P]
- TDD approach (tests before code)
- Five-phase task organization

**Task Phases**:

1. Setup - Project initialization
2. Tests [P] - Contract & integration tests
3. Core - Models, services, endpoints
4. Integration - Database, middleware, logging
5. Polish [P] - Unit tests, docs, performance

**Output**: `.specify/specs/feature-name/tasks.md`

[View Full Diagram →](flow-tasks.md)

---

### 4. [@ssd-implement Flow](flow-implement.md)

Executes the implementation following the task plan.

**Key Features**:

- Phase-by-phase execution
- Just-in-time constitutional loading
- Parallel task execution
- Automatic completion tracking

**Constitutional Loading by File Type**:

- Test files → `testing,branching`
- Services → `core,architecture,observability,branching`
- Auth/Security → `core,security,branching`
- Database → `core,architecture,branching`
- API/Routes → `core,architecture,security,branching`
- Config → `operations,security,branching`
- Logging → `observability,branching`

**Output**: All tasks marked [X] complete

[View Full Diagram →](flow-implement.md)

---

### 5. [@audit Flow](flow-audit.md)

Validates implementation quality against specification and constitutional standards.

**Key Features**:

- Two-phase progressive audit
- Requirements coverage validation
- Constitutional compliance checking
- Prioritized issue reporting

**Phase 1 - Critical Compliance**:

- Core standards
- Testing standards
- Security compliance
- Branching compliance

**Phase 2 - Conditional Deep Dive**:

- Architecture (if issues detected)
- Observability (if issues detected)
- Operations (if issues detected)

**Output**: `.specify/specs/feature-name/audit-report.md`

[View Full Diagram →](flow-audit.md)

---

### 6. [@ssd-drift Flow](flow-drift.md)

Detects project-wide drift from constitutional standards.

**Key Features**:

- Full project scanning
- Security drift detection
- Severity-based prioritization
- Actionable remediation plan

**Scan Areas**:

- Security (secrets, vulnerabilities, configs)
- Coding standards (linting, formatting, complexity)
- Architecture (patterns, structure, separation)
- Testing (coverage, organization, types)
- Operations (CI/CD, deployment, monitoring)

**Output**: `.specify/specs/CONSTITUTION_DRIFT.md`

[View Full Diagram →](flow-drift.md)

---

## Complete Workflow

See [Workflow Overview](workflow-overview.md) for:

- End-to-end flow diagram
- Integration between all prompts
- File structure overview
- Command summary
- Time estimates

[View Complete Workflow →](workflow-overview.md)

---

## Quick Start

### Basic Workflow

```bash
# 1. Create specification
@ssd-specify "Add user authentication system"

# 2. Generate implementation plan
@ssd-plan

# 3. Create task list
@ssd-tasks

# 4. Execute implementation
@ssd-implement

# 5. Validate implementation quality
@audit user-authentication
```

### Complete Workflow with Quality Checks

```bash
# Check project health before starting
@ssd-drift

# Create specification
@ssd-specify "Add user authentication system"

# Generate implementation plan
@ssd-plan

# Create task list
@ssd-tasks

# Execute implementation
@ssd-implement

# Validate implementation
@audit user-authentication

# Check if implementation introduced drift
@ssd-drift
```

### With Reference Context

```bash
# 1. Create reference folder with requirements
mkdir -p .specify/reference/auth-patterns
# Add files to reference folder

# 2. Create specification with reference
@ssd-specify "Add user authentication system" -ref auth-patterns

# 3-6. Continue as normal (reference auto-loaded)
@ssd-plan
@ssd-tasks
@ssd-implement
@audit user-authentication
```

---

## Key Concepts

### Modular Constitution System

The SDD toolkit uses a **modular constitution architecture** with template/instance separation:

**Templates** (in `.specify/templates/constitution/`):

- `core-template.md`, `architecture-template.md`, `testing-template.md`, etc.
- Pristine templates with placeholders, never modified
- Copied to memory/ on first `@ssd-init` run

**Working Copies** (in `.specify/memory/constitution/`):

- `core.md`, `architecture.md`, `testing.md`, `security.md`, `observability.md`, `optional.md`
- Project-specific filled-in versions
- Created from templates, removing `-template` suffix
- These are what prompts actually load and use

**Constitution Modules**:

- **core.md** - Technology stack, coding standards, versioning
- **architecture.md** - Service patterns, design principles, API design
- **testing.md** - Test strategy, coverage requirements, TDD practices
- **security.md** - Security policies, authentication, authorization
- **observability.md** - Logging, monitoring, metrics standards
- **optional.md** - Project-specific extensions and custom standards

**Benefits**:

- **Token efficiency**: Load only sections needed for current task (60-80% reduction)
- **Focused updates**: Change one area without affecting others
- **Clear ownership**: Each module has a specific purpose and version
- **Better scalability**: Add new modules without modifying existing ones
- **Selective loading**: Different prompts load only relevant sections
- **Template preservation**: Original templates remain pristine for new projects

**Example Loading**:

- `@ssd-implement` on test file → Loads `testing,branching` from `memory/constitution/`
- `@ssd-implement` on API route → Loads `core,architecture,security,branching` from `memory/constitution/`
- `@ssd-plan` → Loads `core,architecture,testing,branching` from `memory/constitution/`

### Reference Context System

Reference folders provide reusable context that is:

- Loaded **once** during @ssd-specify
- Stored in spec.md metadata
- **Automatically reused** by @ssd-plan and @ssd-tasks
- **Result**: 67% reduction in context loading

### Constitutional Loading Strategies

#### @ssd-specify

- **Loads**: `branching` standards only
- **Purpose**: Validate branch naming

#### @ssd-plan

- **Loads**: `core,architecture,testing,branching`
- **Purpose**: Planning essentials (60% of constitution)

#### @ssd-tasks

- **Loads**: Based on task types being generated
- **Options**:
  - Testing tasks → `testing,branching`
  - API tasks → `core,architecture,security,branching`
  - Infrastructure → `core,operations,security,branching`
  - Mixed → `core,testing,architecture,branching`

#### @ssd-implement

- **Loads**: Just-in-time based on file type
- **Purpose**: Load only standards needed for current task
- **Re-loads**: When switching to different file types

### Parallel Execution

Tasks marked with **[P]** can run in parallel:

**Parallel** (different files):

```markdown
- [ ] T003 [P] Create contract test for /api/users
- [ ] T004 [P] Create contract test for /api/posts
- [ ] T005 [P] Create contract test for /api/comments
```

**Sequential** (same file or dependencies):

```markdown
- [ ] T006 Create User model
- [ ] T007 Create UserService (depends on User model)
- [ ] T008 Create UserController (depends on UserService)
```

### Test-Driven Development (TDD)

The workflow enforces TDD by generating tests before implementation:

1. **@ssd-plan** → Generates contract test specifications
2. **@ssd-tasks** → Orders tests before core implementation
3. **@ssd-implement** → Executes Tests phase before Core phase

**Order**:

```
Setup → Tests [P] → Core → Integration → Polish [P]
```

---

## File Structure

```
.specify/
├── memory/
│   ├── constitution/                # Project-specific constitution files
│   │   ├── core.md                 # Technology stack, coding standards
│   │   ├── architecture.md         # Service patterns, design principles
│   │   ├── testing.md              # Test strategy, coverage requirements
│   │   ├── security.md             # Security policies
│   │   ├── observability.md        # Logging, monitoring standards
│   │   └── optional.md             # Project-specific extensions
│   └── git-workflow.md              # Branch rules
├── reference/                        # Optional context
│   └── <folder-name>/
│       ├── README.md                # Requirements
│       ├── examples/                # Code examples
│       └── patterns/                # Design patterns
├── specs/                           # Feature workspaces
│   └── <feature-name>/
│       ├── spec.md                  # ← @ssd-specify
│       ├── plan.md                  # ← @ssd-plan
│       ├── research.md              # ← @ssd-plan
│       ├── data-model.md            # ← @ssd-plan
│       ├── contracts/               # ← @ssd-plan
│       │   ├── users.md
│       │   └── posts.md
│       ├── quickstart.md            # ← @ssd-plan
│       └── tasks.md                 # ← @ssd-tasks
└── templates/
    ├── constitution/                # Pristine templates (never modified)
    │   ├── core-template.md        # Technology stack template
    │   ├── architecture-template.md # Service patterns template
    │   ├── testing-template.md     # Test strategy template
    │   ├── security-template.md    # Security policies template
    │   ├── observability-template.md # Logging standards template
    │   └── optional-template.md    # Project-specific template
    ├── spec-template.md
    ├── plan-template.md
    ├── tasks-template.md
    └── includes/
        └── validation-common.md
```

---

## Benefits

### Efficiency

- **Reference context**: Load once, use 3x (67% reduction)
- **Constitutional loading**: Context-aware, just-in-time
- **Parallel execution**: Maximize throughput on independent tasks
- **Auto-detection**: Single feature auto-selects (no typing)

### Quality

- **Branching standards**: Enforced validation
- **Constitutional compliance**: Standards applied per file type
- **TDD approach**: Tests before implementation
- **Gate checks**: Quality gates between phases

### Consistency

- **Templates**: Standardized structure across features
- **Standards**: Constitutional requirements applied uniformly
- **Documentation**: All artifacts generated automatically
- **Traceability**: Spec → Plan → Tasks → Implementation

---

## Troubleshooting

### Multiple specs found

```bash
ERROR: Multiple specs found. Please specify which feature...
Available features: user-auth, payment-system, api-v2

# Solution: Specify feature name
@ssd-plan user-auth
```

### Branching standards violation

```bash
ERROR: Branch name violates branching standards constraints.
Violations found:
- Contains uppercase letters (must be lowercase only)

# Solution: Use compliant branch name
@ssd-specify "add-user-authentication"  # lowercase with hyphens
```

### Missing prerequisites

```bash
ERROR: No specs found. Run @ssd-specify first.

# Solution: Create specification first
@ssd-specify "Your feature description"
```

---

## Advanced Usage

### Custom Reference Folders

Create domain-specific reference folders for common patterns:

```bash
# Authentication patterns
.specify/reference/auth-patterns/
├── README.md           # JWT, OAuth, session management
├── examples/
│   ├── jwt-auth.ts
│   └── session-manager.ts
└── security.md         # Security requirements

# Payment processing
.specify/reference/payment-patterns/
├── README.md           # Stripe, PayPal integration
├── examples/
│   └── payment-service.ts
└── compliance.md       # PCI compliance requirements

# API design
.specify/reference/api-patterns/
├── README.md           # REST best practices
├── examples/
│   └── pagination.ts
└── versioning.md       # API versioning strategy
```

### Feature-Specific Constitution Loading

For specialized features, load additional sections:

```bash
# Security-focused feature
@ssd-plan  # Loads: core,architecture,testing,security,branching

# Performance-critical feature
@ssd-plan  # Loads: core,architecture,testing,observability,branching

# Infrastructure feature
@ssd-plan  # Loads: core,architecture,operations,security,branching
```

---

## Related Documentation

- [Installation Guide](../INSTALL.md)
- [Prompt Usage Guide](../PROMPTS_HOWTO.md)
- [Prompt Summary](../PROMPTS_SUMMARY.md)
- [README](../README.md)

---

## Visual Legend

### Mermaid Diagram Colors

- 🔵 **Light Blue** (`#e1f5ff`) - Start nodes
- 🟢 **Green** (`#d4edda`) - Success/completion nodes
- 🔴 **Red** (`#f8d7da`) - Error nodes
- 🟡 **Yellow** (`#fff3cd`) - Decision points

### Task Markers

- `[ ]` - Task not started
- `[X]` - Task completed
- `[P]` - Task can run in parallel

### File Paths

All file paths use absolute paths from repository root:

```
/Users/username/project/.specify/specs/feature-name/spec.md
```

---

**Last Updated**: October 12, 2025  
**Version**: 0.2.0
