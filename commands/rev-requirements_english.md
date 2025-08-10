# rev-requirements

## Objective

To reverse-generate a requirements definition document from an existing codebase. To analyze implemented features and extract/document functional requirements, non-functional requirements, and user stories using EARS (Easy Approach to Requirements Syntax).

## Prerequisites

- The codebase to be analyzed exists.
- The `docs/reverse/` directory exists (if not, create it).
- If possible, `rev-tasks.md` and `rev-design.md` have been executed beforehand.

## Execution Content

1.  **Identify and Analyze Features**
    -   Extract screen features from UI components.
    -   Identify business features from API endpoints.
    -   Estimate data requirements from the database schema.
    -   Confirm expected behavior from test code.

2.  **Reverse-calculate User Stories**
    -   Estimate the user's intent from the implemented features.
    -   Identify WHO (user type).
    -   Extract WHAT (what they want to achieve).
    -   Estimate WHY (the value gained).

3.  **Classify Requirements using EARS Notation**
    -   **Ubiquitous (SHALL)**: Extracted from standard feature implementations.
    -   **Event-Driven (WHEN/IF-THEN)**: Extracted from conditional branch logic.
    -   **State-Driven (WHERE)**: Extracted from state management implementation.
    -   **Optional (MAY)**: Extracted from configurable features.
    -   **Unwanted (MUST)**: Extracted from validation/restriction logic.

4.  **Estimate Non-functional Requirements**
    -   Performance requirements: Estimated from implemented caching, optimization.
    -   Security requirements: Extracted from authentication/authorization implementation.
    -   Usability requirements: Extracted from UI/UX implementation.
    -   Operational requirements: Extracted from logging, monitoring implementation.

5.  **Identify Edge Cases**
    -   Extract sad path requirements from error handling implementation.
    -   Extract boundary value requirements from validation implementation.
    -   Extract expected error cases from test cases.

6.  **Generate Acceptance Criteria**
    -   Reverse-calculate acceptance criteria from implemented tests.
    -   Present unimplemented test cases as recommendations.

7.  **Create File**
    -   Save as `docs/reverse/{project_name}-requirements.md`.

## Example Output Format

