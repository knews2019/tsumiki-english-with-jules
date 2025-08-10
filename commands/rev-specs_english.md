# rev-specs

## Objective

To reverse-generate comprehensive test cases and specifications from an existing codebase. To analyze the implemented business logic, API behavior, and UI component behavior, identify and generate missing test cases, and document them as a specification.

## Prerequisites

- The codebase to be analyzed exists.
- The `docs/reverse/` directory exists (if not, create it).
- If possible, `rev-requirements.md` and `rev-design.md` have been executed beforehand.

## Execution Content

1.  **Analyze Existing Tests**
    -   Confirm the implementation status of unit tests.
    -   Confirm the implementation status of integration tests.
    -   Confirm the implementation status of E2E (End-to-End) tests.
    -   Measure test coverage.

2.  **Reverse-generate Test Cases from Implementation Code**
    -   Generate test cases from the arguments/return values of functions/methods.
    -   Generate boundary value tests from conditional branches.
    -   Generate sad path tests from error handling.
    -   Generate data tests from database operations.

3.  **Generate Test Cases from API Specifications**
    -   Happy path tests for each endpoint.
    -   Authentication/authorization tests.
    -   Validation error tests.
    -   HTTP status code tests.

4.  **Generate Test Cases from UI Components**
    -   Component rendering tests.
    -   User interaction tests.
    -   State change tests.
    -   Property change tests.

5.  **Generate Performance & Security Test Cases**
    -   Load test scenarios.
    -   Security vulnerability tests.
    -   Response time tests.

6.  **Generate Test Specifications**
    -   Test plan.
    -   Test case list.
    -   Test environment specification.
    -   Test procedure manual.

7.  **Create Files**
    -   `docs/reverse/{project_name}-test-specs.md` - Test specification
    -   `docs/reverse/{project_name}-test-cases.md` - Test case list
    -   `docs/reverse/tests/` - Generated test code

## Example Output Format

### test-specs.md

```markdown
# {Project Name} Test Specification (Reverse-generated)

## Analysis Overview

**Analysis Date**: {Execution date}
**Target Codebase**: {Path}
**Test Coverage**: {Current coverage}%
**Number of Generated Test Cases**: {Number generated}
**Number of Recommended Tests for Implementation**: {Number recommended}

## Current Test Implementation Status

### Test Frameworks
- **Unit Test**: {Jest/Vitest/pytest, etc.}
- **Integration Test**: {Supertest/TestContainers, etc.}
- **E2E Test**: {Cypress/Playwright, etc.}
- **Code Coverage**: {istanbul/c8, etc.}

### Detailed Test Coverage

| File/Directory | Line Coverage | Branch Coverage | Function Coverage |
|---|---|---|---|
| src/auth/ | 85% | 75% | 90% |
| src/users/ | 60% | 45% | 70% |
| src/components/ | 40% | 30% | 50% |
| **Overall** | **65%** | **55%** | **75%** |

### Implementation Status by Test Category

#### Unit Tests
- [x] **Authentication Service**: auth.service.spec.ts
- [x] **User Service**: user.service.spec.ts
- [ ] **Data Conversion Utility**: Not implemented
- [ ] **Validation Helper**: Not implemented

#### Integration Tests
- [x] **Authentication API**: auth.controller.spec.ts
- [ ] **User Management API**: Not implemented
- [ ] **Database Operations**: Not implemented

#### E2E Tests
- [ ] **User Login Flow**: Not implemented
- [ ] **Data Operation Flow**: Not implemented
- [ ] **Error Handling**: Not implemented

## Generated Test Cases

### API Test Cases

#### POST /auth/login - Login Authentication

**Happy Path Test**
```typescript
describe('POST /auth/login', () => {
  it('should succeed with valid credentials', async () => {
    const response = await request(app)
      .post('/auth/login')
      .send({
        email: 'test@example.com',
        password: 'password123'
      });

    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
    expect(response.body.data.token).toBeDefined();
    expect(response.body.data.user.email).toBe('test@example.com');
  });

  it('should return a JWT token in the correct format', async () => {
    const response = await request(app)
      .post('/auth/login')
      .send(validCredentials);

    const token = response.body.data.token;
    expect(token).toMatch(/^[A-Za-z0-9-_]+\.[A-Za-z0-9-_]+\.[A-Za-z0-9-_]+$/);
  });
});
```

**Sad Path Test**
```typescript
describe('POST /auth/login - Sad Path', () => {
  it('should error with an invalid email address', async () => {
    const response = await request(app)
      .post('/auth/login')
      .send({
        email: 'invalid-email',
        password: 'password123'
      });

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
    expect(response.body.error.code).toBe('VALIDATION_ERROR');
  });

  it('should error with a non-existent user', async () => {
    const response = await request(app)
      .post('/auth/login')
      .send({
        email: 'nonexistent@example.com',
        password: 'password123'
      });

    expect(response.status).toBe(401);
    expect(response.body.error.code).toBe('INVALID_CREDENTIALS');
  });

  it('should error with a wrong password', async () => {
    const response = await request(app)
      .post('/auth/login')
      .send({
        email: 'test@example.com',
        password: 'wrongpassword'
      });

    expect(response.status).toBe(401);
    expect(response.body.error.code).toBe('INVALID_CREDENTIALS');
  });
});
```

**Boundary Value Test**
```typescript
describe('POST /auth/login - Boundary Values', () => {
  it('should test with a minimum length password', async () => {
    // 8 characters (minimum requirement)
    const response = await request(app)
      .post('/auth/login')
      .send({
        email: 'test@example.com',
        password: '12345678'
      });

    expect(response.status).toBe(200);
  });

  it('should test with a maximum length email address', async () => {
    // 255 characters (maximum requirement)
    const longEmail = 'a'.repeat(243) + '@example.com';
    const response = await request(app)
      .post('/auth/login')
      .send({
        email: longEmail,
        password: 'password123'
      });

    expect(response.status).toBe(400);
  });
});
```

### UI Component Test Cases

#### LoginForm Component

**Rendering Test**
```typescript
import { render, screen } from '@testing-library/react';
import { LoginForm } from './LoginForm';

