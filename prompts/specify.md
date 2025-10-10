# Specify

Create or update the feature specification from a natural language feature description.

## Usage

- `@specify <feature_description>` - Create a new feature specification
- `@specify <feature_description> -ref <reference_folder>` - Create specification with additional context from a reference folder

---

## Create Feature Specification

The user will provide a feature description and optionally a reference folder for additional context.

### Validation Requirements

**CRITICAL**: All feature descriptions MUST comply with branching standards. If the branching standards file is missing or the branch name doesn't comply, immediately stop and return an error.

### Steps

0. **Load and Validate Branching Standards**: Before proceeding with branch creation, you MUST:

   **Step 0.1 - Check Branching Standards Existence**:

   - Check if `.specify/memory/branching-standards.md` exists
   - If it doesn't exist, respond with:

     ```
     FATAL ERROR: Branching standards file not found.

     Required file: .specify/memory/branching-standards.md

     The branching standards must exist before creating new specifications.
     Please initialize the constitution (which includes branching standards) from the template first.
     ```

     STOP all processing and do not continue.

   **Step 0.2 - Parse Branching Rules**:

   - Read `.specify/memory/branching-standards.md`
   - Extract the YAML block containing branching rules
   - Parse the following (DO NOT hardcode these values):
     - `allowed_type_prefixes` array
     - `constraints.must` array
     - `constraints.must_not` array
     - `length_constraints.minimum` and `maximum`
     - `pattern` (expected: `type/short-description`)
   - Store these rules for validation

   **Step 0.3 - Validate User Input Against Branching Rules**:

   - Check if feature description starts with a valid type prefix from `allowed_type_prefixes`
   - If NO valid prefix found, respond with:

     ```
     ERROR: Invalid branch type prefix.

     Branching Standards Reference: .specify/memory/branching-standards.md

     Required format: type/short-description
     Valid type prefixes from branching standards: [list from branching standards]

     Your input: [user's description]

     Examples of valid format:
     - feat/add-user-authentication
     - fix/resolve-payment-timeout
     - docs/update-api-documentation

     Please provide your feature description with a valid type prefix per the branching standards.
     ```

     STOP all processing and do not continue.

   **Step 0.4 - Validate Against All Branching Constraints**:

   - Validate branch name against ALL `constraints.must` rules from branching standards
   - Validate branch name against ALL `constraints.must_not` rules from branching standards
   - Check length is between `minimum` and `maximum` from branching standards
   - If ANY constraint is violated, respond with:

     ```
     ERROR: Branch name violates branching standards constraints.

     Branching Standards Reference: .specify/memory/branching-standards.md

     Violations found:
     [List each violated constraint with the specific rule from branching standards]

     Your proposed branch: [branch name]

     Please revise to comply with all branching standards requirements.
     ```

     STOP all processing and do not continue.

     STOP all processing and do not continue.

0.5. **Create a branch name**: After successfully validating against all branching rules, create a concise, descriptive name suitable for a git branch that captures the essence of the feature. This name MUST comply with ALL rules from `.specify/memory/branching-standards.md`. The script will automatically process this into a valid git branch name.

**Branching Standards Compliance Requirements**:

- Use valid type prefix from branching standards' `allowed_type_prefixes`
- Follow pattern specified in branching standards (typically `type/short-description`)
- Respect length constraints from branching standards (`minimum` to `maximum` characters)
- Comply with all `constraints.must` rules from branching standards
- Avoid all `constraints.must_not` violations from branching standards
- Use lowercase letters, numbers, hyphens, and forward slashes only (per branching standards)

**Reference**: All rules sourced from `.specify/memory/branching-standards.md`

1. Run the script `.specify/scripts/bash/create-new-feature.sh --json "<branch_description_with_prefix>"` from repo root and parse its JSON output for BRANCH_NAME and SPEC_FILE. All file paths must be absolute.
   **IMPORTANT** You must only ever run this script once. The JSON is provided in the terminal as output - always refer to it to get the actual content you're looking for.

   **Branch Name Generation**: The script automatically generates a git branch name from your description by:

   - Converting the description to lowercase
   - Replacing all non-alphanumeric characters with hyphens
   - Removing consecutive hyphens
   - Trimming leading and trailing hyphens
   - Truncating to the maximum length specified in constitution (typically 50 characters)
   - Example: "High-Value Field Redaction & Structured Context" → "high-value-field-redaction-structured-context"

   **Post-Script Validation**: After the script runs:

   - Verify the generated BRANCH_NAME still complies with branching standards rules
   - If the script's output violates any branching standards constraint, report the violation and halt
   - Reference: `.specify/memory/branching-standards.md`

1.5. **Load Reference Folder (if provided)**: If the user specified a reference folder with `-ref <folder_name>`, check for `.specify/reference/<folder_name>/` and load all files in the folder for additional context about:

