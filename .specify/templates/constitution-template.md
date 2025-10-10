# [PROJECT_NAME] Constitution - TEMPLATE

<!-- Example: Project Constitution, TaskFlow Constitution, etc. -->

Authoritative guardrails governing architecture, technology choices, coding standards, and evolution of this project.

**Version**: [CONSTITUTION_VERSION]  
**Ratified**: [RATIFICATION_DATE]  
**Last Amended**: [LAST_AMENDED_DATE]

## 1. Branching and Repository Standards

> **Note**: Branching standards have been extracted to a separate file for use by the specify prompt.  
> See: `.specify/memory/branching-standards.md` (copied from `.specify/templates/branching-standards-template.md` during constitution initialization)

## 2. Immutable Technology Stack

```yaml
technology_stack:
  description: "Mandated technologies requiring formal RFC + core maintainer approval for alternatives"

  locked_technologies:
    runtime:
      technology: [RUNTIME_TECHNOLOGY]
      notes: [RUNTIME_NOTES]
      change_process: formal_rfc_required
      approval_required: core_maintainers

    language:
      technology: [LANGUAGE_CHOICE]
      constraints: [LANGUAGE_CONSTRAINTS]
      change_process: formal_rfc_required
      approval_required: core_maintainers

    compute:
      technology: [COMPUTE_PLATFORM]
      restrictions: [COMPUTE_RESTRICTIONS]
      change_process: formal_rfc_required
      approval_required: core_maintainers

    api_layer:
      technology: [API_GATEWAY_CHOICE]
      restrictions: [API_RESTRICTIONS]
      change_process: formal_rfc_required
      approval_required: core_maintainers

    data_store:
      technology: [DATABASE_CHOICE]
      restrictions: [DATABASE_RESTRICTIONS]
      change_process: formal_rfc_required
      approval_required: core_maintainers

    testing:
      technology: [TESTING_FRAMEWORK]
      constraints: [TESTING_CONSTRAINTS]
      change_process: formal_rfc_required
      approval_required: core_maintainers

    logging:
      technology: [LOGGING_PLATFORM]
      notes: [LOGGING_NOTES]
      change_process: formal_rfc_required
      approval_required: core_maintainers

    auditing:
      technology: [AUDITING_PLATFORM]
      notes: [AUDITING_NOTES]
      change_process: formal_rfc_required
      approval_required: core_maintainers

  prohibited_technologies:
    description: "Technologies that are explicitly prohibited without formal approval"
    list:
      - [LIST_PROHIBITED_TECHNOLOGIES]
    exception_process: formal_rfc_with_justification

  approval_process:
    trigger: alternative_technology_introduction
    required_approvers:
      - core_maintainers
    process_steps:
      - submit_formal_rfc
      - technical_review
      - security_assessment
      - cost_benefit_analysis
      - maintainer_approval
      - constitution_amendment

    rfc_requirements:
      must_include:
        - problem_statement
        - proposed_solution
        - alternative_evaluation
        - migration_strategy
        - risk_assessment
        - timeline_and_resources
```

PROHIBITED without approval: [LIST_PROHIBITED_TECHNOLOGIES]

## 3. Architectural Principles

1. [PRINCIPLE_1_DESCRIPTION] <!-- Example: Event-driven, stateless handlers -->
2. [PRINCIPLE_2_DESCRIPTION] <!-- Example: One responsibility per service -->
3. [PRINCIPLE_3_DESCRIPTION] <!-- Example: Service class delegation pattern -->
4. [PRINCIPLE_4_DESCRIPTION] <!-- Example: Network egress justification -->
5. [PRINCIPLE_5_DESCRIPTION] <!-- Example: Database design pattern -->
6. [PRINCIPLE_6_DESCRIPTION] <!-- Example: Operation time limits -->

### Service Architecture Philosophy

**[SERVICE_PATTERN_NAME]**: [SERVICE_PATTERN_DESCRIPTION]

1. **[SERVICE_COMPONENT_1]**

   - [SERVICE_COMPONENT_1_DESCRIPTION]
   - [SERVICE_COMPONENT_1_RESPONSIBILITIES]
   - Examples: [SERVICE_COMPONENT_1_EXAMPLES]

2. **[SERVICE_COMPONENT_2]**

   - **[SUBCOMPONENT_A]**: [SUBCOMPONENT_A_DESCRIPTION]
   - **[SUBCOMPONENT_B]**: [SUBCOMPONENT_B_DESCRIPTION]
   - Both layers [INTEGRATION_PATTERN]

3. **[SERVICE_COMPONENT_3]**
   - [SERVICE_COMPONENT_3_DESCRIPTION]
   - Example: [SERVICE_COMPONENT_3_EXAMPLE]

**[CRUD_PATTERN_NAME]**: [CRUD_PATTERN_DESCRIPTION]

- [CRUD_PATTERN_DETAILS]
- Service routes [HTTP_ROUTING_PATTERN]:
  - `POST /resource` → [POST_FLOW]
  - `GET /resource/:id` → [GET_FLOW]
  - `PATCH /resource/:id` → [PATCH_FLOW]
  - `DELETE /resource/:id` → [DELETE_FLOW]

**Benefits of [PATTERN_NAME]**:

- [BENEFIT_1]
- [BENEFIT_2]
- [BENEFIT_3]
- [BENEFIT_4]
- [BENEFIT_5]

### Security Architecture Principles

**[SECURITY_BY_DESIGN_PRINCIPLE]**: [SECURITY_BY_DESIGN_DESCRIPTION]

1. **[DEFENSE_IN_DEPTH_PRINCIPLE]**

   - [MULTIPLE_SECURITY_LAYERS_DESCRIPTION] <!-- Example: Multiple layers of security controls throughout the system -->
   - [REDUNDANT_CONTROLS_POLICY] <!-- Example: No single point of security failure -->
   - [SECURITY_CONTROL_VALIDATION] <!-- Example: Each layer independently validates security requirements -->

2. **[ZERO_TRUST_ARCHITECTURE]**

   - [ZERO_TRUST_DESCRIPTION] <!-- Example: Never trust, always verify principle -->
   - [IDENTITY_VERIFICATION_REQUIREMENTS] <!-- Example: All requests authenticated and authorized regardless of source -->
   - [NETWORK_SEGMENTATION_APPROACH] <!-- Example: Micro-segmentation and least-privilege network access -->

3. **[SECURITY_MONITORING_ARCHITECTURE]**
   - [COMPREHENSIVE_LOGGING_REQUIREMENTS] <!-- Example: All security-relevant events logged with correlation IDs -->
   - [REAL_TIME_THREAT_DETECTION] <!-- Example: Automated threat detection and response capabilities -->
   - [SECURITY_METRICS_COLLECTION] <!-- Example: Security metrics collection and analysis for continuous improvement -->

## 4. Coding Standards

```yaml
coding_standards:
  - concern: Language
    standard: [LANGUAGE_STANDARD]
    enforcement: mandatory
    validation: automated_linting

  - concern: Type Safety
    standard: [TYPE_SAFETY_REQUIREMENTS]
    enforcement: mandatory
    validation: compile_time_check

  - concern: Async Patterns
    standard: [ASYNC_PATTERN_REQUIREMENTS]
    enforcement: mandatory
    validation: code_review

  - concern: Modularity
    standard: [MODULARITY_STANDARDS]
    enforcement: mandatory
    validation: architecture_review

  - concern: Error Handling
    standard: [ERROR_HANDLING_PATTERN]
    enforcement: mandatory
    validation: automated_linting
    examples:
      valid: |
        try {
          const result = await operation();
          return result;
        } catch (error) {
          logger.error('Operation failed', { correlationId, error });
          throw error;
        }
      invalid: |
        const result = await operation(); // No error handling

  - concern: Logging
    standard: "[LOGGING_LIBRARY]; [LOGGING_PATTERN]"
    enforcement: mandatory
    validation: automated_scanning
    requirements:
      - use_structured_logging
      - include_correlation_id
      - never_log_secrets
      - consistent_field_names

  - concern: Secrets
    standard: [SECRET_HANDLING_RULES]
    enforcement: mandatory
    validation: automated_secret_scanning
    prohibited:
      - plaintext_secrets_in_code
      - secrets_in_environment_variables
      - secrets_in_logs
      - secrets_in_error_messages

  - concern: Validation
    standard: [INPUT_VALIDATION_REQUIREMENTS]
    enforcement: mandatory
    validation: security_review
    requirements:
      - validate_all_external_inputs
      - sanitize_before_persistence
      - type_checking
      - boundary_validation

  - concern: DTOs / Models
    standard: [DTO_NAMING_CONVENTIONS]
    enforcement: mandatory
    validation: code_review
    requirements:
      - clear_naming
      - type_annotations
      - immutability_preferred
      - validation_methods
```

