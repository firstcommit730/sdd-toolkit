# React Project Constitution

<!-- React Application Constitution for Best Practices and Standards -->

Authoritative guardrails governing architecture, technology choices, coding standards, and evolution of this React project.

**Version**: 1.0.0  
**Ratified**: October 8, 2025  
**Last Amended**: October 8, 2025

## 1. Branching and Repository Standards - DO NOT REMOVE USED BY specify prompt

```yaml
branching_rules:
  - rule_name: Branch Naming Convention
    description: All Git branches must follow a strict naming pattern for React projects
    pattern: type/short-description

    constraints:
      must:
        - Follow pattern 'type/short-description'
        - Start with valid type prefix from allowed list
        - Use only lowercase letters (a-z), numbers (0-9), hyphens (-)
        - Be between 10-50 characters in length
        - Be created from up-to-date develop branch (except hotfix from main)

      must_not:
        - Begin with numbers or numeric prefixes
        - Contain uppercase letters
        - Contain spaces or special characters (_, @, #, $, %, ?, !)
        - Use invalid type prefixes

    allowed_type_prefixes:
      - feat        # New feature development
      - fix         # Bug fixes
      - chore       # Maintenance tasks
      - refactor    # Code refactoring
      - test        # Test additions or updates
      - docs        # Documentation changes
      - hotfix      # Critical production fixes

    length_constraints:
      minimum: 10
      maximum: 50

    examples:
      valid:
        - feat/add-user-profile
        - fix/handle-form-validation
        - docs/update-readme
        - chore/update-dependencies
        - refactor/simplify-hooks
      invalid:
        - user-profile          # Missing type prefix
        - 123-add-feature       # Starts with number
        - Feat/Add_Component    # Contains uppercase and underscore
        - fix/add              # Too short

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
        merge_destination: main
        merge_requirements:
          - successful_review
          - all_tests_passing
          - linting_passed

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

    examples:
      valid:
        - "feat: add user authentication component"
        - "fix: resolve form validation issue"
        - "docs: update component documentation"
        - "refactor: simplify useAuth hook logic"
      invalid:
        - "added new feature"                    # Past tense
        - "bug fix"                              # Missing type format
        - "Updated the component"                # Wrong tense, not descriptive
        - "feat stuff"                           # Not descriptive
```

## 2. Technology Stack

```yaml
technology_stack:
  description: "Mandated technologies for React projects requiring RFC + core maintainer approval for alternatives"

  locked_technologies:
    runtime:
      technology: Node.js 18+ / Bun
      notes: LTS versions only; Bun for performance gains
      change_process: formal_rfc_required
      approval_required: core_maintainers

    language:
      technology: TypeScript 5.0+
      constraints: Strict mode enabled; no JavaScript files
      change_process: formal_rfc_required
      approval_required: core_maintainers

    ui_framework:
      technology: React 18+
      restrictions: Function components only; hooks pattern
      change_process: formal_rfc_required
      approval_required: core_maintainers

    build_tool:
      technology: Vite / Next.js
      notes: Vite for SPA; Next.js for SSR/SSG
      change_process: formal_rfc_required
      approval_required: core_maintainers

    state_management:
      technology: Zustand / Redux RTK
      notes: Zustand preferred; RTK for complex state
      change_process: formal_rfc_required
      approval_required: core_maintainers

    styling:
      technology: Tailwind CSS / CSS Modules
      notes: Utility-first; CSS Modules for components
      change_process: formal_rfc_required
      approval_required: core_maintainers

    testing:
      technology: Vitest + RTL
      notes: Vitest for unit/integration; RTL for React
      change_process: formal_rfc_required
      approval_required: core_maintainers

    linting:
      technology: ESLint + Prettier
      notes: React-specific rules; automated formatting
      change_process: formal_rfc_required
      approval_required: core_maintainers

    package_manager:
      technology: pnpm
      notes: Workspace support; faster installs
      change_process: formal_rfc_required
      approval_required: core_maintainers

  prohibited_technologies:
    description: "Technologies that are explicitly prohibited without formal approval"
    list:
      - Vue.js
      - Angular
      - Svelte
      - jQuery
      - Bootstrap
      - Styled Components
      - Emotion
      - Class Components
    exception_process: formal_rfc_with_justification

  approval_process:
    trigger: alternative_technology_introduction
    required_approvers:
      - core_maintainers
    process_steps:
      - submit_formal_rfc
      - technical_review
      - security_assessment
      - performance_impact_analysis
      - maintainer_approval
      - constitution_amendment
```

## 3. Architectural Principles

