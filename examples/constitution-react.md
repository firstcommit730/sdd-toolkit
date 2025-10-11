# Development Constitution

**Version**: 1.0.0  
**Ratification Date**: 2025-10-11  
**Last Amended**: 2025-10-11

---

<!-- Section: architecture -->

## Architectural Patterns

### CRUD Pattern

**Routes**:

- POST: Create new resource
- GET: Retrieve resource(s)
- PATCH: Update existing resource
- DELETE: Remove resource

**Benefits**: Consistent API design, predictable behavior, clear separation of concerns, standard HTTP semantics, easy testing

### Security Requirements

**Defense in Depth**: Multiple security layers with input validation, authentication, authorization, and output sanitization
**Zero Trust**: Verify all requests, validate all inputs, authenticate all users, authorize all actions
**Monitoring**: Log all security events, detect anomalies, track access patterns, monitor for threats

---

<!-- Section: core -->

## Coding Standards

| Area           | Standard                                                     | Enforcement | Validation          |
| -------------- | ------------------------------------------------------------ | ----------- | ------------------- |
| Language       | ES2022+ with TypeScript 5.0+; strict mode enabled            | Mandatory   | Automated linting   |
| Type Safety    | Strict TypeScript; no `any` types; full type coverage        | Mandatory   | Compile-time        |
| Async Patterns | async/await only; Promises for chaining; no callback pattern | Mandatory   | Code review         |
| Modularity     | ES modules; single responsibility; dependency injection      | Mandatory   | Architecture review |
| Error Handling | try/catch with structured logging; never silent failures     | Mandatory   | Automated linting   |
| Logging        | Winston library; structured JSON format with correlation IDs | Mandatory   | Automated scanning  |
| Secrets        | Never in code/logs/env; use secrets management service       | Mandatory   | Secret scanning     |
| Validation     | Zod schemas for all inputs; sanitize user data               | Mandatory   | Security review     |
| DTOs/Models    | PascalCase classes; readonly properties; validation methods  | Mandatory   | Code review         |

### Error Handling Example

```
try {
  const result = await operation();
  return result;
} catch (error) {
  logger.error('Operation failed', { correlationId, error });
  throw error;
}
```

### Core Requirements

- **Logging**: Structured format, correlation ID, no secrets, consistent field names
- **Secrets**: No plaintext in code/env/logs/errors
- **Validation**: Validate/sanitize all external inputs, type & boundary checking
- **DTOs**: Clear naming, type annotations, immutability preferred, validation methods

---

<!-- Section: testing -->

## Testing Standards

### Coverage

- **Requirements**: Minimum 90% line coverage for all production code (Mandatory, validated via automated CI)
- **Threshold**: Builds fail below 90%; target 95%+ for critical paths
- **Exclusions**: Test files, type definitions, configuration files, generated code

### Test Organization

| Type        | Location                    | Directory                  | Suffix                 | Constraints                                                                                                   |
| ----------- | --------------------------- | -------------------------- | ---------------------- | ------------------------------------------------------------------------------------------------------------- |
| Unit        | Colocated with source       | Same dir as implementation | `.test.ts`             | Must: Colocate with source, follow naming. Must Not: Place in separate directories                            |
| Contract    | Dedicated test directory    | `tests/contract/`          | `.contract.test.ts`    | API endpoint validation; schema compliance; integration contracts                                             |
| Integration | Exclusive directory         | `tests/integration/`       | `.integration.test.ts` | Must: Dedicated dir, test real integrations, setup/teardown. Must Not: Mix with unit tests, excessive mocking |
| Performance | Optional for critical paths | `tests/performance/`       | -                      | Load testing for APIs; benchmarking for algorithms; skip for non-critical features                            |

**Examples**: Source: `src/services/user.ts` → Test: `src/services/user.test.ts` | Source: `src/api/auth.ts` → Test: `tests/contract/auth.contract.test.ts`

**Security Testing**: Automated security tests for all endpoints | Location: `tests/security/`, Suffix: `.security.test.ts`

| Category         | Requirements                                 | Examples                                   |
| ---------------- | -------------------------------------------- | ------------------------------------------ |
| Authentication   | Test all auth flows; validate token handling | Bypass, invalid tokens, session validation |
| Authorization    | Test permission boundaries; role validation  | Privilege escalation, role boundaries      |
| Input Validation | Test all input vectors; sanitization         | SQL injection, XSS, command injection      |
| Cryptographic    | Test encryption/decryption; key rotation     | Encryption, key management, secure random  |

**Integration**: Test real service dependencies; validate complete workflows | Logging: All integration tests must log operations with correlation IDs | Mocking: Mock only external services, not internal components | Must: Real service interactions, logging, error scenarios | Must Not: Mock critical integrations, skip cleanup

**Mocking**: Unit: Mock all external dependencies; keep business logic pure | Implementation: Use Jest mocks; type-safe mocks with strict verification | Practices: Consistent framework, mock external deps, verify interactions, realistic behavior

---

<!-- Section: observability -->

## Logging Standards

**Entry**: Log function entry with operation name | Clear, actionable messages | Include all context parameters | Structured JSON format (Mandatory)  
**Must**: Log at entry, include correlationId, structured format, concise | **Must Not**: Log sensitive data, string concatenation, exceed size

**Test Env**: Console output in structured format | Maintain production log format consistency | Prevent cloud logging in test environments  
**Must**: Maintain production format, console output, parseable | **Must Not**: Cloud services, skip critical fields

### Required Fields

