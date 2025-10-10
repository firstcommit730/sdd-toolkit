# Constitution Observability Standards

<!--
Section: observability
Tokens: ~3200
Priority: high
Applies to: backend, infrastructure
Dependencies: [core]
Version: 1.0.0
-->

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