```yaml
architectural_principles:
  - name: Component Composition Over Inheritance
    description: Favor composition patterns; avoid deep component hierarchies
    rationale: promotes_reusability_and_maintainability

  - name: Single Responsibility Components
    description: Each component serves one clear purpose; atomic design principles
    rationale: improves_testability_and_readability

  - name: Unidirectional Data Flow
    description: Props down, events up; predictable state mutations
    rationale: ensures_predictable_state_management

  - name: API Integration Patterns
    description: Centralized API layer with React Query/SWR for caching
    rationale: consistent_data_fetching_with_built_in_caching

  - name: Performance-First Rendering
    description: Code splitting, lazy loading, and memoization by default
    rationale: optimizes_initial_load_and_runtime_performance

  - name: Accessibility by Default
    description: ARIA compliance, semantic HTML, keyboard navigation support
    rationale: ensures_inclusive_user_experience

react_architecture_philosophy:
  container_presentational_pattern:
    description: Clear separation between smart and dumb components

    container_components:
      type: smart
      responsibilities:
        - manage_state_and_side_effects_using_hooks
        - handle_data_fetching_and_business_logic
      examples:
        - UserDashboardContainer
        - ProductListContainer

    presentational_components:
      type: dumb
      responsibilities:
        - render_ui_based_solely_on_props
        - no_side_effects
        - only_useMemo_useCallback_for_optimization
      communication: via_props_and_callback_functions

    custom_hooks:
      purpose: extract_reusable_stateful_logic
      examples:
        - useUserAuthentication
        - useLocalStorage
        - useApi

  component_hierarchy_pattern:
    methodology: atomic_design
    levels:
      - Atoms
      - Molecules
      - Organisms
      - Templates
      - Pages
    api_integration_level: page_or_template_level
```

## 4. Coding Standards

```yaml
coding_standards:
  - concern: Language
    standard: TypeScript 5.0+ with strict mode; no any types allowed
    enforcement: mandatory
    validation: compile_time_check

  - concern: Component Style
    standard: Function components only; PascalCase naming; default exports
    enforcement: mandatory
    validation: automated_linting

  - concern: Props Interface
    standard: Explicit TypeScript interfaces; Props suffix (UserCardProps)
    enforcement: mandatory
    validation: type_checking
    examples:
      valid: |
        interface UserCardProps {
          user: User;
          onEdit: (id: string) => void;
        }
        export default function UserCard({ user, onEdit }: UserCardProps) {...}
      invalid: |
        export default function UserCard(props: any) {...}  // any type not allowed

  - concern: Hooks Usage
    standard: Custom hooks with use prefix; dependency arrays required
    enforcement: mandatory
    validation: eslint_rules
    constraints:
      must:
        - start_with_use_prefix
        - include_complete_dependency_arrays
        - follow_rules_of_hooks
      must_not:
        - call_hooks_conditionally
        - call_hooks_in_loops
        - call_hooks_in_regular_functions

  - concern: State Management
    standard: useState for local; Zustand for global; immutable updates only
    enforcement: mandatory
    validation: code_review

  - concern: Async Patterns
    standard: React Query/SWR for data fetching; async/await syntax
    enforcement: mandatory
    validation: code_review

  - concern: Event Handling
    standard: Arrow functions in JSX; preventDefault for form submissions
    enforcement: mandatory
    validation: automated_linting

  - concern: Styling Approach
    standard: Tailwind utility classes; CSS modules for complex components
    enforcement: mandatory
    validation: code_review

  - concern: File Organization
    standard: Feature-based folders; index.ts barrel exports
    enforcement: mandatory
    validation: architecture_review

  - concern: Import Order
    standard: React, libraries, internal, relative; grouped with newlines
    enforcement: mandatory
    validation: eslint_import_order
    examples:
      valid: |
        import React, { useState } from 'react';
        import { useQuery } from '@tanstack/react-query';

        import { useAuth } from '@/hooks/useAuth';
        import { Button } from '@/components/ui';

        import styles from './Component.module.css';

  - concern: Error Boundaries
    standard: Wrap async components; graceful degradation with fallback UI
    enforcement: mandatory
    validation: code_review

  - concern: Performance
    standard: React.memo for pure components; useMemo/useCallback strategically
    enforcement: recommended
    validation: performance_profiling
    guidelines:
      - use_memo_for_expensive_computations
      - use_callback_for_stable_function_references
      - avoid_premature_optimization

  - concern: Accessibility
    standard: ARIA attributes; semantic HTML; keyboard navigation support
    enforcement: mandatory
    validation: automated_a11y_testing

  - concern: Form Validation
    standard: React Hook Form with Zod schema validation
    enforcement: mandatory
    validation: integration_tests

  - concern: Props Drilling
    standard: Max 3 levels deep; use context or state management beyond
    enforcement: mandatory
    validation: code_review
    anti_pattern: passing_props_through_multiple_layers
```