| Field         | Type   | Description                              | Validation            | When                   |
| ------------- | ------ | ---------------------------------------- | --------------------- | ---------------------- |
| correlationId | string | Unique request trace ID                  | UUID or similar       | Always                 |
| timestamp     | string | ISO 8601 timestamp                       | Valid ISO8601         | Always                 |
| level         | enum   | Log level (INFO/DEBUG/WARN/ERROR)        | One of allowed values | Always                 |
| service       | string | Service/component name                   | Non-empty string      | Always                 |
| message       | string | Human-readable log message               | Non-empty descriptive | Always                 |
| operation     | string | Function/method being executed           | -                     | When available         |
| userId        | string | User identifier                          | -                     | User context exists    |
| sessionId     | string | Session identifier                       | -                     | Session context exists |
| requestId     | string | HTTP/API request ID                      | -                     | HTTP request context   |
| duration      | number | Operation time (ms)                      | -                     | Operation complete     |
| outcome       | enum   | Result (success/failure/timeout/partial) | -                     | Operation complete     |
| errorCode     | string | Application-specific error code          | -                     | level == ERROR         |
| errorMessage  | string | Error description                        | -                     | level == ERROR         |
| errorType     | string | Error category/classification            | -                     | level == ERROR         |
| stackTrace    | string | Technical stack trace (dev only)         | -                     | level == ERROR         |

### Implementation Examples

```
// Entry: LOG.INFO("userAuthentication started", {correlationId, userId, requestId})
// Success: LOG.INFO("userAuthentication completed", {correlationId, outcome: "success", duration})
// Error: LOG.ERROR("userAuthentication failed", {correlationId, errorCode, errorType})

FUNCTION serviceOperation(request) {
  correlationId = request.correlationId OR generateId()
  LOG.INFO("Operation started", {correlationId, operation, userId, requestId})
  TRY {
    result = processRequest(request)
    LOG.INFO("Operation completed", {correlationId, outcome: "success", duration})
    RETURN result
  } CATCH (error) {
    LOG.ERROR("Operation failed", {correlationId, errorCode, errorType})
    THROW error
  }
}
```

**Requirements**: Always include correlationId | Never log secrets (automated scanning) | Structured logging (linting) | Consistent naming (schema validation)

---

<!-- Section: architecture -->

## Database Guidelines

| Aspect   | Rule                                                                  | Must                                                  | Must Not                                |
| -------- | --------------------------------------------------------------------- | ----------------------------------------------------- | --------------------------------------- |
| Keys     | Use UUID primary keys; meaningful field names (schema validation)     | Clear partition/sort keys, naming conventions         | Ambiguous patterns, hot partitions      |
| TTL      | Set TTL for session and cache data (code review)                      | Set for transient data, document rationale, lifecycle | Without justification, skip cleanup     |
| GSIs     | Justify each index with performance metrics (architecture review)     | Justify necessity, project required attrs, monitor    | Unnecessary GSIs, duplicate primary key |
| Capacity | Use on-demand for dev; provisioned for production (operations review) | Justify mode, monitor usage, optimize cost            | Over-provision, ignore costs            |

**GSIs When**: Required: Alt query pattern, performance justified, positive cost-benefit | Prohibited: Table scan sufficient, uncommon query, maintenance > benefit  
**Capacity Modes**: On-Demand: Unpredictable traffic, no planning, auto-scale, higher cost | Provisioned: Predictable traffic, lower cost at scale, requires planning

---

<!-- Section: architecture -->

## API Standards

| Category       | Standards                                                                                                       |
| -------------- | --------------------------------------------------------------------------------------------------------------- |
| Security       | Security headers (HSTS, CSP, X-Frame-Options), Structured error responses, No user data in error messages       |
| Protection     | CORS whitelist origins only, CSRF tokens for state changes, Max 10MB request size, 100 req/min rate limiting    |
| Authentication | JWT tokens with RS256, Token expiry validation, Scope-based resource access                                     |
| Validation     | Zod schema validation for all inputs, Sanitize HTML output, Validate Content-Type headers                       |
| Versioning     | Semantic versioning in URL path, 12-month backward compatibility, Security patches within 24h                   |
| Resilience     | Exponential backoff rate limiting, DDoS protection via reverse proxy, Geographic blocking for high-risk regions |

---

<!-- Section: security -->

## Security Standards

| Category             | Standards                                                                                               |
| -------------------- | ------------------------------------------------------------------------------------------------------- |
| Access Control       | Principle of least privilege, Encrypted secrets in AWS Secrets Manager, Multi-layer security validation |
| Auth & Authorization | JWT with refresh tokens, 15-minute session timeout, Role-based permissions with scopes                  |
| Data Protection      | AES-256 encryption at rest, PII masking in logs, Data classified as Public/Internal/Confidential        |
| Input Security       | Parameterized queries only, HTML sanitization, XSS prevention via CSP headers                           |
| Monitoring           | Security events logged with correlation IDs, 90-day log retention, Anomaly detection with alerting      |
| Secrets Management   | No secrets in code or environment variables, 90-day rotation policy, Environment separation enforced    |
| Network Security     | TLS 1.3 minimum, Firewall whitelist approach, Network segmentation between environments                 |
| Vulnerability Mgmt   | Daily dependency scanning, Critical patches within 24h, Quarterly penetration testing                   |
| Incident Response    | 1-hour incident response SLA, Data breach notification within 72h, Forensic logging capabilities        |
| Compliance           | GDPR compliance for user data, Security code review required, Third-party security assessments          |
| Exceptions           | Lead architect approval required, Constitution updates via PR process                                   |

```

```
