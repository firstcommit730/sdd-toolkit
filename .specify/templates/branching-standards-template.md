# Branching and Repository Standards

This file contains branching standards used by the specify prompt for branch creation and management.

```yaml
branching_rules:
  - rule_name: Branch Naming Convention
    description: All Git branches must follow a strict naming pattern for consistency and automation
    pattern: type/short-description

    constraints:
      must:
        - Follow pattern 'type/short-description'
        - Start with valid type prefix from allowed list
        - Use only lowercase letters (a-z), numbers (0-9), hyphens (-), and forward slashes (/)
        - Be between 10-50 characters in length
        - Be created from up-to-date develop branch (except hotfix from main, maintenance from main or develop)

      must_not:
        - Begin with numbers or numeric prefixes
        - Contain uppercase letters
        - Contain spaces or special characters (_, @, #, $, %, ?, !)
        - Use invalid type prefixes

      may:
        - Include numbers inside the name when semantically relevant (e.g., version or API level)

    allowed_type_prefixes:
      - feat        # New feature development
      - fix         # Bug fixes
      - chore       # Maintenance tasks
      - refactor    # Code refactoring
      - test        # Test additions or updates
      - docs        # Documentation changes
      - hotfix      # Critical production fixes
      - maintenance # Dependency updates and operational maintenance

    length_constraints:
      minimum: 10
      maximum: 50

    examples:
      valid:
        - feat/add-payment-endpoint
        - fix/handle-auth-timeout
        - docs/update-readme
        - maintenance/update-dependencies
        - feat/add-v2-endpoint
        - chore/refactor-logging
      invalid:
        - user-authentication-system  # Missing type prefix
        - 123-fix-bug                 # Starts with number
        - Fix_DB_Bug                  # Contains uppercase and underscore
        - feat/123-add-endpoint       # Number after type prefix
        - new-feature                 # Too short

  - rule_name: Branch Lifecycle Management
    description: Defines the lifecycle and merge patterns for different branch types

    branches:
      main:
        description: Production-ready code only
        protection_level: protected
        deployment_ready: true
        merge_sources:
          - develop
          - hotfix/*
        merge_method: pull_request

      develop:
        description: Integration branch for features
        merge_sources:
          - feature/*
          - maintenance/*
        merge_destination: main
        merge_requirements:
          - successful_audit
          - all_tests_passing
          - code_review_approved

      feature/*:
        description: New feature development
        created_from: develop
        merge_destination: develop
        lifecycle: short_lived
        merge_requirements:
          - all_checks_pass
          - pr_review_approved
          - no_merge_conflicts

      hotfix/*:
        description: Critical production fixes
        created_from: main
        merge_destinations:
          - main
          - develop
        priority: critical
        merge_method: emergency_procedure

      maintenance/*:
        description: Dependency updates, security patches, operational maintenance
        created_from:
          - main
          - develop
        merge_destinations:
          - main
          - develop
        merge_requirements:
          - code_review
          - successful_tests
          - security_scan_passed

  - rule_name: Commit Message Standards
    description: Standardized commit message format for clarity and automation
    format: "[TYPE]: [BRIEF_DESCRIPTION]"

    constraints:
      must:
        - Follow format '[TYPE]: [BRIEF_DESCRIPTION]'
        - Use imperative mood (add, fix, update - NOT added, fixed, updated)
        - Be clear and descriptive of the change
        - Match the branch type prefix
        - Use lowercase for type prefix

      must_not:
        - Exceed 72 characters in subject line
        - Use past tense or present continuous
        - Include sensitive information
        - Be vague or non-descriptive

    components:
      type:
        description: Commit category matching branch type
        values:
          - feat
          - fix
          - chore
          - refactor
          - test
          - docs
          - hotfix
          - maintenance

      brief_description:
        description: Concise description of the change
        max_length: 72
        style: imperative_mood

    examples:
      valid:
        - "feat: add user authentication endpoint"
        - "fix: resolve timeout issue in payment processing"
        - "docs: update API documentation for v2.1"
        - "refactor: simplify error handling logic"
        - "test: add unit tests for validation module"
      invalid:
        - "added new feature"                                    # Past tense
        - "bug fix"                                              # Missing type prefix format
        - "Updated the readme file with new instructions"        # Too long, wrong tense
        - "fix stuff"                                            # Not descriptive
        - "FEAT: Add Feature"                                    # Uppercase type
```