- Primary User Story details (from README.md)
- Acceptance Scenarios examples
- Edge Cases to consider
- Functional Requirements templates
- Key Entities definitions
- Any additional supporting files in the folder

**Important**: If a reference folder is used, add a metadata section at the top of the spec file:

```yaml
---
reference: <folder_name>
---
```

This allows @plan and @tasks to automatically source the reference context without needing to pass `-ref` explicitly.

2. **Load Constitutional Standards**: Execute `.specify/scripts/bash/load-constitution.sh` with an appropriate preset based on the project type to load relevant constitutional standards:

   **Available Presets**:

   - `backend` - Loads: core, testing, security, observability, architecture, branching
   - `frontend` - Loads: core, testing, architecture, optional, branching
   - `infra` - Loads: core, operations, security, observability, branching
   - `core` - Loads: core, branching (minimal set)
   - `full` - Loads all sections (use sparingly due to token usage)

   **Custom Section Loading**: You can also load specific sections by name:

   ```bash
   .specify/scripts/bash/load-constitution.sh "core,testing,security"
   ```

   **Default**: Use `backend` preset unless the feature clearly indicates a different project type.

   **Purpose**: The loaded constitutional standards will guide the specification to ensure:

   - Technology stack compliance (Section 2: Immutable Technology Stack)
   - Architectural pattern adherence (Section 3: Architectural Principles)
   - Coding standards alignment (Section 4: Coding Standards)
   - Testing requirements (Section 6: Testing Rules)
   - Security requirements (Section 13: Security & Privacy)
   - Branching workflow compliance (from branching-standards.md)

3. Load `.specify/templates/spec-template.md` to understand required sections.

4. Write the specification to SPEC_FILE using the template structure, replacing placeholders with concrete details derived from the feature description, constitutional standards, and reference folder (if provided) while preserving section order and headings. If a reference folder was used, ensure the YAML frontmatter is at the very top of the file.

   **Constitutional Compliance**: Ensure the specification reflects:

   - Mandated technologies from loaded constitution
   - Required architectural patterns
   - Testing strategies and coverage requirements
   - Security and validation requirements
   - Logging and observability standards

5. Report completion with branch name, spec file path, reference folder used (if any), constitutional preset loaded, and readiness for the next phase.

Note: The script creates the feature directory and initializes the spec file.

---

## Creating Reference Folders

Reference folders provide reusable context that enhances @specify, @plan, and @tasks workflows.

### How to Create a Reference Folder

1. **Create folder name**: Create a concise, descriptive folder name in kebab-case format that represents the domain or feature area.

2. **Check if folder exists**: First check if `.specify/reference/<folder_name>/` already exists

3. **Create folder structure**: If it doesn't exist, create the folder `.specify/reference/<folder_name>/`

4. **Create README.md**: Create a `README.md` file in the new folder using the template below

5. **Confirm creation**: Let the user know the reference folder has been created and they can now edit it

### Template for README.md

```markdown
# [Feature Name] Requirements

## Primary User Story

As a [user type], I want [goal] so that [benefit].

## Acceptance Criteria

- [ ] Must have: [critical requirement]
- [ ] Should have: [important requirement]
- [ ] Could have: [nice-to-have requirement]

## User Scenarios

### Happy Path

1. User does X
2. System responds with Y
3. User sees Z

### Edge Cases

- What happens when [edge case 1]
- How to handle [edge case 2]
- Behavior for [edge case 3]

## Functional Requirements

### Core Features

- Feature 1: [description]
- Feature 2: [description]

### Business Rules

- Rule 1: [constraint/validation]
- Rule 2: [business logic]

## Key Entities

### Data Models

- **Entity1**: fields, relationships, constraints
- **Entity2**: fields, relationships, constraints

### APIs/Interfaces

- Endpoint patterns
- Expected inputs/outputs
- Error handling

## Technical Constraints

- Performance: [requirements]
- Security: [requirements]
- Compatibility: [requirements]

## Success Metrics

- How to measure success
- Key performance indicators
- User experience goals
```

### Using Reference Folders

After creating a reference folder:

1. Edit the README.md with specific requirements for that domain/feature area
2. Add additional files to the folder as needed
3. Use the folder when creating specifications:
   - `@specify <feature_description> -ref <folder_name>` - Creates spec with reference context
   - The reference folder name is stored in the spec's YAML frontmatter
   - `@plan` and `@tasks` automatically source the reference from the spec file
   - No need to pass `-ref` to @plan or @tasks - they read it from the spec

### Important Notes

- Only create the folder if it doesn't already exist
- The folder name should be descriptive and kebab-case (e.g., `user-authentication`, `payment-system`)
- The README.md serves as the primary reference document but additional files can be added
- Reference folders provide consistent context: define once in @specify, automatically used by @plan and @tasks