describe('LoginForm', () => {
  it('should display the necessary elements', () => {
    render(<LoginForm onSubmit={jest.fn()} />);

    expect(screen.getByLabelText('Email Address')).toBeInTheDocument();
    expect(screen.getByLabelText('Password')).toBeInTheDocument();
    expect(screen.getByRole('button', { name: 'Login' })).toBeInTheDocument();
  });

  it('should not display an error message in the initial state', () => {
    render(<LoginForm onSubmit={jest.fn()} />);

    expect(screen.queryByText(/Error/)).not.toBeInTheDocument();
  });
});
```

**User Interaction Test**
```typescript
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';

describe('LoginForm - User Interaction', () => {
  it('should call onSubmit when the form is submitted', async () => {
    const mockSubmit = jest.fn();
    render(<LoginForm onSubmit={mockSubmit} />);

    await userEvent.type(screen.getByLabelText('Email Address'), 'test@example.com');
    await userEvent.type(screen.getByLabelText('Password'), 'password123');
    await userEvent.click(screen.getByRole('button', { name: 'Login' }));

    expect(mockSubmit).toHaveBeenCalledWith({
      email: 'test@example.com',
      password: 'password123'
    });
  });

  it('should not submit when there is a validation error', async () => {
    const mockSubmit = jest.fn();
    render(<LoginForm onSubmit={mockSubmit} />);

    await userEvent.click(screen.getByRole('button', { name: 'Login' }));

    expect(mockSubmit).not.toHaveBeenCalled();
    expect(screen.getByText('Email is required')).toBeInTheDocument();
  });
});
```

### Service Layer Test Cases

#### AuthService Unit Test

```typescript
import { AuthService } from './auth.service';
import { UserRepository } from './user.repository';

jest.mock('./user.repository');

