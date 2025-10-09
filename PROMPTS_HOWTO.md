# Amazon Q Prompts - How To Guide

## Quick Start

1. Ensure you're in the project directory with `.specify/` folder
2. Type `@<prompt_name>` in Amazon Q chat
3. Follow the workflow sequence: specify → plan → tasks → implement

## Workflow Sequence

### 1. Create or Update Constitution (Optional, one-time)

```
@constitution
```

**What it does:**

- Creates or updates `.specify/memory/constitution.md`
- Defines project principles and governance
- Uses semantic versioning (MAJOR.MINOR.PATCH)
- Validates consistency across templates

### 2. Create Feature Specification

```
@specify Add user authentication with JWT tokens
```

**What it does:**

- Creates new feature branch (e.g., `add-user-authentication`)
- Generates `specs/add-user-authentication/spec.md`
- Uses template structure for requirements

**With Reference Context (Recommended)**:

```
@specify Add user authentication with JWT -ref auth-requirements
```

- Loads files from `.specify/reference/auth-requirements/`
- Extracts architecture, patterns, code examples, testing approaches
- **Stores summary in spec.md's Reference Context section**
- Used by @plan and @tasks without re-loading (faster!)

### 3. Generate Implementation Plan

```
@plan
```

**What it does:**

- Reads the feature specification
- **Uses Reference Context from spec.md** (no file re-loading)
- Creates technical design artifacts:
  - `research.md` - Technical decisions
  - `data-model.md` - Entities and relationships
  - `contracts/` - API specifications
  - `quickstart.md` - Integration scenarios

### 4. Create Task Breakdown

```
@tasks
```

**What it does:**

- Analyzes design artifacts
- **Applies Reference Context patterns** from spec.md
- Generates `tasks.md` with numbered tasks (T001, T002, etc.)
- Orders by dependencies (Setup → Tests → Core → Integration → Polish)
- Marks parallel tasks with [P]

### 5. Execute Implementation

```
@implement
```

**What it does:**

- Processes tasks in dependency order
- Executes phase-by-phase
- Marks completed tasks as [X]
- Reports progress and errors

### 6. Validate Implementation Quality

```
@audit <feature-name>
@audit user-authentication
```

**What it does:**

- Validates a single feature implementation against its specification
- Accepts feature name parameter: `@audit <feature-name>`
- Auto-selects if only one spec exists in project
- Checks requirements coverage and acceptance criteria
- Audits code quality, testing, error handling, security
- Calculates compliance metrics (requirements %, task %, test coverage)
- Identifies issues by severity (Critical/High/Medium/Low)
- Generates quality scores and production readiness assessment
- Creates feature-specific `AUDIT.md` in `.specify/specs/<feature>/`
- Overwrites existing audit if present for fresh validation

### 7. Detect Constitutional Drift (Optional)

```
@drift
```

**What it does:**

- Detects drift between project state and constitutional requirements
- Identifies security vulnerabilities and coding standard violations
- Calculates drift score and prioritizes items (Critical/High/Medium/Low)
- Creates `.specify/specs/CONSTITUTION_DRIFT.md` with realignment tasks
- Overwrites existing report if present for fresh analysis

## Individual Prompt Usage

### Constitution Management

```
@constitution
@constitution Update principle 2 to require security reviews
@constitution Add new principle about API versioning
```

### Constitutional Drift Detection

```
@drift
```

### Feature Specification

```
@specify User profile management system
@specify Real-time chat functionality with WebSocket
@specify Add payment processing -ref payment-domain
```

**With Reference Context** (Recommended for complex domains):

```
# 1. Create reference folder (one-time setup)
mkdir -p .specify/reference/payment-domain
# Edit README.md with domain requirements

# 2. Use in specification (loads ONCE, reuses 3×)
@specify Add payment processing -ref payment-domain
```

**Benefits of Reference Context**:

- Files loaded once during @specify
- Summary stored in spec.md
- @plan and @tasks reuse the summary (no re-loading)
- 50-70% faster execution
- Consistent context across all stages

### Planning

```
@plan
@plan Include microservices architecture considerations
```

### Task Generation

```
@tasks
@tasks Focus on API endpoints and database models
```

### Implementation

```
@implement
@implement Start with setup and test tasks only
```

### Implementation Audit

```
@audit <feature-name>
@audit user-authentication
@audit payment-system  # Audit specific feature after fixes
```

## Common Patterns

**Full Feature Workflow:**

