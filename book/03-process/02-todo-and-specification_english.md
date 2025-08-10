# 3.2 TODO Creation and Specification Definition

## TODO Creation: The Starting Point of Development

### The Importance of TODOs

In AITDD, creating appropriate TODOs is the key to success. Ambiguous TODOs will negatively affect all subsequent steps, so it is crucial to create clear and executable TODOs.

### Principles of Effective TODO Creation

#### 1. Ensuring Specificity
```markdown
❌ Bad Example: "Create a user management feature"
✅ Good Example: "Implement a new user registration feature (email/password authentication)"
```

#### 2. Appropriate Granularity
- **Too large**: A single TODO includes multiple features
- **Too small**: Individual method units
- **Appropriate**: A single, self-contained functional unit

#### 3. Clarifying Completion Criteria
```markdown
## TODO: Implement User Registration API

### Completion Criteria
- [ ] Implement POST /api/users endpoint
- [ ] Validate email/password
- [ ] Hash the password
- [ ] Save to the database
- [ ] Unify the response format
```

### Structure of the TODO Management File

#### Basic Format

```markdown
# Project TODO Management

## Planned for Implementation
### High Priority
- [ ] **User Authentication Feature**
  - Description: Authentication feature with JWT authentication
  - Completion Criteria: Login/Logout/Token validation
  - Dependency: Database design complete

### Medium Priority
- [ ] **Product Search Feature**
  - Description: Product search by keyword and category
  - Completion Criteria: Search API + filtering feature

## In Progress
- [x] Database design (Completed 2024-06-21)

## Completed
- [x] Initial project setup (Completed 2024-06-20)
```

#### Recommendations for File Structure

```
doc/
├── todo.md                    # Main TODO management
├── implementation/
│   ├── user-auth-requirements.md      # Detailed specs for individual features
│   ├── user-auth-testcases.md         # Test cases
│   └── search-requirements.md
└── archive/
    └── completed-todos.md              # Archive of completed TODOs
```

## Specification Definition: The Foundation of Design

### The Purpose of Specification Definition

To formulate concrete technical specifications from TODOs and clarify the direction of implementation. Ambiguity at this stage can become a major problem in later steps, so it is important to consider the details.

### Specification Document Template

```markdown
# [Feature Name] Requirements Definition Document

## Overview
Briefly describe the purpose and overview of the feature.

## Functional Requirements

### Basic Features
- Essential basic features

### Detailed Specifications
- Input fields and validation
- Processing flow
- Output format

### Non-functional Requirements
- Performance requirements
- Security requirements
- Availability requirements

## Technical Specifications

### API Specification
- Endpoint
- Request/Response format
- Status codes

### Database Design
- Table design
- Indexes
- Constraints

### Error Handling
- Definition of error cases
- Error messages
- Logging policy

## Constraints
- Technical constraints
- Business constraints
- External dependencies

## References
- Related documents
- External API specifications
```

### Concrete Example of Specification Definition

#### Example: Specification for User Registration Feature

```markdown
# User Registration Feature Requirements Definition Document

## Overview
A feature that allows new users to register with an email and password.

## Functional Requirements

### Basic Features
- New user registration with email/password
- Validation for duplicate emails
- Password strength check

### Detailed Specifications

#### Input Fields
- **email**: required, email format, max 254 characters
- **password**: required, 8+ characters, must include letters, numbers, and symbols
- **password_confirmation**: required, must match password

#### Validation
- Duplicate email check (check the database)
- Password strength (must include uppercase/lowercase/numbers/symbols)
- CSRF token validation

#### Processing Flow
1. Validate input values
2. Check for duplicate email
3. Hash the password (bcrypt)
4. Save to the database
5. Return a success response

### Non-functional Requirements
- Response time: within 2 seconds
- Concurrent registrations: supports up to 100/second
- Password hashing is mandatory

## Technical Specifications

### API Specification
```
POST /api/users
Content-Type: application/json

Request:
{
  "email": "user@example.com",
  "password": "SecurePass123!",
  "password_confirmation": "SecurePass123!"
}

Response (201):
{
  "id": 123,
  "email": "user@example.com",
  "created_at": "2024-06-21T10:00:00Z"
}

Response (400):
{
  "error": "validation_failed",
  "details": [
    {
      "field": "email",
      "message": "Email already exists"
    }
  ]
}
```

### Database Design
```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(254) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_email ON users(email);
```

### Error Handling
- **400**: Validation error, duplicate email
- **429**: Rate limiting
- **500**: Server error

## Constraints
- Storing passwords in plaintext is prohibited
- Email confirmation feature is not included this time
- Social login is not included this time
```

## Key Points for Human Review

### Checklist

#### 1. Checking for Completeness
- [ ] Are all necessary features included?
- [ ] Are edge cases considered?
- [ ] Is error handling sufficient?

#### 2. Verifying Feasibility
- [ ] Is it technically feasible to implement?
- [ ] Are the performance requirements realistic?
- [ ] Are the security requirements appropriate?

#### 3. Checking for Consistency
- [ ] Consistency with other features
- [ ] Consistency in data design
- [ ] Uniformity of the API interface

#### 4. Considering Maintainability
- [ ] Future extensibility
- [ ] Ease of testing
- [ ] Ease of documentation

### Points to Note During Review

#### Caution When Utilizing AI Suggestions
- Use AI suggestions as a reference
- Final decisions are always made by humans
- Project-specific requirements are added by humans

#### Phased Detailing
```
1. High-level specifications → Review
2. Add detailed specifications → Review
3. Formulate technical specifications → Review
4. Final confirmation → Approve
```

## Best Practices for Specification Definition

### 1. Clear and Unambiguous Language
```markdown
❌ "Handle appropriately"
✅ "Return a 400 status code and an error message in case of an error"
```

### 2. Specifying Concrete Numbers
```markdown
❌ "Process quickly"
✅ "Return a response within 2 seconds"
```

### 3. Clarifying Constraints
```markdown
❌ "Consider security"
✅ "Hash passwords with bcrypt; storing in plaintext is prohibited"
```

### 4. Considering Testability
- Check if each specification item is testable
- Consider how to prepare test data
- Consider the need for mocks or stubs

## Preparation for the Next Step

Once the specification definition is complete, the next step is [Test Case Creation](./03-test-case-creation.md).

### Confirmation of Deliverables
- [ ] `TODO.md` is updated appropriately
- [ ] `requirements.md` is created in detail
- [ ] No ambiguous parts remain in the specifications
- [ ] The review by humans is complete

### Common Problems and Countermeasures

#### Proceeding with ambiguous specifications
**Countermeasure**: Always conduct a human review and resolve any questions on the spot.

#### Over-relying on AI suggestions
**Countermeasure**: Treat AI suggestions as a reference and have humans make the final decisions.

#### Missing non-functional requirements
**Countermeasure**: Use a checklist to review systematically.

Proper specification definition ensures that the subsequent test case creation and implementation proceed smoothly.