## 5. Linting & Code Quality Standards

### Mandatory Linting Requirements

- **[LINTER_ENFORCEMENT_POLICY]**: [LINTER_ENFORCEMENT_DESCRIPTION] <!-- Example: All code must pass linting checks before merge; no exceptions without documented justification -->
- **[LINTING_TOOL_STANDARDIZATION]**: [LINTING_TOOL_DESCRIPTION] <!-- Example: Standardized linter configuration across all projects with centralized ruleset management -->
- **[AUTOMATED_LINTING_INTEGRATION]**: [AUTOMATED_LINTING_DESCRIPTION] <!-- Example: Linting integrated into CI/CD pipeline with build failure on violations -->

#### Core Linting Categories

| Category        | Requirement                     | Enforcement Level             |
| --------------- | ------------------------------- | ----------------------------- |
| Syntax          | [SYNTAX_LINTING_RULES]          | [SYNTAX_ENFORCEMENT]          |
| Style           | [STYLE_LINTING_RULES]           | [STYLE_ENFORCEMENT]           |
| Security        | [SECURITY_LINTING_RULES]        | [SECURITY_ENFORCEMENT]        |
| Performance     | [PERFORMANCE_LINTING_RULES]     | [PERFORMANCE_ENFORCEMENT]     |
| Maintainability | [MAINTAINABILITY_LINTING_RULES] | [MAINTAINABILITY_ENFORCEMENT] |

### Code Formatting Standards

- **[AUTO_FORMATTING_REQUIREMENT]**: [AUTO_FORMATTING_DESCRIPTION] <!-- Example: Automated code formatting on save with consistent configuration across development environments -->
- **[FORMATTING_TOOL_INTEGRATION]**: [FORMATTING_TOOL_DESCRIPTION] <!-- Example: Integrated formatter (Prettier, Black, gofmt) with project-specific configuration -->
- **[FORMATTING_VALIDATION]**: [FORMATTING_VALIDATION_DESCRIPTION] <!-- Example: CI pipeline validates formatting consistency and fails on deviations -->

#### Formatting Configuration Standards

```yaml
# Example: Standardized Formatting Configuration
[FORMATTING_CONFIG_EXAMPLE]: |
  indent_size: [INDENT_SIZE]
  indent_style: [INDENT_STYLE]
  max_line_length: [MAX_LINE_LENGTH]
  trim_trailing_whitespace: [TRIM_WHITESPACE_SETTING]
  insert_final_newline: [FINAL_NEWLINE_SETTING]
  quote_style: [QUOTE_STYLE_PREFERENCE]
  semicolon_style: [SEMICOLON_POLICY]
```

### Static Analysis Integration

- **[STATIC_ANALYSIS_TOOLS]**: [STATIC_ANALYSIS_DESCRIPTION] <!-- Example: Integrated static analysis tools for complexity, security vulnerabilities, and code smells -->
- **[COMPLEXITY_THRESHOLDS]**: [COMPLEXITY_THRESHOLD_DESCRIPTION] <!-- Example: Cyclomatic complexity limits with automated detection and reporting -->
- **[SECURITY_SCANNING_INTEGRATION]**: [SECURITY_SCANNING_DESCRIPTION] <!-- Example: Security-focused linting rules to detect potential vulnerabilities and unsafe patterns -->

#### Quality Metrics Tracking

1. **[CODE_COVERAGE_INTEGRATION]**

   - [COVERAGE_LINTING_REQUIREMENTS] <!-- Example: Linting rules to enforce test coverage thresholds and identify untested code paths -->
   - [COVERAGE_REPORTING_STANDARDS] <!-- Example: Standardized coverage reporting format integrated with linting pipeline -->

2. **[TECHNICAL_DEBT_DETECTION]**

   - [DEBT_IDENTIFICATION_RULES] <!-- Example: Automated detection of TODO comments, deprecated API usage, and code debt markers -->
   - [DEBT_TRACKING_INTEGRATION] <!-- Example: Integration with project management tools for technical debt tracking -->

3. **[PERFORMANCE_LINTING]**
   - [PERFORMANCE_RULE_ENFORCEMENT] <!-- Example: Performance-focused linting rules for inefficient patterns and resource usage -->
   - [OPTIMIZATION_SUGGESTIONS] <!-- Example: Automated suggestions for code optimization opportunities -->

### Language-Specific Linting Standards

#### [LANGUAGE_1_NAME] Specific Rules

- [LANGUAGE_1_LINTING_RULES] <!-- Example: Language-specific linting rules and best practices -->
- [LANGUAGE_1_STYLE_GUIDES] <!-- Example: Official style guide compliance and enforcement -->
- [LANGUAGE_1_SECURITY_RULES] <!-- Example: Language-specific security vulnerability detection -->

#### [LANGUAGE_2_NAME] Specific Rules

- [LANGUAGE_2_LINTING_RULES] <!-- Example: Framework-specific linting rules and patterns -->
- [LANGUAGE_2_PERFORMANCE_RULES] <!-- Example: Performance optimization rules specific to the language/framework -->
- [LANGUAGE_2_ACCESSIBILITY_RULES] <!-- Example: Accessibility linting for frontend frameworks -->

### Custom Rule Development

- **[CUSTOM_RULE_APPROVAL_PROCESS]**: [CUSTOM_RULE_DESCRIPTION] <!-- Example: Process for proposing, reviewing, and implementing project-specific linting rules -->
- **[RULE_TESTING_REQUIREMENTS]**: [RULE_TESTING_DESCRIPTION] <!-- Example: Testing requirements for custom linting rules including false positive/negative validation -->
- **[RULE_DOCUMENTATION_STANDARDS]**: [RULE_DOCUMENTATION_DESCRIPTION] <!-- Example: Documentation requirements for custom rules including rationale and examples -->

### Developer Experience & Tooling

#### IDE Integration Requirements

- [IDE_LINTING_INTEGRATION] <!-- Example: Consistent linting integration across all supported IDEs and editors -->
- [REAL_TIME_FEEDBACK] <!-- Example: Real-time linting feedback during development with quick-fix suggestions -->
- [CONFIGURATION_SYNCHRONIZATION] <!-- Example: Synchronized linting configuration between local development and CI environments -->

#### Developer Workflow Integration

- **[PRE_COMMIT_HOOKS]**: [PRE_COMMIT_DESCRIPTION] <!-- Example: Automated pre-commit hooks for linting and formatting validation -->
- **[INCREMENTAL_LINTING]**: [INCREMENTAL_LINTING_DESCRIPTION] <!-- Example: Incremental linting to check only changed files for faster feedback -->
- **[LINTING_PERFORMANCE_OPTIMIZATION]**: [LINTING_PERFORMANCE_DESCRIPTION] <!-- Example: Optimized linting configuration for fast feedback without compromising quality -->

### Exception Handling & Overrides

- **[LINTING_EXCEPTION_POLICY]**: [LINTING_EXCEPTION_DESCRIPTION] <!-- Example: Documented process for linting rule exceptions with justification requirements -->
- **[SUPPRESS_COMMENT_STANDARDS]**: [SUPPRESS_COMMENT_DESCRIPTION] <!-- Example: Standardized format for suppressing linting rules with required documentation -->
- **[EXCEPTION_REVIEW_PROCESS]**: [EXCEPTION_REVIEW_DESCRIPTION] <!-- Example: Peer review requirements for linting exceptions and suppressions -->

