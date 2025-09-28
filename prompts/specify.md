Create or update the feature specification from a natural language feature description.

The user will provide a feature description. Use this description to create a comprehensive specification.

1. Run the script `.specify/scripts/bash/create-new-feature.sh --json "<feature_description>"` from repo root and parse its JSON output for BRANCH_NAME and SPEC_FILE. All file paths must be absolute.
   **IMPORTANT** You must only ever run this script once. The JSON is provided in the terminal as output - always refer to it to get the actual content you're looking for.
   **NOTE** Branch names no longer include number prefixes - they are created as feature-name format.

1.5. **Optional Reference Folder**: If user mentions a reference folder (e.g., "using user-authentication"), check for `.specify/reference/[folder-name]/` and load all files in the folder for additional context about:
   - Primary User Story details (from README.md)
   - Acceptance Scenarios examples
   - Edge Cases to consider
   - Functional Requirements templates
   - Key Entities definitions
   - Any additional supporting files in the folder

2. Load `.specify/templates/spec-template.md` to understand required sections.

3. Write the specification to SPEC_FILE using the template structure, replacing placeholders with concrete details derived from the feature description while preserving section order and headings.

4. Report completion with branch name, spec file path, and readiness for the next phase.

Note: The script creates the feature directory and initializes the spec file.