```markdown
# {Project Name} Requirements Definition Document (Reverse-generated)

## Analysis Overview

**Analysis Date**: {Execution date}
**Target Codebase**: {Path}
**Number of Extracted Requirements**: {Number} functional requirements, {Number} non-functional requirements
**Confidence Level**: {Analysis confidence level} % (based on implementation coverage)

## System Overview

### Estimated System Purpose
{The purpose of the system inferred from the implemented features}

### Target Users
{User types estimated from UI components and features}

## User Stories

### Story 1: User Authentication
- **As an** unregistered/existing user
- **I want to** log in to the system securely
- **so that** I can access personal information and services.

**Implementation Basis**:
- `LoginForm.tsx` - Login form implementation
- `POST /auth/login` - Authentication API implementation
- `useAuth` hook - Authentication state management

### Story 2: {Other stories}

{Additional user stories estimated from implemented features}

## Functional Requirements (EARS Notation)

### Ubiquitous Requirements

#### REQ-001: User Authentication
The system SHALL provide user login with a valid email address and password.

**Implementation Basis**:
- `auth.service.ts:login()` method
- `POST /auth/login` endpoint
- JWT token issuance implementation

#### REQ-002: Session Management
The system SHALL manage the user session after login.

**Implementation Basis**:
- Session management with JWT tokens
- State management with the `useAuth` hook
- Token persistence in local storage

### Event-Driven Requirements

#### REQ-101: Handling of Authentication Failure
WHEN invalid credentials are provided, the system SHALL display an appropriate error message.

**Implementation Basis**:
- Error handling in `auth.controller.ts`
- Error display implementation in `LoginForm.tsx`

#### REQ-102: Handling of Token Expiration
IF the JWT token has expired, THEN the system SHALL redirect the user to the re-login page.

**Implementation Basis**:
- 401 error handling in `axios.interceptors`
- Implementation of an automatic logout feature

### State-Driven Requirements

#### REQ-201: Display in Logged-in State
WHILE the user is in a logged-in state, the system SHALL display the UI for authenticated users.

**Implementation Basis**:
- Authentication state check with the `useAuth` hook
- Conditional rendering based on the authentication state

### Optional Requirements

#### REQ-301: Remembering Login State
The system MAY remember the user's login state.

**Implementation Basis**:
- Token storage in local storage
- Implementation of an automatic login feature

### Unwanted Requirements (Constraints)

#### REQ-401: Password Requirements
The system MUST enforce a minimum password length of 8 characters.

**Implementation Basis**:
- Frontend validation implementation
- Constraint definition in a `yup` schema

#### REQ-402: Rate Limiting
The system MUST enforce rate limiting for login attempts.

**Implementation Basis**:
- Implementation of the `express-rate-limit` middleware

## Non-functional Requirements

### Performance

#### NFR-001: Login Response Time
The system SHALL complete the normal login process within 2 seconds.

**Implementation Basis**:
- Database index settings
- Efficient query implementation

#### NFR-002: Number of Concurrent Users
The system MUST be able to handle access from 100 concurrent users.

**Estimated Basis**:
- Connection pool settings
- Server configuration

### Security

#### NFR-101: Authentication Token Encryption
The system SHALL encrypt the JWT token appropriately.

**Implementation Basis**:
- Use of the `jsonwebtoken` library
- Implementation of signing with a private key

#### NFR-102: HTTPS Communication
The system MUST enforce HTTPS communication in the production environment.

**Implementation Basis**:
- SSL configuration file
- HTTPS redirect implementation

### Usability

#### NFR-201: Responsive Design
The system MUST be usable on mobile devices.

**Implementation Basis**:
- Implementation of CSS media queries
- Responsive UI components

#### NFR-202: Accessibility
The system MUST meet basic accessibility requirements.

**Implementation Basis**:
- Use of ARIA attributes
- Semantic HTML structure

### Operability

#### NFR-301: Logging
The system SHALL record important operations in a log.

**Implementation Basis**:
- Use of the `winston` logging library
- Implementation of structured logging

#### NFR-302: Error Tracking
The system MUST be able to track errors that have occurred.

**Implementation Basis**:
- Error handling implementation
- Tracking feature through log output

## Edge Cases

### Error Handling

#### EDGE-001: Network Failure
Retry processing when the network connection is unstable.

**Implementation Basis**:
- Retry settings in `axios`
- Error toast display

#### EDGE-002: Server Down
Processing when the backend server is unavailable.

**Implementation Basis**:
- Fallback feature
- Error page display

### Boundary Values

#### EDGE-101: Maximum Character Limit
Maximum character limit for input fields.

**Implementation Basis**:
- Form validation implementation
- Database constraints

#### EDGE-102: Handling of Empty Strings and Null Values
Appropriate handling of empty strings and null values.

**Implementation Basis**:
- Validation implementation
- Default value settings

## Acceptance Criteria

### Implemented Feature Tests

- [x] User login feature
  - [x] Successful login with valid credentials
  - [x] Failed login with invalid credentials
  - [x] Appropriate display of error messages
- [x] Session management feature
  - [x] Maintaining the logged-in state
  - [x] Logout feature
  - [x] Token expiration handling

### Recommended Additional Tests

- [ ] **Performance Test**
  - [ ] Login response time measurement
  - [ ] Concurrent access load test
- [ ] **Security Test**
  - [ ] SQL injection countermeasure test
  - [ ] XSS countermeasure test
  - [ ] CSRF countermeasure test
- [ ] **Accessibility Test**
  - [ ] Screen reader support test
  - [ ] Keyboard operation test

## Unestimated Requirements

### Unclear Parts

The following requirements are difficult to estimate from the implementation and require confirmation with stakeholders:

1.  **Business Requirements**
    -   Details of the system's purpose
    -   Detailed attributes of the target users
    -   Revenue model and business goals

2.  **Operational Requirements**
    -   Backup/recovery requirements
    -   SLA (Service Level Agreement)
    -   Monitoring/alerting requirements

3.  **Legal/Compliance Requirements**
    -   Compliance with data protection regulations
    -   Industry-specific regulatory requirements

### Recommended Next Steps

1.  **Stakeholder Interviews** - To confirm the estimated requirements.
2.  **Usability Testing** - To confirm the actual usability requirements.
3.  **Performance Testing** - To verify the non-functional requirements.
4.  **Security Audit** - For a detailed verification of security requirements.

## Analysis Constraints

### Factors Affecting Confidence Level

- **Lack of comments**: The developer's intent is supplemented by estimation.
- **Test coverage**: {%}% - Requirements for untested parts are estimated.
- **Lack of documentation**: No external specification documents exist.
- **Legacy code**: Difficulty of estimation due to old implementation patterns.

### Basis for Estimation

- **Strong basis**: Implementation + test + clear operation
- **Medium basis**: Implementation + partial test
- **Weak basis**: Implementation only, supplemented by estimation

```

## Requirements Extraction Algorithm

### 1. Functional Requirements Extraction Process

```
1. API endpoints → Business functional requirements
2. UI components → User interface requirements
3. Database schema → Data requirements
4. Validation implementation → Constraint requirements
5. Conditional branching → Event-driven requirements
```

### 2. Non-functional Requirements Estimation Process

```
1. Configuration files + libraries → Performance/security requirements
2. UI implementation patterns → Usability requirements
3. Logging/monitoring implementation → Operational requirements
4. Test implementation → Quality requirements
```

### 3. User Story Reverse-calculation Process

```
1. Screen transition flow → User journey
2. Forms/input fields → User actions
3. CRUD operations on data → User needs
4. Permissions/roles implementation → User types
```

## Example Execution Commands

```bash
# Full analysis (extract all requirements)
claude code rev-requirements

# Extract only a specific requirement category
claude code rev-requirements --target functional
claude code rev-requirements --target non-functional
claude code rev-requirements --target user-stories

# Confidence level filter
claude code rev-requirements --confidence high
claude code rev-requirements --confidence medium

# Analyze a specific directory
claude code rev-requirements --path ./src

# Specify the output format
claude code rev-requirements --format markdown,json
```

## Confirmation After Execution

-   Display the number of extracted requirements (functional/non-functional).
-   Report the confidence level and the strength of the basis for the analysis.
-   Present any requirements that were difficult to estimate or items that require confirmation.
-   Generate a list of questions for stakeholder confirmation.
-   Propose the next recommended actions (adding tests, preparing documentation, etc.).
```