#### Approved Suppression Format

```pseudocode
// Standardized Linting Suppression Pattern
[SUPPRESSION_FORMAT_EXAMPLE]:
  // LINT_SUPPRESS: [RULE_NAME] - [JUSTIFICATION]
  // Author: [DEVELOPER_NAME]
  // Date: [SUPPRESSION_DATE]
  // Review: [REVIEWER_NAME]

  [CODE_THAT_VIOLATES_RULE]

  // END_LINT_SUPPRESS
```

### Continuous Improvement

- [LINTING_RULE_REVIEW_CYCLE] <!-- Example: Regular review and update cycle for linting rules and configurations -->
- [TEAM_FEEDBACK_INTEGRATION] <!-- Example: Process for incorporating developer feedback into linting rule evolution -->
- [INDUSTRY_BEST_PRACTICE_ADOPTION] <!-- Example: Regular evaluation and adoption of industry-standard linting practices -->
- [LINTING_METRICS_ANALYSIS] <!-- Example: Analysis of linting violation patterns to identify training or process improvements -->

## 6. Testing Rules

```yaml
testing_standards:
  coverage:
    requirements: [COVERAGE_REQUIREMENTS]
    threshold_policy: [COVERAGE_THRESHOLD_POLICY]
    exclusions: [COVERAGE_EXCLUSIONS]
    enforcement: mandatory
    validation: automated_ci_check

  test_organization:
    - test_type: [TEST_TYPE_1]
      location_rule: [TEST_LOCATION_1]
      directory: [TEST_DIRECTORY_1]
      placement: [TEST_PLACEMENT_1]
      suffix: [TEST_SUFFIX_1]

      constraints:
        must:
          - be_colocated_with_source
          - end_with_specified_suffix
          - follow_naming_convention
        must_not:
          - be_placed_in: [PROHIBITED_TEST_LOCATION_1]

      examples:
        - source: [SOURCE_EXAMPLE_1]
          test: [TEST_EXAMPLE_1]
        - source: [SOURCE_EXAMPLE_2]
          test: [TEST_EXAMPLE_2]

    - test_type: [TEST_TYPE_2]
      location_rule: [TEST_LOCATION_2]
      directory: [TEST_DIRECTORY_2]
      placement: [TEST_PLACEMENT_2]
      description: [TEST_TYPE_2_DESCRIPTION]
      suffix: [CONTRACT_SUFFIX]

      examples:
        - contract: [CONTRACT_EXAMPLE_1]
          test: [CONTRACT_EXAMPLE_2]

    - test_type: [TEST_TYPE_3]
      location_rule: exclusive_directory
      directory: [INTEGRATION_DIRECTORY]
      restrictions: [INTEGRATION_TEST_RESTRICTIONS]
      suffix: [INTEGRATION_SUFFIX]
      mocking_requirements: [INTEGRATION_TEST_MOCKING_REQUIREMENTS]

      constraints:
        must:
          - be_in_dedicated_directory
          - test_real_integrations
          - include_proper_setup_teardown
        must_not:
          - be_mixed_with_unit_tests
          - mock_external_services_excessively

    - test_type: [TEST_TYPE_4]
      policy: [PERFORMANCE_TEST_POLICY]
      directory_status: [PERFORMANCE_DIRECTORY_STATUS]
      optimization_approach: [PERFORMANCE_OPTIMIZATION_APPROACH]
      exception_policy: [PERFORMANCE_TEST_EXCEPTION_POLICY]

  security_testing:
    requirement: mandatory
    test_types: [SECURITY_TEST_TYPES]

    test_categories:
      authentication:
        requirements: [AUTHENTICATION_TEST_REQUIREMENTS]
        examples:
          - authentication_bypass_attempts
          - invalid_token_handling
          - session_management_validation

      authorization:
        requirements: [AUTHORIZATION_TEST_REQUIREMENTS]
        examples:
          - privilege_escalation_tests
          - role_boundary_validation
          - permission_enforcement

      input_validation:
        requirements: [INPUT_VALIDATION_TEST_REQUIREMENTS]
        examples:
          - sql_injection_tests
          - xss_attack_tests
          - command_injection_tests

      cryptographic:
        requirements: [CRYPTOGRAPHIC_TEST_REQUIREMENTS]
        examples:
          - encryption_decryption_validation
          - key_management_tests
          - secure_random_generation

    organization:
      location: [SECURITY_TEST_LOCATION]
      suffix: [SECURITY_TEST_SUFFIX]
      examples:
        - source: [SECURITY_TEST_EXAMPLE_1]
          test: [SECURITY_TEST_EXAMPLE_2]

    penetration_testing:
      simulation: [PENETRATION_TEST_SIMULATION]
      scope: [PENTEST_SCOPE]
      requirements: [PENTEST_SIMULATION_REQUIREMENTS]
      baseline_validation: [SECURITY_BASELINE_VALIDATION]

  flow_documentation:
    requirements: [FLOW_DOCUMENTATION_REQUIREMENTS]
    directory: [FLOW_DIRECTORY]
    definition: [FLOW_TEST_DEFINITION]

    constraints:
      must:
        - document_entry_points: [FLOW_TEST_ENTRY_POINT_REQUIREMENTS]
        - validate_complete_flows: [FLOW_TEST_VALIDATION_SCOPE]
        - include_documentation: [FLOW_DOCUMENTATION_CONTENT_REQUIREMENTS]

      directory_contents: [FLOW_DIRECTORY_CONTENTS]
      distinction_from_integration: [FLOW_VS_INTEGRATION_TEST_DISTINCTION]

  integration_testing:
    requirements: [INTEGRATION_TEST_REQUIREMENTS]
    logging_requirements: [INTEGRATION_TEST_LOGGING_REQUIREMENTS]
    mocking_scope: [INTEGRATION_TEST_MOCKING_SCOPE]

    constraints:
      must:
        - test_real_service_interactions
        - include_proper_logging
        - validate_error_scenarios
      must_not:
        - mock_critical_integrations
        - skip_cleanup_operations

  mocking:
    unit_test_permissions: [UNIT_TEST_MOCKING_PERMISSIONS]
    implementation_requirements: [MOCK_IMPLEMENTATION_REQUIREMENTS]

    best_practices:
      - use_consistent_mocking_framework
      - mock_external_dependencies
      - verify_mock_interactions
      - maintain_realistic_behavior
```

## 7. Logging Standards (Detailed Implementation)

