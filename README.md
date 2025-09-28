# LLM SDD Toolkit

Vendor-neutral Specification Driven Development (SDD) workflow toolkit for collaborating with multiple AI coding assistants (currently Amazon Q Developer & GitHub Copilot) using consistent prompts and a spec→plan→tasks→implement loop.

## About

Specification Driven Development (SDD) is a methodology that shifts AI-assisted work upstream: you first create an explicit specification, then derive design artifacts, from which reproducible task lists are generated, and only then execute implementation. This toolkit packages that flow into portable markdown prompts and helper scripts for multiple Large Language Model (LLM) developer assistants.

## Key Features

Consistent, auditable, specification-first workflow across different AI assistants:

- Multi-vendor prompt distribution (Amazon Q + GitHub Copilot) with identical semantics
- Unified command-style verbs (`@specify`, `@plan`, `@tasks`, `@implement`, etc.)
- Reference folder mechanism (`@specify-reference`) to inject structured domain context across the entire workflow
- Slightly reworded title & docs to emphasize portability and neutrality
- Installation instructions show parallel vendor setup instead of single-platform GitHub Actions usage
- Keeps attribution, intent, and constitutional methodology from the original project

If you maintain or use another AI assistant, add support by placing these markdown prompt files into that tool's custom prompt directory or ingestion mechanism.

## Upstream Attribution

Inspired by and originally derived from the excellent upstream project: [github/spec-kit](https://github.com/github/spec-kit). This toolkit reworks distribution, naming, and multi-vendor support while retaining the spirit of the original specification-first workflow.

## Quick Start

1. **Install prompts:**

   ```bash
   # For Amazon Q
   mkdir -p ~/.aws/amazonq/prompts && cp prompts/*.md ~/.aws/amazonq/prompts/

   # For GitHub Copilot
   mkdir -p .github/prompts && for file in prompts/*.md; do cp "$file" .github/prompts/"$(basename "$file" .md).prompt.md"; done
   ```

2. **Start developing:**
   ```
   @specify Add user authentication system
   @plan
   @tasks
   @implement
   ```

## Workflow Diagrams

### Standard Workflow

```
┌─────────────┐    ┌──────────────┐    ┌─────────────┐    ┌─────────────┐
│   @specify  │───▶│    @plan     │───▶│   @tasks    │───▶│ @implement  │
│             │    │              │    │             │    │             │
│ Creates     │    │ Generates    │    │ Creates     │    │ Executes    │
│ spec.md     │    │ design docs  │    │ tasks.md    │    │ code        │
└─────────────┘    └──────────────┘    └─────────────┘    └─────────────┘
```

### Enhanced Workflow with Reference Folders

```
┌───────────────────┐    ┌─────────────┐    ┌──────────────┐    ┌─────────────┐    ┌─────────────┐
│ @specify-reference│───▶│   @specify  │───▶│    @plan     │───▶│   @tasks    │───▶│ @implement  │
│                   │    │             │    │              │    │             │    │             │
│ Creates template  │    │ Uses folder │    │ Integrates   │    │ Includes    │    │ Executes    │
│ in reference/     │    │ context +   │    │ reference    │    │ reference   │    │ code        │
│                   │    │ creates     │    │ entities &   │    │ edge cases  │    │             │
│                   │    │ spec.md     │    │ requirements │    │ & scenarios │    │             │
└───────────────────┘    └─────────────┘    └──────────────┘    └─────────────┘    └─────────────┘
                               ▲                   ▲                   ▲
                               │                   │                   │
                         ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
                         │ Reference   │    │ Reference   │    │ Reference   │
                         │ Folder      │    │ Folder      │    │ Folder      │
                         │ Context     │    │ Context     │    │ Context     │
                         └─────────────┘    └─────────────┘    └─────────────┘
```

## Example Commands

**Standard Workflow:**

```bash
@specify Add JWT-based user authentication with login/logout
@plan
@tasks
@implement
```

**Enhanced with Reference Folder:**

```bash
# 1. Create reference folder with requirements template
@specify-reference user-authentication

# 2. Edit .specify/reference/user-authentication/README.md with:
#    - Primary User Story
#    - Acceptance Scenarios
#    - Edge Cases
#    - Functional Requirements
#    - Key Entities

# 3. Create specification (automatically loads reference folder)
@specify Add user authentication ***using user-authentication***

# 4. Generate plan (integrates reference folder entities & requirements)
@plan

# 5. Create tasks (includes reference folder edge cases & scenarios)
@tasks

# 6. Execute implementation
@implement
```

This generates design documents, creates a task list, and implements the feature following your project's constitutional principles. Reference folders in `.specify/reference/` can provide additional context for the entire workflow.

## Reference Folders

Create structured requirement folders in `.specify/reference/[folder-name]/` to enhance your entire workflow:

- **Specifications** - Predefined user stories, acceptance criteria, edge cases
- **Planning** - Technical constraints, functional requirements inform design decisions
- **Tasks** - Additional test scenarios and implementation requirements

Reference folders are automatically integrated when mentioned in your `@specify` command. Each folder contains a README.md with structured requirements and can include additional supporting files.

## Available Prompts

- `@audit` - Generate compliance audit and TODO list
- `@constitution` - Update project constitution with versioning
- `@specify-reference` - Create reference folder with requirements template
- `@specify` - Create feature specifications from descriptions (optionally using reference folders)
- `@plan` - Generate implementation plans and design artifacts
- `@tasks` - Create dependency-ordered task breakdowns
- `@implement` - Execute implementation following task plan

## Documentation

- [Installation Guide](./INSTALL.md)
- [Usage Guide](./AMAZONQ_PROMPTS_HOWTO.md)
- [Prompt Summary](./AMAZONQ_PROMPTS_SUMMARY.md)

## Credits

This work is based on the original [Spec-Kit](https://github.com/github/spec-kit) by GitHub. All credit for the methodology and workflow design goes to the original authors.

## License

Same as original Spec-Kit project.
