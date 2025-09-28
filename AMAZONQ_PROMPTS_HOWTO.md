# Amazon Q Prompts - How To Guide

## Quick Start

1. Ensure you're in the project directory with `.specify/` folder
2. Type `@<prompt_name>` in Amazon Q chat
3. Follow the workflow sequence: specify → plan → tasks → implement

## Workflow Sequence

### 1. Create Feature Specification
```
@specify Add user authentication with JWT tokens
```
**What it does:**
- Creates new feature branch (e.g., `add-user-authentication`)
- Generates `specs/add-user-authentication/spec.md`
- Uses template structure for requirements

### 2. Generate Implementation Plan
```
@plan
```
**What it does:**
- Reads the feature specification
- Creates technical design artifacts:
  - `research.md` - Technical decisions
  - `data-model.md` - Entities and relationships
  - `contracts/` - API specifications
  - `quickstart.md` - Integration scenarios

### 3. Create Task Breakdown
```
@tasks
```
**What it does:**
- Analyzes design artifacts
- Generates `tasks.md` with numbered tasks (T001, T002, etc.)
- Orders by dependencies (Setup → Tests → Core → Integration → Polish)
- Marks parallel tasks with [P]

### 4. Execute Implementation
```
@implement
```
**What it does:**
- Processes tasks in dependency order
- Executes phase-by-phase
- Marks completed tasks as [X]
- Reports progress and errors

## Individual Prompt Usage

### Constitution Management
```
@constitution
@constitution Update principle 2 to require security reviews
@constitution Add new principle about API versioning
```

### Project Audit
```
@audit
```

### Feature Specification
```
@specify User profile management system
@specify Real-time chat functionality with WebSocket
@specify Add user authentication using auth-requirements.md
```

**Reference Files**: Place detailed requirements in `.specify/reference/[filename].md` to enhance specifications with predefined user stories, acceptance criteria, and functional requirements.

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

## Common Patterns

**Full Feature Workflow:**
```
@specify Payment processing integration
@plan
@tasks
@implement
```

**Constitution Updates:**
```
@constitution Add principle about code coverage requirements
```

**Project Compliance:**
```
@audit  # Generate TODO list for constitutional compliance
```

**Iterative Development:**
```
@tasks  # Regenerate tasks after design changes
@implement  # Continue from where you left off
```

## Prerequisites

- Project must have `.specify/` directory structure
- Must be on a feature branch (feature-name format, no number prefixes) for most operations
- Constitution template must exist at `.specify/memory/constitution.md`

## Troubleshooting

**"Not on feature branch" error:**
- Run `@specify <description>` first to create feature branch

**"Feature directory not found" error:**
- Ensure you've run `@specify` to initialize the feature structure

**Script execution errors:**
- Verify `.specify/scripts/bash/` files have execute permissions
- Check that you're in the project root directory