```yaml
logging_standards:
  entry_pattern:
    pattern: [LOGGING_ENTRY_PATTERN]
    message_guidelines: [LOGGING_MESSAGE_GUIDELINES]
    parameter_inclusion: [LOGGING_PARAMETER_INCLUSION]
    format: [LOGGING_FORMAT_PATTERN]

    constraints:
      must:
        - log_at_operation_entry
        - include_correlation_id
        - use_structured_format
        - be_concise_and_clear
      must_not:
        - log_sensitive_data
        - use_string_concatenation
        - exceed_reasonable_size

  test_environment:
    output_requirements: [TEST_LOGGING_OUTPUT_REQUIREMENTS]
    format_consistency: [TEST_LOGGING_FORMAT_CONSISTENCY]
    cloud_prevention: [TEST_LOGGING_CLOUD_PREVENTION]

    constraints:
      must:
        - maintain_same_format_as_production
        - output_to_console
        - be_parseable
      must_not:
        - send_to_cloud_services
        - skip_critical_fields

  required_fields:
    mandatory:
      - field: correlationId
        type: string
        description: "Unique identifier to trace requests across services"
        validation: uuid_or_similar

      - field: timestamp
        type: string
        format: iso_8601
        description: "ISO 8601 format timestamp"
        validation: valid_iso8601

      - field: level
        type: enum
        values: [INFO, DEBUG, WARN, ERROR]
        description: "Log level classification"
        validation: one_of_allowed_values

      - field: service
        type: string
        description: "Name of service/component generating the log"
        validation: non_empty_string

      - field: message
        type: string
        description: "Human-readable log message"
        validation: non_empty_descriptive

    optional_context:
      - field: operation
        type: string
        description: "Specific function/method being executed"
        when: available

      - field: userId
        type: string
        description: "User identifier when available"
        when: user_context_exists

      - field: sessionId
        type: string
        description: "Session identifier when available"
        when: session_context_exists

      - field: requestId
        type: string
        description: "Request identifier for HTTP/API calls"
        when: http_request_context

      - field: duration
        type: number
        unit: milliseconds
        description: "Operation execution time"
        when: operation_complete

      - field: outcome
        type: enum
        values: [success, failure, timeout, partial]
        description: "Result status"
        when: operation_complete

    error_specific:
      - field: errorCode
        type: string
        description: "Application-specific error code"
        required_when: level == ERROR

      - field: errorMessage
        type: string
        description: "Error description"
        required_when: level == ERROR

      - field: errorType
        type: string
        description: "Error category/classification"
        required_when: level == ERROR

      - field: stackTrace
        type: string
        description: "Technical stack trace"
        required_when: level == ERROR
        environment_restriction: development_only
        production_behavior: exclude

  implementation_examples:
    entry_logging:
      pattern: 'LOG.INFO("[OPERATION_NAME] started", {correlationId, userId, requestId})'
      use_case: operation_entry_point

    success_logging:
      pattern: 'LOG.INFO("[OPERATION_NAME] completed", {correlationId, outcome: "success", duration})'
      use_case: successful_operation_completion

    error_logging:
      pattern: 'LOG.ERROR("[OPERATION_NAME] failed", {correlationId, errorCode, errorType})'
      use_case: operation_failure

    sample_implementation: |
      FUNCTION serviceOperation(request) {
        correlationId = request.correlationId OR generateId()
        
        // ENTRY: Log operation start with context
        LOG.INFO("Operation started", {correlationId, operation, userId, requestId})
        
        TRY {
          result = processRequest(request)
          // SUCCESS: Log completion with metrics
          LOG.INFO("Operation completed", {correlationId, outcome: "success", duration})
          RETURN result
        } CATCH (error) {
          // ERROR: Log failure (exclude sensitive data)
          LOG.ERROR("Operation failed", {correlationId, errorCode, errorType})
          THROW error
        }
      }

  key_requirements:
    - requirement: always_include_correlation_id
      description: "Every log entry must include correlationId for tracing"
      enforcement: mandatory

    - requirement: never_log_secrets
      description: "Never log passwords, tokens, keys, or sensitive data"
      enforcement: mandatory
      validation: automated_scanning

    - requirement: use_structured_logging
      description: "Use structured logging with consistent field names"
      enforcement: mandatory
      validation: linting_rules

    - requirement: consistent_field_names
      description: "Maintain consistent field naming across all services"
      enforcement: mandatory
      validation: schema_validation
```

## 8. [DATABASE_SECTION_TITLE] Usage

```yaml
database_guidelines:
  - guideline: Keys
    rule: [KEY_DEFINITION_REQUIREMENTS]
    enforcement: mandatory
    validation: schema_validation
    constraints:
      must:
        - define_clear_partition_key
        - define_appropriate_sort_key
        - follow_naming_conventions
      must_not:
        - use_ambiguous_key_patterns
        - create_hot_partitions

  - guideline: TTL
    rule: [TTL_REQUIREMENTS]
    enforcement: mandatory
    validation: code_review
    constraints:
      must:
        - set_ttl_for_transient_data
        - document_ttl_rationale
        - consider_data_lifecycle
      must_not:
        - use_ttl_without_justification
        - skip_cleanup_considerations

  - guideline: GSIs
    rule: [GSI_ADDITION_CRITERIA]
    enforcement: conditional
    validation: architecture_review
    criteria:
      required_when:
        - alternative_query_pattern_needed
        - performance_requirements_justify
        - cost_benefit_analysis_positive
      prohibited_when:
        - table_scan_sufficient
        - query_pattern_uncommon
        - maintenance_burden_outweighs_benefit
    constraints:
      must:
        - justify_gsi_necessity
        - project_only_required_attributes
        - monitor_gsi_performance
      must_not:
        - create_unnecessary_gsis
        - duplicate_primary_key_pattern

  - guideline: Capacity
    rule: [CAPACITY_CONFIGURATION]
    enforcement: mandatory
    validation: operations_review
    modes:
      on_demand:
        when: unpredictable_traffic_patterns
        benefits:
          - no_capacity_planning
          - automatic_scaling
        costs:
          - higher_per_request_cost
      provisioned:
        when: predictable_traffic_patterns
        benefits:
          - lower_cost_at_scale
          - predictable_performance
        costs:
          - requires_capacity_planning
          - manual_scaling_overhead
    constraints:
      must:
        - justify_capacity_mode
        - monitor_usage_patterns
        - optimize_for_cost
      must_not:
        - over_provision_capacity
        - ignore_cost_implications
```

## 9. API Design

### Security Headers & Response Standards

- [API_SECURITY_HEADERS_REQUIREMENT] <!-- Example: All responses must include security headers (centralized in responses.lib) -->
- [ERROR_RESPONSE_STANDARDS] <!-- Example: Error responses follow identity and access control standards; never expose internal stack traces externally -->
- [ERROR_LOCALIZATION_POLICY] <!-- Example: Error message localization not required; all error responses may be in English only -->

### API Security Controls

- [CORS_CONFIGURATION_REQUIREMENTS] <!-- Example: Strict CORS policies with explicit origin allowlists -->
- [CSRF_PROTECTION_MECHANISM] <!-- Example: CSRF tokens required for state-changing operations -->
- [REQUEST_SIZE_LIMITS] <!-- Example: Maximum request payload sizes to prevent DoS attacks -->
- [RATE_LIMITING_IMPLEMENTATION] <!-- Example: Rate limiting per client/IP with progressive penalties -->

### Authentication & Authorization API Standards

- [API_AUTHENTICATION_REQUIREMENTS] <!-- Example: All protected endpoints require valid bearer tokens -->
- [TOKEN_VALIDATION_STANDARDS] <!-- Example: JWT signature validation, expiration checks, and audience validation -->
- [SCOPE_BASED_ACCESS_CONTROL] <!-- Example: Fine-grained scope validation for API endpoints -->

### Data Validation & Sanitization

- [INPUT_PARAMETER_VALIDATION] <!-- Example: All API parameters validated against defined schemas -->
- [OUTPUT_DATA_SANITIZATION] <!-- Example: Response data sanitized to prevent information leakage -->
- [CONTENT_TYPE_VALIDATION] <!-- Example: Strict content-type validation and rejection of unexpected formats -->

### API Versioning & Changes

- [API_VERSIONING_STRATEGY] <!-- Example: Versioning strategy: breaking changes require /vN path prefix and migration plan in spec -->
- [BACKWARD_COMPATIBILITY_POLICY] <!-- Example: Deprecation timeline and migration support for API changes -->
- [SECURITY_PATCH_DEPLOYMENT] <!-- Example: Emergency security patch deployment procedures -->

### Traffic Management & Protection

- [API_THROTTLING_REQUIREMENTS] <!-- Example: IP throttling and rate-limiting managed at API gateway layer -->
- [DDoS_PROTECTION_MEASURES] <!-- Example: DDoS protection and traffic anomaly detection -->
- [GEOGRAPHIC_ACCESS_CONTROLS] <!-- Example: Geo-blocking or geo-restriction policies if applicable -->

### Identity & Access Control Standards

- [IDENTITY_COMPLIANCE_REQUIREMENT] <!-- Example: Must implement and remain consistent with industry-standard identity and access control protocols -->

