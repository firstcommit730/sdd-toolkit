# Constitution Testing Standards

<!--
Section: testing
Tokens: ~2800
Priority: critical
Applies to: all projects
Dependencies: [core]
Version: 1.0.0
-->

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