describe('AuthService', () => {
  let authService: AuthService;
  let mockUserRepository: jest.Mocked<UserRepository>;

  beforeEach(() => {
    mockUserRepository = new UserRepository() as jest.Mocked<UserRepository>;
    authService = new AuthService(mockUserRepository);
  });

  describe('login', () => {
    it('should return user info and a token with valid credentials', async () => {
      const mockUser = {
        id: '1',
        email: 'test@example.com',
        hashedPassword: 'hashed_password'
      };

      mockUserRepository.findByEmail.mockResolvedValue(mockUser);
      jest.spyOn(authService, 'verifyPassword').mockResolvedValue(true);
      jest.spyOn(authService, 'generateToken').mockReturnValue('mock_token');

      const result = await authService.login('test@example.com', 'password');

      expect(result).toEqual({
        user: { id: '1', email: 'test@example.com' },
        token: 'mock_token'
      });
    });

    it('should throw an error for a non-existent user', async () => {
      mockUserRepository.findByEmail.mockResolvedValue(null);

      await expect(
        authService.login('nonexistent@example.com', 'password')
      ).rejects.toThrow('Invalid credentials');
    });
  });
});
```

## Performance Test Cases

### Load Test

```typescript
describe('Performance Test', () => {
  it('Login API - 100 concurrent connections test', async () => {
    const promises = Array.from({ length: 100 }, () =>
      request(app).post('/auth/login').send(validCredentials)
    );

    const startTime = Date.now();
    const responses = await Promise.all(promises);
    const endTime = Date.now();

    // All requests succeed
    responses.forEach(response => {
      expect(response.status).toBe(200);
    });

    // Response time is within 5 seconds
    expect(endTime - startTime).toBeLessThan(5000);
  });

  it('Database - Large data search performance', async () => {
    // Create 1000 test data items
    await createTestData(1000);

    const startTime = Date.now();
    const response = await request(app)
      .get('/users')
      .query({ limit: 100, offset: 0 });
    const endTime = Date.now();

    expect(response.status).toBe(200);
    expect(endTime - startTime).toBeLessThan(1000); // within 1 second
  });
});
```

### Security Test

```typescript
describe('Security Test', () => {
  it('SQL injection countermeasure', async () => {
    const maliciousInput = "'; DROP TABLE users; --";

    const response = await request(app)
      .post('/auth/login')
      .send({
        email: maliciousInput,
        password: 'password'
      });

    // The system operates normally, and the database is not corrupted
    expect(response.status).toBe(400);

    // Confirm that the users table still exists
    const usersResponse = await request(app)
      .get('/users')
      .set('Authorization', 'Bearer ' + validToken);
    expect(usersResponse.status).not.toBe(500);
  });

  it('XSS countermeasure', async () => {
    const xssPayload = '<script>alert("XSS")</script>';

    const response = await request(app)
      .post('/users')
      .set('Authorization', 'Bearer ' + validToken)
      .send({
        name: xssPayload,
        email: 'test@example.com'
      });

    // The script is escaped in the response
    expect(response.body.data.name).not.toContain('<script>');
    expect(response.body.data.name).toContain('&lt;script&gt;');
  });
});
```

## E2E Test Cases

### Playwright/Cypress Test Scenario

```typescript
// User login flow E2E test
describe('User Login Flow', () => {
  it('should go from normal login to dashboard display', async () => {
    await page.goto('/login');

    // Fill in the login form
    await page.fill('[data-testid="email-input"]', 'test@example.com');
    await page.fill('[data-testid="password-input"]', 'password123');
    await page.click('[data-testid="login-button"]');

    // Redirect to the dashboard
    await page.waitForURL('/dashboard');

    // Confirm user information display
    await expect(page.locator('[data-testid="user-name"]')).toContainText('Test User');

    // Confirm logout feature
    await page.click('[data-testid="logout-button"]');
    await page.waitForURL('/login');
  });

  it('should display an error on login failure', async () => {
    await page.goto('/login');

    await page.fill('[data-testid="email-input"]', 'wrong@example.com');
    await page.fill('[data-testid="password-input"]', 'wrongpassword');
    await page.click('[data-testid="login-button"]');

    // Confirm error message display
    await expect(page.locator('[data-testid="error-message"]'))
      .toContainText('Invalid credentials');
  });
});
```

## Test Environment Configuration

### Database Test Configuration

```typescript
// Test database configuration
beforeAll(async () => {
  // Connect to the test database
  await setupTestDatabase();

  // Run migrations
  await runMigrations();
});