## 9.1 [IDENTITY_DEVIATIONS_SECTION_TITLE] (Approved Security Enhancements)

[IDENTITY_DEVIATIONS_DESCRIPTION]:

### [DEVIATION_1_NAME] ([DEVIATION_1_STATUS])

**Deviation**: [DEVIATION_1_DESCRIPTION]

**[IDENTITY_STANDARD_NAME] Standard**: [IDENTITY_STANDARD_BASELINE]

**Rationale**:

- [RATIONALE_POINT_1]
- [RATIONALE_POINT_2]
- [RATIONALE_POINT_3]
- [RATIONALE_POINT_4]
- [RATIONALE_POINT_5]

**Implementation Requirements**:

- [IMPLEMENTATION_REQ_1]
- [IMPLEMENTATION_REQ_2]
- [IMPLEMENTATION_REQ_3]
- [IMPLEMENTATION_REQ_4]
- [IMPLEMENTATION_REQ_5]

**Specification**: [SPEC_REFERENCE]

**Date Approved**: [APPROVAL_DATE]

---

### Future Deviations

[FUTURE_DEVIATIONS_REQUIREMENTS]:

- [DEVIATION_REQUIREMENT_1]
- [DEVIATION_REQUIREMENT_2]
- [DEVIATION_REQUIREMENT_3]
- [DEVIATION_REQUIREMENT_4]
- [DEVIATION_REQUIREMENT_5]

## 10. Versioning & Feature Toggle Management

### API & Service Versioning Standards

- **[VERSION_NUMBERING_SCHEME]**: [VERSION_NUMBERING_DESCRIPTION] <!-- Example: Semantic versioning (major.minor.patch) for all public APIs -->
- **[VERSION_COMPATIBILITY_POLICY]**: [VERSION_COMPATIBILITY_DESCRIPTION] <!-- Example: Backward compatibility maintained within major version releases -->
- **[VERSION_DEPRECATION_TIMELINE]**: [VERSION_DEPRECATION_DESCRIPTION] <!-- Example: Minimum 12-month deprecation notice for breaking changes -->

#### Version Communication Standards

- [VERSION_HEADER_REQUIREMENTS] <!-- Example: API version must be communicated via Accept-Version header -->
- [VERSION_DOCUMENTATION_STANDARDS] <!-- Example: All version changes documented with migration guides -->
- [VERSION_SUNSET_NOTIFICATION] <!-- Example: Deprecated versions must include sunset warnings in response headers -->

### Feature Toggle Architecture

- **[FEATURE_TOGGLE_FRAMEWORK]**: [FEATURE_TOGGLE_FRAMEWORK_DESCRIPTION] <!-- Example: Centralized feature flag service with real-time configuration updates -->
- **[TOGGLE_NAMING_CONVENTIONS]**: [TOGGLE_NAMING_DESCRIPTION] <!-- Example: Feature flags follow hierarchical naming: service.feature.variant -->
- **[TOGGLE_LIFECYCLE_MANAGEMENT]**: [TOGGLE_LIFECYCLE_DESCRIPTION] <!-- Example: Feature flags have defined lifecycle: experimental → stable → deprecated → removed -->

#### Toggle Categories & Usage Patterns

1. **[RELEASE_TOGGLES]**

   - [RELEASE_TOGGLE_PURPOSE] <!-- Example: Enable/disable new features during deployment -->
   - [RELEASE_TOGGLE_DURATION] <!-- Example: Short-lived, removed once feature is stable -->
   - [RELEASE_TOGGLE_APPROVAL] <!-- Example: Require deployment approval for toggle state changes -->

2. **[EXPERIMENT_TOGGLES]**

   - [EXPERIMENT_TOGGLE_PURPOSE] <!-- Example: A/B testing and gradual feature rollouts -->
   - [EXPERIMENT_TOGGLE_ANALYTICS] <!-- Example: Must include analytics tracking for effectiveness measurement -->
   - [EXPERIMENT_TOGGLE_CRITERIA] <!-- Example: Clear success/failure criteria defined before activation -->

3. **[OPERATIONAL_TOGGLES]**

   - [OPERATIONAL_TOGGLE_PURPOSE] <!-- Example: Circuit breakers and performance optimization controls -->
   - [OPERATIONAL_TOGGLE_MONITORING] <!-- Example: Real-time monitoring and automated failover capabilities -->
   - [OPERATIONAL_TOGGLE_AUTHORITY] <!-- Example: Operations team authority for emergency toggle changes -->

4. **[PERMISSION_TOGGLES]**
   - [PERMISSION_TOGGLE_PURPOSE] <!-- Example: Role-based feature access and premium feature gates -->
   - [PERMISSION_TOGGLE_SECURITY] <!-- Example: Server-side enforcement with audit logging -->
   - [PERMISSION_TOGGLE_CONSISTENCY] <!-- Example: Consistent behavior across all application entry points -->

### Feature Flag Implementation Standards

- **[FLAG_EVALUATION_PERFORMANCE]**: [FLAG_EVALUATION_REQUIREMENTS] <!-- Example: Feature flag evaluation must complete within 5ms -->
- **[FLAG_FALLBACK_BEHAVIOR]**: [FLAG_FALLBACK_DESCRIPTION] <!-- Example: Default to safe/conservative behavior when flag service unavailable -->
- **[FLAG_CACHING_STRATEGY]**: [FLAG_CACHING_DESCRIPTION] <!-- Example: Local caching with TTL and graceful degradation -->

#### Security & Governance

- [FLAG_ACCESS_CONTROL] <!-- Example: Role-based permissions for flag creation, modification, and deletion -->
- [FLAG_AUDIT_REQUIREMENTS] <!-- Example: Complete audit trail of all flag state changes with user attribution -->
- [FLAG_ENVIRONMENT_ISOLATION] <!-- Example: Strict separation between development, staging, and production flag configurations -->
- [FLAG_VALIDATION_RULES] <!-- Example: Automated validation of flag configurations before deployment -->

### Rollout & Deployment Strategies

#### Gradual Rollout Patterns

- **[CANARY_DEPLOYMENT_STANDARDS]**: [CANARY_DEPLOYMENT_DESCRIPTION] <!-- Example: Gradual rollout starting with 1% traffic, doubling every 30 minutes -->
- **[BLUE_GREEN_TOGGLE_SUPPORT]**: [BLUE_GREEN_DESCRIPTION] <!-- Example: Feature toggles support instant traffic switching between environments -->
- **[PERCENTAGE_ROLLOUT_CONTROLS]**: [PERCENTAGE_ROLLOUT_DESCRIPTION] <!-- Example: Fine-grained percentage controls with user session consistency -->

#### Monitoring & Observability

- [TOGGLE_METRICS_COLLECTION] <!-- Example: Metrics on toggle evaluation frequency, performance, and error rates -->
- [TOGGLE_ALERT_THRESHOLDS] <!-- Example: Automated alerts for unusual toggle evaluation patterns -->
- [TOGGLE_DASHBOARD_REQUIREMENTS] <!-- Example: Real-time dashboards showing active toggles and their impact -->

### Configuration Management

- **[CONFIGURATION_VERSIONING]**: [CONFIG_VERSIONING_DESCRIPTION] <!-- Example: All configuration changes tracked with semantic versioning -->
- **[CONFIGURATION_VALIDATION]**: [CONFIG_VALIDATION_DESCRIPTION] <!-- Example: Schema validation and testing required before configuration deployment -->
- **[CONFIGURATION_ROLLBACK]**: [CONFIG_ROLLBACK_DESCRIPTION] <!-- Example: Instant rollback capability for configuration changes -->

#### Environment-Specific Controls

- [ENVIRONMENT_CONFIGURATION_ISOLATION] <!-- Example: Environment-specific configurations with inheritance hierarchy -->
- [CONFIGURATION_PROMOTION_PROCESS] <!-- Example: Controlled promotion of configurations through environments -->
- [CONFIGURATION_APPROVAL_WORKFLOW] <!-- Example: Approval workflows for production configuration changes -->