## 5. Linting & Code Quality Standards

```yaml
linting_standards:
  enforcement: strict
  merge_policy: all_code_must_pass_linting_checks
  exceptions: documented_justification_required

  mandatory_requirements:
    - standardized_eslint_prettier_configuration
    - centralized_ruleset_across_all_components
    - automated_ci_cd_pipeline_integration
    - build_failure_on_violations

  code_formatting:
    automated_formatting: on_save
    pre_commit_hooks: enforce_formatting_consistency

    prettier_configuration:
      semi: true
      trailingComma: es5
      singleQuote: true
      printWidth: 100
      tabWidth: 2
      useTabs: false
      bracketSpacing: true
      bracketSameLine: false
      arrowParens: avoid
      endOfLine: lf
      jsxSingleQuote: true
      quoteProps: as-needed

  eslint_configuration:
    extends:
      - "@typescript-eslint/recommended"
      - plugin:react/recommended
      - plugin:react-hooks/recommended
      - plugin:jsx-a11y/recommended

    critical_rules:
      react/prop-types: off
      react/react-in-jsx-scope: off
      react-hooks/exhaustive-deps: error
      jsx-a11y/anchor-is-valid: error
      "@typescript-eslint/no-unused-vars": error
      "@typescript-eslint/explicit-function-return-type": warn

  quality_metrics:
    static_analysis:
      - tool: SonarQube
        purpose: code_complexity_security_code_smells
      - tool: test_coverage_enforcement
        minimum_thresholds: integrated_into_linting_pipeline
      - tool: performance_linting
        purpose: detect_inefficient_patterns_suggest_optimizations

  language_specific_standards:
    react_jsx_rules:
      component_rules:
        naming: PascalCase
        style: function_components_only
        typing: proper_prop_typing_required

      hook_rules:
        must:
          - enforce_rules_of_hooks
          - complete_dependency_arrays
          - custom_hook_naming_convention

      jsx_rules:
        must:
          - self_closing_tags_when_appropriate
          - proper_attribute_spacing
          - consistent_quote_usage

      performance_rules:
        detection:
          - unnecessary_re_renders
          - missing_memoization_opportunities

      security_rules:
        must_prevent:
          - xss_via_dangerouslySetInnerHTML
          - unvalidated_href_attributes

    typescript_rules:
      type_safety:
        must:
          - no_any_types
          - explicit_return_types_for_functions
          - strict_null_checks

      import_export:
        must:
          - consistent_import_organization
          - no_unused_imports
          - proper_barrel_exports

      interface_rules:
        prefer: interfaces_over_types
        naming_convention: Props_suffix_for_component_props

      generic_rules:
        must:
          - proper_generic_constraints
          - meaningful_generic_parameter_names

    accessibility_rules:
      aria_compliance:
        must:
          - required_aria_attributes_for_interactive_elements

      semantic_html:
        must:
          - proper_html_semantics
          - heading_hierarchy_validation

      keyboard_navigation:
        must:
          - focusable_elements_have_proper_tabindex
          - proper_keyboard_event_handlers

      color_contrast:
        enforcement: warn
        purpose: detect_potential_contrast_issues

  developer_experience:
    ide_integration:
      editor: VS_Code
      extensions:
        - ESLint
        - Prettier
      feedback: real_time

    pre_commit_hooks:
      tool: husky_with_lint_staged
      validation:
        - automated_linting
        - automated_formatting

    exception_handling:
      syntax: "// eslint-disable-next-line rule-name"
      requirement: justification_comment_mandatory
```

## 6. Testing Rules

```yaml
testing_standards:
  coverage_requirements:
    minimum_line_coverage: 80%
    critical_business_logic_coverage: 90%
    threshold_policy: coverage_cannot_decrease_between_commits
    new_feature_requirement: tests_mandatory

  test_file_organization:
    unit_tests:
      location: colocated_in___tests___directories
      structure:
        - example_source: src/components/Button/Button.tsx
          example_test: src/components/Button/__tests__/Button.test.tsx
        - example_source: src/hooks/useAuth.ts
          example_test: src/hooks/__tests__/useAuth.test.ts
      naming_convention:
        must_end_with: .test.tsx or .test.ts

    integration_tests:
      location: src/__tests__/integration
      purpose: validate_component_interactions_and_data_flow
      example: src/__tests__/integration/UserDashboard.integration.test.tsx
      naming_convention:
        must_end_with: .integration.test.tsx

    e2e_tests:
      location: e2e_directory_at_project_root
      purpose: full_application_workflow_testing
      frameworks: Playwright or Cypress
      naming_convention:
        must_end_with: .e2e.test.ts
      requirements:
        - mock_external_apis_and_services
        - ensure_consistent_test_environment

  react_testing_standards:
    philosophy: test_behavior_not_implementation_details

    component_testing:
      approach:
        - render_components_with_realistic_props
        - test_user_interactions
        - validate_output_not_internal_state
      library: "@testing-library/react"

    hook_testing:
      approach: isolated_hook_testing
      library: "@testing-library/react-hooks"

    async_testing:
      proper_handling:
        - use_waitFor_for_async_operations
        - use_findBy_queries_for_async_elements
        - avoid_act_warnings

    mock_strategy:
      must:
        - mock_external_dependencies
      must_not:
        - mock_react_internals

    snapshot_testing:
      usage: limited
      appropriate_for: static_components_only
      prefer: semantic_assertions_over_snapshots
```