```
@specify Payment processing integration
@plan
@tasks
@implement
@audit payment-processing  # Audit the payment-processing feature
```

**With Reference Context (Optimized):**

```
@specify Payment processing integration -ref payment-domain
@plan  # Uses Reference Context from spec.md
@tasks # Uses Reference Context from spec.md
@implement
@audit payment-processing  # Validates implementation against spec
```

**Working with Multiple Features:**

```
# If you have multiple specs and forget the feature name
@audit
# Output: Lists all available features

# Audit specific feature
@audit user-authentication
```

**Constitution Management:**

```
@constitution  # Create or update
@constitution Add principle about code coverage requirements
```

**Constitutional Drift Detection:**

```
@drift  # Detect drift and generate realignment TODO list
```

**Iterative Development:**

```
@tasks  # Regenerate tasks after design changes
@implement  # Continue from where you left off
```

## Reference Context System

### Why Use Reference Context?

Reference folders provide reusable domain knowledge that enhances specifications, plans, and tasks:

- **Load Once, Reuse 3×**: Files loaded during @specify, summary used by @plan and @tasks
- **Performance**: 67% reduction in file loads, 50-70% faster execution
- **Consistency**: Single source of truth stored in spec.md
- **Transparency**: All insights documented and reviewable

### Creating Reference Folders

```bash
# Create folder structure
mkdir -p .specify/reference/your-domain

# Create README.md with structured requirements
cat > .specify/reference/your-domain/README.md << 'EOF'
# Your Domain Requirements

## Primary User Story
As a [user type], I want [goal] so that [benefit].

## Acceptance Criteria
- [ ] Must have: [critical requirement]
- [ ] Should have: [important requirement]

## Key Entities
- **Entity1**: fields, relationships, constraints
- **Entity2**: fields, relationships, constraints

## API Patterns
- Endpoint: [pattern]
- Authentication: [approach]
- Error handling: [strategy]

## Testing Approaches
- Unit tests: [coverage requirements]
- Integration tests: [scenarios]
- E2E tests: [critical paths]
EOF

# Use in workflow
@specify Your feature description -ref your-domain
```

### Reference Context Structure in spec.md

When you use `-ref <folder>`, the spec.md will include:

```markdown
## Reference Context

**Reference Folder**: your-domain
**Purpose**: Context from existing implementation for consistency

### Key Insights from Reference Material

#### Architecture & Patterns

[Architectural decisions, design patterns, conventions]

#### Code Examples & Interfaces

[API signatures, interfaces, code patterns to follow]

#### Configuration & Setup

[Configuration patterns, environment setup, dependencies]

#### Testing Approaches

[Testing patterns, fixtures, utilities available]

### Referenced Files

[List of files that were analyzed]
```

This section is then used by @plan and @tasks without re-loading the files.

## Prerequisites

- Project must have `.specify/` directory structure
- Must be on a feature branch (feature-name format, no number prefixes) for most operations
- Constitution template should exist at `.specify/memory/constitution.md` (create with @constitution)
- Reference folders (optional) in `.specify/reference/<folder-name>/` for enhanced context

## Troubleshooting

**"Constitution not found" error (when using @drift):**

- Run `@constitution` first to create the project constitution

**"Not on feature branch" error:**

- Run `@specify <description>` first to create feature branch

**"Feature directory not found" error:**

- Ensure you've run `@specify` to initialize the feature structure

**Script execution errors:**

- Verify `.specify/scripts/bash/` files have execute permissions
- Check that you're in the project root directory

**Reference folder not being used:**

- Ensure folder exists at `.specify/reference/<folder-name>/`
- Check that you used `-ref <folder-name>` flag with @specify
- Verify README.md exists in the reference folder

**Slow performance:**

- Use `-ref <folder>` to enable Reference Context optimization
- Check that @plan and @tasks are reading from spec.md, not re-loading files

**"Specification not found" or "Multiple specs found" error (when using @audit):**

- If no spec exists: Run `@specify` first to create the feature specification
- If multiple specs exist: Provide feature name: `@audit <feature-name>`
- Use `@audit` without parameters to see list of available features
- Ensure spec.md, plan.md, and tasks.md exist in feature directory

**Missing AUDIT.md after @audit:**

- Check that @implement has been run first
- Verify feature directory structure exists
- Look for AUDIT.md in `.specify/specs/<feature>/`

**Audit shows "implementation missing" for completed tasks:**

- Ensure tasks are marked [X] in tasks.md
- Verify implementation files match plan.md structure
- Check that code implements requirements from spec.md