### Testing & Quality Assurance

- **[TOGGLE_TESTING_REQUIREMENTS]**: [TOGGLE_TESTING_DESCRIPTION] <!-- Example: All code paths (toggle on/off) must have test coverage -->
- **[INTEGRATION_TEST_COVERAGE]**: [INTEGRATION_TEST_DESCRIPTION] <!-- Example: Integration tests validate behavior with different toggle combinations -->
- **[PERFORMANCE_TEST_INCLUSION]**: [PERFORMANCE_TEST_DESCRIPTION] <!-- Example: Performance tests include feature toggle evaluation overhead -->

#### Toggle Debt Management

- [TOGGLE_CLEANUP_POLICY] <!-- Example: Regular audits and cleanup of unused or expired feature flags -->
- [TOGGLE_TECHNICAL_DEBT_TRACKING] <!-- Example: Technical debt tracking for long-lived feature toggles -->
- [TOGGLE_RETIREMENT_PROCESS] <!-- Example: Formal process for safely removing feature toggles from codebase -->

### Documentation & Communication

- [TOGGLE_DOCUMENTATION_STANDARDS] <!-- Example: All feature toggles documented with purpose, dependencies, and cleanup timeline -->
- [STAKEHOLDER_COMMUNICATION] <!-- Example: Regular communication to stakeholders about active experiments and rollouts -->
- [TOGGLE_DISCOVERY_TOOLS] <!-- Example: Tools for discovering and understanding current toggle state across services -->

## 11. Upstream & Downstream Dependencies

### Dependency Classification & Management

- **[UPSTREAM_DEPENDENCY_DEFINITION]**: [UPSTREAM_DEPENDENCY_DESCRIPTION] <!-- Example: External services, APIs, and data sources that this project depends on -->
- **[DOWNSTREAM_DEPENDENCY_DEFINITION]**: [DOWNSTREAM_DEPENDENCY_DESCRIPTION] <!-- Example: Services, applications, and systems that depend on this project -->
- **[DEPENDENCY_MAPPING_REQUIREMENTS]**: [DEPENDENCY_MAPPING_DESCRIPTION] <!-- Example: Comprehensive dependency mapping maintained in project documentation -->

#### Dependency Categories

| Category Type              | Scope                       | Management Policy            |
| -------------------------- | --------------------------- | ---------------------------- |
| [CRITICAL_UPSTREAM_DEPS]   | [CRITICAL_UPSTREAM_SCOPE]   | [CRITICAL_UPSTREAM_POLICY]   |
| [STANDARD_UPSTREAM_DEPS]   | [STANDARD_UPSTREAM_SCOPE]   | [STANDARD_UPSTREAM_POLICY]   |
| [OPTIONAL_UPSTREAM_DEPS]   | [OPTIONAL_UPSTREAM_SCOPE]   | [OPTIONAL_UPSTREAM_POLICY]   |
| [DIRECT_DOWNSTREAM_DEPS]   | [DIRECT_DOWNSTREAM_SCOPE]   | [DIRECT_DOWNSTREAM_POLICY]   |
| [INDIRECT_DOWNSTREAM_DEPS] | [INDIRECT_DOWNSTREAM_SCOPE] | [INDIRECT_DOWNSTREAM_POLICY] |

### Upstream Dependency Standards

#### Service Level Agreements (SLA) Management

- **[SLA_MONITORING_REQUIREMENTS]**: [SLA_MONITORING_DESCRIPTION] <!-- Example: Monitor upstream SLA compliance and establish alerts for degraded performance -->
- **[SLA_DOCUMENTATION_STANDARDS]**: [SLA_DOCUMENTATION_DESCRIPTION] <!-- Example: Document expected SLA for each upstream dependency -->
- **[SLA_FALLBACK_STRATEGY]**: [SLA_FALLBACK_DESCRIPTION] <!-- Example: Define fallback strategies when upstream services fail to meet SLA -->

#### Circuit Breaker & Resilience Patterns

- **[CIRCUIT_BREAKER_IMPLEMENTATION]**: [CIRCUIT_BREAKER_DESCRIPTION] <!-- Example: Implement circuit breaker pattern for all critical upstream dependencies -->
- **[RETRY_STRATEGY_STANDARDS]**: [RETRY_STRATEGY_DESCRIPTION] <!-- Example: Exponential backoff with jitter for upstream service failures -->
- **[TIMEOUT_CONFIGURATION]**: [TIMEOUT_CONFIGURATION_DESCRIPTION] <!-- Example: Configurable timeouts for all upstream service calls -->

#### Dependency Health Monitoring

- [DEPENDENCY_HEALTH_CHECKS] <!-- Example: Regular health checks for all upstream dependencies with status reporting -->
- [DEPENDENCY_PERFORMANCE_METRICS] <!-- Example: Track response times, error rates, and availability metrics -->
- [DEPENDENCY_ALERTING_THRESHOLDS] <!-- Example: Automated alerting when dependency performance degrades -->

### Downstream Dependency Management

#### Interface Stability & Versioning

- **[API_CONTRACT_STABILITY]**: [API_CONTRACT_DESCRIPTION] <!-- Example: Maintain backward compatibility for all public APIs consumed by downstream services -->
- **[BREAKING_CHANGE_NOTIFICATION]**: [BREAKING_CHANGE_DESCRIPTION] <!-- Example: Minimum 6-month advance notice for breaking changes to downstream consumers -->
- **[VERSION_DEPRECATION_POLICY]**: [VERSION_DEPRECATION_DESCRIPTION] <!-- Example: Deprecated API versions supported for minimum 12 months -->

#### Consumer Impact Assessment

- [DOWNSTREAM_IMPACT_ANALYSIS] <!-- Example: Assess downstream impact before making changes to public interfaces -->
- [CONSUMER_TESTING_COORDINATION] <!-- Example: Coordinate testing with downstream consumers during major updates -->
- [ROLLBACK_COMPATIBILITY] <!-- Example: Ensure rollback procedures don't break downstream dependencies -->

#### Communication & Coordination

- **[CHANGE_COMMUNICATION_REQUIREMENTS]**: [CHANGE_COMMUNICATION_DESCRIPTION] <!-- Example: Proactive communication to downstream consumers about planned changes -->
- **[DEPRECATION_NOTICE_STANDARDS]**: [DEPRECATION_NOTICE_DESCRIPTION] <!-- Example: Formal deprecation notices with migration timelines and alternatives -->
- **[MAINTENANCE_WINDOW_COORDINATION]**: [MAINTENANCE_WINDOW_DESCRIPTION] <!-- Example: Coordinate maintenance windows to minimize downstream impact -->

### Dependency Security & Compliance

#### Security Assessment Requirements

- **[DEPENDENCY_SECURITY_SCANNING]**: [DEPENDENCY_SECURITY_DESCRIPTION] <!-- Example: Regular security scanning of all upstream dependencies -->
- **[VULNERABILITY_MANAGEMENT_POLICY]**: [VULNERABILITY_MANAGEMENT_DESCRIPTION] <!-- Example: Immediate assessment and remediation of security vulnerabilities in dependencies -->
- **[SECURITY_BASELINE_VALIDATION]**: [SECURITY_BASELINE_DESCRIPTION] <!-- Example: Validate security baseline compliance for all critical dependencies -->

#### Compliance & Governance

- [DEPENDENCY_LICENSING_COMPLIANCE] <!-- Example: Ensure all dependencies comply with project licensing requirements -->
- [DATA_FLOW_GOVERNANCE] <!-- Example: Document and govern data flows between upstream and downstream systems -->
- [AUDIT_TRAIL_REQUIREMENTS] <!-- Example: Maintain audit trails for dependency interactions and changes -->

### Dependency Testing & Validation

#### Integration Testing Standards