beforeEach(async () => {
  // Clean up data before each test
  await cleanupDatabase();

  // Seed basic test data
  await seedTestData();
});

afterAll(async () => {
  // Disconnect from the test database
  await teardownTestDatabase();
});
```

### Mock Configuration

```typescript
// Mock for an external service
jest.mock('./email.service', () => ({
  EmailService: jest.fn().mockImplementation(() => ({
    sendEmail: jest.fn().mockResolvedValue(true)
  }))
}));

// Mock for environment variables
process.env.JWT_SECRET = 'test-secret';
process.env.NODE_ENV = 'test';
```

## Priority of Missing Tests

### High Priority (Recommended for immediate implementation)
1.  **E2E Test Suite** - To guarantee the operation of the entire user flow.
2.  **API Integration Test** - To test the entire backend API.
3.  **Security Test** - To verify vulnerability countermeasures.

### Medium Priority (Implement in the next sprint)
1.  **Performance Test** - Load and response time testing.
2.  **UI Component Test** - To guarantee frontend operation.
3.  **Database Test** - To test data integrity.

### Low Priority (Implement as continuous improvement)
1.  **Browser Compatibility Test** - To confirm operation in multiple browsers.
2.  **Accessibility Test** - To confirm a11y compliance.
3.  **Internationalization Test** - To confirm multilingual support.

```

### test-cases.md

```markdown
# {Project Name} Test Case List (Reverse-generated)

## Test Case Overview

| ID | Test Name | Category | Priority | Implementation Status | Estimated Man-hours |
|---|---|---|---|---|---|
| TC-001 | Login Happy Path | API | High | ✅ | 2h |
| TC-002 | Login Sad Path | API | High | ✅ | 3h |
| TC-003 | E2E Login Flow | E2E | High | ❌ | 4h |
| TC-004 | Performance Load Test | Performance | Medium | ❌ | 6h |

## Detailed Test Cases

### TC-001: Login API Happy Path Test

**Test Objective**: To verify the login feature with valid credentials.

**Prerequisites**:
- A test user exists in the database.
- The password is correctly hashed.

**Test Steps**:
1. Send a request to POST /auth/login.
2. Send JSON containing a valid email and password.
3. Check the response.

**Expected Result**:
- HTTP Status: 200
- success: true
- data.token: A token in JWT format
- data.user: User information

**Implementation File**: `auth.controller.spec.ts`

### TC-002: Login API Sad Path Test

**Test Objective**: To verify the proper error handling for invalid credentials.

**Test Cases**:
1. Non-existent email address
2. Invalid password
3. Invalid email format
4. Empty string/null values
5. SQL injection attack

**Expected Result**:
- Appropriate HTTP status code
- A unified error response format
- No security vulnerabilities

**Implementation Status**: ✅ Partially implemented

```

## Test Code Generation Algorithm

### 1. Test Case Extraction by Static Analysis

```
1. Function signature analysis → Test cases for arguments/return values
2. Conditional branch analysis → Branch coverage test cases
3. Exception handling analysis → Sad path test cases
4. Database access analysis → Data test cases
```

### 2. Test Generation by Dynamic Analysis

```
1. API call logs → Test for actual usage patterns
2. User operation logs → E2E test scenarios
3. Performance logs → Load test scenarios
```

### 3. Test Coverage Gap Analysis

```
1. Measure current coverage
2. Identify untested lines/branches
3. Identify the critical path
4. Risk-based prioritization
```

## Example Execution Commands

```bash
# Full analysis (generate all test cases)
claude code rev-specs

# Generate only a specific test category
claude code rev-specs --type unit
claude code rev-specs --type integration
claude code rev-specs --type e2e

# Target a specific file/directory
claude code rev-specs --path ./src/auth

# Actually generate and output the test code
claude code rev-specs --generate-code

# Analyze together with a coverage report
claude code rev-specs --with-coverage

# Priority filtering
claude code rev-specs --priority high
```

## Confirmation After Execution

-   Display a detailed report of the current test coverage and missing parts.
-   Display the number of generated test cases and the estimated implementation man-hours.
-   Present a prioritized list of recommended implementations.
-   Propose test environment configuration requirements and recommended tools.
-   Propose a plan for integration into the CI/CD pipeline.
```
