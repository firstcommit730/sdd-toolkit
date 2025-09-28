# Amazon Q Prompts Port Summary

## Successfully Ported Prompts

The following GitHub prompts have been successfully ported to Amazon Q format:

### 1. Constitution Prompt (`@constitution`)
- **Location**: `~/.aws/amazonq/prompts/constitution.md`
- **Purpose**: Create or update project constitution from interactive inputs
- **Key Features**: 
  - Template placeholder replacement
  - Semantic versioning for constitution updates
  - Dependency propagation across templates
  - Sync impact reporting

### 2. Specify Prompt (`@specify`)
- **Location**: `~/.aws/amazonq/prompts/specify.md`
- **Purpose**: Create feature specifications from natural language descriptions
- **Key Features**:
  - Automatic branch creation (feature-name format)
  - Template-based specification generation
  - Integration with `.specify/scripts/bash/create-new-feature.sh`

### 3. Plan Prompt (`@plan`)
- **Location**: `~/.aws/amazonq/prompts/plan.md`
- **Purpose**: Execute implementation planning workflow
- **Key Features**:
  - Multi-phase artifact generation (research.md, data-model.md, contracts/, quickstart.md, tasks.md)
  - Constitutional requirement integration
  - Absolute path handling for file operations

### 4. Tasks Prompt (`@tasks`)
- **Location**: `~/.aws/amazonq/prompts/tasks.md`
- **Purpose**: Generate dependency-ordered task lists for implementation
- **Key Features**:
  - Parallel task identification with [P] markers
  - TDD-based task ordering
  - File-based coordination rules
  - Phase-based execution (Setup → Tests → Core → Integration → Polish)

### 5. Implement Prompt (`@implement`)
- **Location**: `~/.aws/amazonq/prompts/implement.md`
- **Purpose**: Execute implementation plan by processing tasks.md
- **Key Features**:
  - Phase-by-phase execution
  - Dependency respect (sequential vs parallel)
  - Progress tracking with task completion marking
  - Error handling and validation checkpoints

## Key Adaptations for Amazon Q

1. **Removed GitHub-specific syntax**: Eliminated `$ARGUMENTS` placeholder and GitHub Actions formatting
2. **Simplified user input handling**: Direct user input processing instead of command argument parsing
3. **Maintained script integration**: All bash script calls preserved for compatibility
4. **Preserved workflow logic**: Complete execution flows maintained from original prompts
5. **Added Amazon Q context**: Prompts work within Amazon Q's file operation capabilities

## Usage Instructions

To use these prompts in Amazon Q:

1. Type `@constitution` to update project constitution
2. Type `@specify <feature_description>` to create new feature specifications
3. Type `@plan` to generate implementation plans from specifications
4. Type `@tasks` to create task breakdowns from design artifacts
5. Type `@implement` to execute the implementation plan

## Verification Status

✅ All prompts created successfully in `~/.aws/amazonq/prompts/`
✅ Script dependencies verified (check-prerequisites.sh, create-new-feature.sh, etc.)
✅ JSON parsing compatibility confirmed
✅ File path handling adapted for absolute paths
✅ Workflow integration maintained

## Dependencies

The prompts rely on the existing `.specify/` directory structure:
- `.specify/scripts/bash/` - Shell scripts for automation
- `.specify/templates/` - Template files for specifications and plans
- `.specify/memory/constitution.md` - Project constitution template

All dependencies are present and functional in the current project structure.