- **[DEPENDENCY_INTEGRATION_TESTS]**: [DEPENDENCY_INTEGRATION_DESCRIPTION] <!-- Example: Comprehensive integration tests for all critical upstream dependencies -->
- **[CONTRACT_TESTING_REQUIREMENTS]**: [CONTRACT_TESTING_DESCRIPTION] <!-- Example: Consumer-driven contract testing for downstream API consumers -->
- **[DEPENDENCY_MOCK_STRATEGY]**: [DEPENDENCY_MOCK_DESCRIPTION] <!-- Example: Mock upstream dependencies in unit tests while maintaining realistic behavior -->

#### Continuous Validation

- [DEPENDENCY_CONTINUOUS_TESTING] <!-- Example: Automated testing pipelines validate dependency interactions -->
- [COMPATIBILITY_REGRESSION_TESTING] <!-- Example: Regression tests ensure changes don't break dependency contracts -->
- [PERFORMANCE_IMPACT_VALIDATION] <!-- Example: Performance testing includes dependency interaction overhead -->

### Emergency Response & Incident Management

#### Dependency Failure Response

- **[UPSTREAM_FAILURE_PROCEDURES]**: [UPSTREAM_FAILURE_DESCRIPTION] <!-- Example: Documented procedures for upstream dependency failures -->
- **[DOWNSTREAM_IMPACT_MITIGATION]**: [DOWNSTREAM_IMPACT_DESCRIPTION] <!-- Example: Strategies to minimize impact on downstream consumers during incidents -->
- **[COMMUNICATION_ESCALATION_PROCESS]**: [COMMUNICATION_ESCALATION_DESCRIPTION] <!-- Example: Clear escalation process for dependency-related incidents -->

#### Business Continuity Planning

- [CRITICAL_DEPENDENCY_ALTERNATIVES] <!-- Example: Identify alternatives for critical upstream dependencies -->
- [GRACEFUL_DEGRADATION_STRATEGY] <!-- Example: Define graceful degradation when dependencies are unavailable -->
- [DISASTER_RECOVERY_COORDINATION] <!-- Example: Coordinate disaster recovery procedures with dependent systems -->

### Documentation & Knowledge Management

- **[DEPENDENCY_DOCUMENTATION_STANDARDS]**: [DEPENDENCY_DOCUMENTATION_DESCRIPTION] <!-- Example: Comprehensive documentation of all dependency relationships and requirements -->
- **[ARCHITECTURE_DECISION_RECORDS]**: [ARCHITECTURE_DECISION_DESCRIPTION] <!-- Example: ADRs for significant dependency additions or changes -->
- **[RUNBOOK_MAINTENANCE]**: [RUNBOOK_MAINTENANCE_DESCRIPTION] <!-- Example: Maintain current runbooks for dependency-related operational procedures -->

## 12. Observability

```yaml
observability_standards:
  logs:
    - aspect: Structure
      requirement: [LOGS_STRUCTURE_REQUIREMENT]
      enforcement: mandatory
      validation: automated_linting
      constraints:
        must:
          - use_structured_json_format
          - include_mandatory_fields
          - be_machine_parseable
        must_not:
          - use_unstructured_text
          - skip_correlation_ids

    - aspect: Environment
      requirement: [LOGS_ENVIRONMENT_REQUIREMENTS]
      enforcement: mandatory
      validation: deployment_check
      constraints:
        must:
          - configure_per_environment
          - respect_log_levels
          - route_to_appropriate_destination
        must_not:
          - log_sensitive_data_production
          - skip_required_fields

  metrics:
    requirement: [METRICS_INTEGRATION_PLAN]
    enforcement: mandatory
    validation: monitoring_review

    types:
      - type: Business Metrics
        examples:
          - user_signups
          - transactions_completed
          - revenue_generated
        collection_frequency: real_time

      - type: System Metrics
        examples:
          - request_latency
          - error_rates
          - throughput
        collection_frequency: real_time

      - type: Performance Metrics
        examples:
          - database_query_time
          - external_api_latency
          - memory_usage
        collection_frequency: continuous

    constraints:
      must:
        - emit_key_metrics
        - use_consistent_naming
        - include_relevant_tags
        - set_appropriate_thresholds
      must_not:
        - skip_critical_metrics
        - use_inconsistent_units
        - emit_high_cardinality_metrics

  tracing:
    policy: [TRACING_POLICY]
    enforcement: mandatory
    validation: observability_review

    requirements:
      - requirement: distributed_tracing
        description: "Implement distributed tracing across all services"
        implementation: trace_context_propagation

      - requirement: span_creation
        description: "Create spans for significant operations"
        granularity: function_level

      - requirement: trace_sampling
        description: "Configure appropriate sampling rates"
        sampling_strategy: adaptive_sampling

    constraints:
      must:
        - propagate_trace_context
        - create_meaningful_spans
        - include_relevant_attributes
        - configure_sampling
      must_not:
        - break_trace_context
        - create_excessive_spans
        - skip_error_tracking

    best_practices:
      - use_semantic_conventions
      - enrich_spans_with_context
      - monitor_trace_completeness
      - analyze_trace_performance
```

## 13. Security & Privacy

### Core Security Principles

- [ACCESS_CONTROL_PRINCIPLE_REQUIREMENT] <!-- Example: Principle of least privilege for access control: each service role scoped to only required resources -->
- [SECRET_STORAGE_POLICY] <!-- Example: No plaintext secret storage in code—environment variables only for non-sensitive configuration; secrets must originate from secure secret management service -->
- [SECURITY_SAFEGUARDS_REQUIREMENTS] <!-- Example: CSRF / replay safeguards enforced for code exchange & token issuance -->

### Authentication & Authorization

- [AUTH_MECHANISM_REQUIREMENTS] <!-- Example: Multi-factor authentication required for administrative access -->
- [SESSION_MANAGEMENT_POLICY] <!-- Example: Token expiration and refresh token rotation policies -->
- [ROLE_BASED_ACCESS_CONTROL] <!-- Example: RBAC implementation with clearly defined permission boundaries -->

### Data Protection

- [DATA_ENCRYPTION_REQUIREMENTS] <!-- Example: All sensitive data must be encrypted at rest and in transit -->
- [PII_HANDLING_POLICY] <!-- Example: Personally identifiable information handling and retention policies -->
- [DATA_CLASSIFICATION_STANDARDS] <!-- Example: Data classification levels (public, internal, confidential, restricted) -->

### Input Validation & Sanitization

- [INPUT_VALIDATION_SECURITY] <!-- Example: All external inputs must be sanitized & validated before persistence or cryptographic use -->
- [SQL_INJECTION_PREVENTION] <!-- Example: Parameterized queries required; no dynamic SQL construction -->
- [XSS_PREVENTION_MEASURES] <!-- Example: Output encoding and CSP headers for web interfaces -->

### Logging & Monitoring Security

- [SECURITY_LOGGING_REQUIREMENTS] <!-- Example: All authentication attempts, authorization failures, and privileged operations must be logged -->
- [LOG_RETENTION_POLICY] <!-- Example: Security logs must be retained for minimum [X] months -->
- [ANOMALY_DETECTION_REQUIREMENTS] <!-- Example: Automated monitoring for unusual access patterns and security events -->

### Secret Management

- [SECRET_HANDLING_RULES] <!-- Example: Never log or persist token, password, secret, key, PKCE verifier -->
- [SECRET_ROTATION_POLICY] <!-- Example: Automated secret rotation schedules and procedures -->
- [ENVIRONMENT_SEPARATION] <!-- Example: Strict separation of secrets between development, staging, and production environments -->

### Network Security

- [NETWORK_SEGMENTATION_REQUIREMENTS] <!-- Example: Virtual network configuration and subnet isolation policies -->
- [FIREWALL_RULES_POLICY] <!-- Example: Default deny rules with explicit allow exceptions documented in specs -->
- [TLS_CONFIGURATION_STANDARDS] <!-- Example: Minimum TLS 1.3 for all external communications -->

### Vulnerability Management

