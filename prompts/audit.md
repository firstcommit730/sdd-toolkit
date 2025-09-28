Audit the current project against the constitution and create a TODO list for compliance.

1. Check if `.specify/memory/constitution.md` exists. If not, throw an error:
   "ERROR: Constitution not found at .specify/memory/constitution.md. Run @constitution first to create the project constitution."

2. Read the constitution at `.specify/memory/constitution.md` to understand all principles and requirements.

3. Scan the current project structure and files to evaluate compliance:
   - Read README.md, package.json, or similar project files
   - Check for required documentation (API docs, setup guides, etc.)
   - Examine code structure and organization
   - Review testing setup and coverage
   - **Security audit**: Check for exposed secrets, vulnerable dependencies, insecure configurations, missing authentication/authorization
   - **Coding standards**: Verify linting rules, formatting consistency, naming conventions, code complexity
   - Evaluate CI/CD and deployment practices
   - Assess code quality tools and standards

4. Compare project state against each constitutional principle:
   - Identify gaps where the project doesn't meet requirements
   - Note missing files, configurations, or practices
   - Flag areas that need improvement or implementation
   - Prioritize items based on constitutional importance and security impact:
     * **Critical**: Security vulnerabilities, exposed secrets, unsafe dependencies
     * **High**: Missing security controls, coding standard violations, broken builds
     * **Medium**: Documentation gaps, incomplete testing, minor quality issues
     * **Low**: Style inconsistencies, optimization opportunities

5. Create `.specify/TODO.md` with:
   - Header with audit date and constitution version
   - Organized sections by constitutional principle
   - Each TODO item with:
     * Clear description of what needs to be done
     * Reference to specific constitutional requirement
     * Priority level (Critical/High/Medium/Low)
     * Estimated effort or complexity
     * Suggested implementation approach

6. Format the TODO list as:
   ```markdown
   # Constitutional Compliance TODO
   
   **Audit Date:** YYYY-MM-DD
   **Constitution Version:** X.Y.Z
   **Project Status:** [Compliant/Partially Compliant/Non-Compliant]
   
   ## Principle 1: [Name]
   
   ### Critical
   - [ ] Item description (Requirement: constitutional reference)
   
   ### High Priority
   - [ ] Item description (Requirement: constitutional reference)
   
   ### Medium Priority  
   - [ ] Item description (Requirement: constitutional reference)
   
   ### Low Priority
   - [ ] Item description (Requirement: constitutional reference)
   ```

7. Report summary with:
   - Total TODO items by priority
   - Overall compliance percentage
   - Next recommended actions
   - Suggested timeline for completion