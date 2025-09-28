# Specify Reference

You are tasked with creating a reference folder for detailed requirements that will enhance the @specify, @plan, and @tasks workflow.

## Instructions

1. **Check if folder exists**: First check if `.specify/reference/[FOLDER_NAME]/` already exists
2. **Create folder structure**: If it doesn't exist, create the folder `.specify/reference/[FOLDER_NAME]/`
3. **Copy template**: Create a `README.md` file in the new folder using the template below
4. **Confirm creation**: Let the user know the reference folder has been created and they can now edit the README.md

## Template for README.md

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

## Usage
After creating the reference folder, users can:
1. Edit the README.md with their specific requirements
2. Add additional files to the folder as needed
3. Reference the folder in @specify commands: `@specify Add feature ***using folder-name***`

## Important Notes
- Only create the folder if it doesn't already exist
- The folder name should be descriptive and kebab-case (e.g., `user-authentication`, `payment-system`)
- The README.md serves as the primary reference document but additional files can be added to the folder