- [DEPENDENCY_SCANNING_REQUIREMENTS] <!-- Example: Automated scanning of dependencies for known vulnerabilities -->
- [SECURITY_UPDATE_POLICY] <!-- Example: Critical security updates must be applied within [X] hours/days -->
- [PENETRATION_TESTING_SCHEDULE] <!-- Example: Regular security assessments and penetration testing requirements -->

### Incident Response

- [SECURITY_INCIDENT_PROCEDURES] <!-- Example: Defined procedures for security incident detection, response, and recovery -->
- [BREACH_NOTIFICATION_REQUIREMENTS] <!-- Example: Timeline and procedures for security breach notifications -->
- [FORENSIC_CAPABILITIES] <!-- Example: Audit trail and forensic analysis capabilities -->

### Compliance & Governance

- [REGULATORY_COMPLIANCE_REQUIREMENTS] <!-- Example: GDPR, SOC 2, or other applicable compliance frameworks -->
- [SECURITY_REVIEW_PROCESS] <!-- Example: Security review requirements for code changes and new features -->
- [THIRD_PARTY_SECURITY_ASSESSMENT] <!-- Example: Security assessment requirements for third-party integrations -->

## 14. Change Control

- [DEVIATION_APPROVAL_PROCESS]
- [CONSTITUTION_UPDATE_REQUIREMENTS]

## 15. Upgrade Path & Migration Standards

### Version Compatibility & Migration Policy

- [VERSION_COMPATIBILITY_REQUIREMENTS] <!-- Example: All upgrades must maintain backward compatibility for at least one major version -->
- [BREAKING_CHANGE_POLICY] <!-- Example: Breaking changes require 6-month advance notice with minimum 12-month deprecation period -->
- [MIGRATION_DOCUMENTATION_REQUIREMENTS] <!-- Example: All version upgrades must include comprehensive migration guides -->

### Technology Stack Upgrades

- **[DEPENDENCY_UPGRADE_POLICY]**: [DEPENDENCY_UPGRADE_DESCRIPTION] <!-- Example: Security patches applied immediately; feature upgrades follow quarterly review cycle -->
- **[RUNTIME_UPGRADE_REQUIREMENTS]**: [RUNTIME_UPGRADE_REQUIREMENTS_DESCRIPTION] <!-- Example: Runtime version upgrades require performance benchmarking and rollback plan -->
- **[DATABASE_MIGRATION_STANDARDS]**: [DATABASE_MIGRATION_STANDARDS_DESCRIPTION] <!-- Example: All database schema changes must be reversible and tested in staging environment -->

### Constitution Evolution Framework

- **[CONSTITUTION_VERSIONING]**: [CONSTITUTION_VERSIONING_DESCRIPTION] <!-- Example: Constitution follows semantic versioning (major.minor.patch) -->
- **[AMENDMENT_PROCESS]**: [AMENDMENT_PROCESS_DESCRIPTION] <!-- Example: Major amendments require RFC process and core maintainer approval -->
- **[DEPRECATION_TIMELINE]**: [DEPRECATION_TIMELINE_DESCRIPTION] <!-- Example: Deprecated practices have 12-month sunset period with migration support -->

### Upgrade Testing Requirements

- **[PRE_UPGRADE_VALIDATION]** MUST include:
  - [COMPATIBILITY_TEST_REQUIREMENTS] <!-- Example: Compatibility tests across supported client versions -->
  - [PERFORMANCE_REGRESSION_TESTING] <!-- Example: Performance benchmarks to detect regressions -->
  - [SECURITY_IMPACT_ASSESSMENT] <!-- Example: Security review of upgrade changes -->
  - [ROLLBACK_PROCEDURE_VALIDATION] <!-- Example: Tested rollback procedures for failed upgrades -->

### Migration Support Standards

- [AUTOMATED_MIGRATION_REQUIREMENTS] <!-- Example: Provide automated migration scripts where possible -->
- [MANUAL_MIGRATION_DOCUMENTATION] <!-- Example: Step-by-step manual migration instructions for complex changes -->
- [MIGRATION_VALIDATION_TOOLS] <!-- Example: Tools to verify successful migration completion -->
- [SUPPORT_CHANNEL_AVAILABILITY] <!-- Example: Dedicated support channels during major migration periods -->

### Legacy System Integration

- [LEGACY_SUPPORT_POLICY] <!-- Example: Legacy API versions supported for minimum 18 months post-deprecation -->
- [BRIDGE_PATTERN_REQUIREMENTS] <!-- Example: Adapter patterns required for legacy system integration -->
- [GRADUAL_MIGRATION_STRATEGY] <!-- Example: Phased migration approach for large-scale system changes -->

### Emergency Upgrade Procedures

- [CRITICAL_SECURITY_UPGRADES] <!-- Example: Critical security patches can bypass normal approval process with post-implementation review -->
- [HOTFIX_DEPLOYMENT_POLICY] <!-- Example: Hotfix procedures for urgent production issues -->
- [EMERGENCY_ROLLBACK_AUTHORITY] <!-- Example: Designated personnel authorized for emergency rollbacks -->

### Upgrade Communication Standards

- [ADVANCE_NOTIFICATION_REQUIREMENTS] <!-- Example: Minimum 30-day advance notice for major upgrades -->
- [STAKEHOLDER_COMMUNICATION_PLAN] <!-- Example: Communication plan including all affected stakeholders -->
- [UPGRADE_STATUS_REPORTING] <!-- Example: Real-time status reporting during upgrade execution -->
- [POST_UPGRADE_REVIEW_PROCESS] <!-- Example: Mandatory post-upgrade review and lessons learned documentation -->

## 16. Analysis and Recommendations

### Build Artifact Exclusion

- [BUILD_ARTIFACT_ANALYSIS_POLICY]
- [BUILD_DIRECTORY_EXAMPLES]
- [ANALYSIS_FOCUS_AREAS]
- [BUILD_ISSUE_REPORTING_POLICY]

### Source vs Generated Content

- **[SOURCE_OF_TRUTH_TITLE]**: [SOURCE_OF_TRUTH_DESCRIPTION]
- **[GENERATED_CONTENT_TITLE]**: [GENERATED_CONTENT_DESCRIPTION]
- **[PROBLEM_RESOLUTION_TITLE]**: [PROBLEM_RESOLUTION_APPROACH]

## 17. Documentation Standards

- [DOCUMENTATION_DIAGRAM_REQUIREMENTS]

## 18. Glossary

| Term              | Meaning                                                                                                                  |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------ |
| [TERM_1]          | [TERM_1_DEFINITION] <!-- Example: Spec - Functional requirements artifact (spec.md) -->                                  |
| [TERM_2]          | [TERM_2_DEFINITION] <!-- Example: Plan - Technical design & sequencing (plan.md) -->                                     |
| [TERM_3]          | [TERM_3_DEFINITION] <!-- Example: Tasks - Execution breakdown linked to requirements -->                                 |
| [SECURITY_TERM_1] | [SECURITY_TERM_1_DEFINITION] <!-- Example: CSRF - Cross-Site Request Forgery protection mechanism -->                    |
| [SECURITY_TERM_2] | [SECURITY_TERM_2_DEFINITION] <!-- Example: PKCE - Proof Key for Code Exchange identity verification extension -->        |
| [SECURITY_TERM_3] | [SECURITY_TERM_3_DEFINITION] <!-- Example: Zero Trust - Security model requiring verification of all network traffic --> |
| [SECURITY_TERM_4] | [SECURITY_TERM_4_DEFINITION] <!-- Example: Access Control - Identity and Access Management principles and policies -->   |

## 19. Enforcement

[ENFORCEMENT_POLICY]:

- [ENFORCEMENT_CRITERIA_1]
- [ENFORCEMENT_CRITERIA_2]
- [ENFORCEMENT_CRITERIA_3]

## 20. Roadmap (Non-Binding Future Enhancements)

- [ENHANCEMENT_1]
- [ENHANCEMENT_2]

---

**Constitution Version**: [FINAL_VERSION]  
**Last Updated**: [FINAL_UPDATE_DATE]  
**Change Summary**: [FINAL_CHANGE_SUMMARY]