## 7. Security & Privacy

```yaml
security_standards:
  core_principles:
    - principle: least_privilege
      application: access_control_and_component_permissions

    - principle: no_plaintext_secrets
      requirement: environment_variables_for_configuration_only

    - principle: csrf_xss_protection
      enforcement: all_form_submissions_and_data_rendering

  input_validation:
    react_xss_prevention:
      must_not:
        - use_dangerouslySetInnerHTML_without_dompurify_sanitization
      must:
        - validate_all_user_inputs
        - sanitize_before_rendering

    form_validation:
      client_side:
        tool: Zod_schemas
        purpose: immediate_user_feedback
      server_side:
        requirement: always_validate
        reason: client_validation_can_be_bypassed

    url_validation:
      must:
        - sanitize_and_validate_href_attributes
        - prevent_javascript_protocol_injection

    content_security_policy:
      requirements:
        - implement_strict_csp_headers
        - no_inline_scripts_allowed
        - no_inline_styles_allowed

  react_specific_measures:
    component_security:
      must:
        - sanitize_props_before_rendering
        - validate_children_prop_types

    state_security:
      must_not:
        - store_sensitive_data_in_react_state
      must:
        - use_secure_storage_apis

    third_party_components:
      requirements:
        - security_audit_all_npm_dependencies
        - prefer_well_maintained_libraries
        - verify_package_integrity

    build_security:
      tools:
        - webpack_bundle_analyzer: detect_malicious_packages
        - sri_hashes: subresource_integrity

  network_security:
    api_security:
      must:
        - implement_proper_cors_policies
        - use_https_for_all_api_communications

    authentication:
      token_storage: httpOnly_cookies
      requirements:
        - implement_proper_token_refresh_flow
        - short_lived_access_tokens

    request_validation:
      must:
        - validate_api_responses_before_state_updates
        - handle_error_responses_gracefully
        - implement_timeout_mechanisms
```

## 8. Glossary

```yaml
glossary:
  - term: Component
    definition: Reusable UI element written as a React function component with TypeScript props interface
    category: react_architecture

  - term: Hook
    definition: Custom React hook for reusable stateful logic, must start with 'use' prefix
    category: react_patterns

  - term: Container Component
    definition: Smart component that manages state and side effects, delegates rendering to presentational components
    category: react_architecture

  - term: Presentational Component
    definition: Dumb component that receives data via props and renders UI without side effects
    category: react_architecture

  - term: Props Drilling
    definition: Anti-pattern of passing props through multiple component layers; use context or state management instead
    category: anti_patterns

  - term: Hydration
    definition: Process of attaching React event handlers to server-rendered HTML markup
    category: react_ssr

  - term: Code Splitting
    definition: Technique to split JavaScript bundles for lazy loading and improved performance
    category: performance

  - term: CSP
    definition: Content Security Policy - Browser security feature preventing XSS attacks via script injection
    category: security

  - term: XSS Prevention
    definition: Cross-Site Scripting prevention through input sanitization and output encoding
    category: security

  - term: RTL
    definition: React Testing Library - Testing utilities focused on testing behavior over implementation details
    category: testing

  - term: Zustand
    definition: Lightweight state management library for React applications
    category: state_management

  - term: Barrel Export
    definition: index.ts file that re-exports multiple modules for cleaner import statements
    category: code_organization
```

## 9. Enforcement

```yaml
enforcement_policy:
  pull_request_requirements:
    automated_checks:
      must_pass:
        - linting_checks
        - testing_checks
        - security_checks
      blocking: cannot_merge_without_passing

  code_review_requirements:
    must_verify:
      - compliance_with_architectural_principles
      - adherence_to_coding_standards
      - proper_test_coverage
      - security_best_practices

  regular_audits:
    schedule: quarterly
    scope:
      - dependency_security_audit
      - security_practices_review
      - constitution_compliance_check
      - performance_benchmarks

constitution_metadata:
  version: 1.0.0
  last_updated: "2025-10-08"
  change_summary: Streamlined React project constitution with essential best practices for TypeScript, testing, security, and performance
```
