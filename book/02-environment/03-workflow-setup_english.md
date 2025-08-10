# 2.3 Building a Development Environment and Workflow

This section explains how to build a development environment and workflow for effectively practicing AITDD. By systematizing the entire development process, not just preparing tools, you can achieve consistent, high-quality development.

## The Actual History of AITDD Adoption and the Evolution of the Method

### Adoption Timeline

#### Full-scale Efforts from the Beginning of 2025
**Motivation:**
- The emergence of **Claude Sonnet 3.5** and **distilled models of DeepSeek R1**
- Gained confidence that a certain level of implementation was achievable with AI
- Felt the limitations of traditional manual coding

**Accumulation of about 5-6 months of practical experience:**
- Development from initial trial and error to a systematic method
- Discovery of optimization patterns for prompt design
- Learning from failure cases and establishing best practices

### Evolution Process of the Method

#### Phase 1: Live Coding (Initial Approach)
**Characteristics:**
- Creating code while interacting with AI in real-time
- Effective for implementing small-scale features
- Rapid corrections through immediate feedback

**Effective Scenarios:**
- Small modifications within a single file
- Rapid creation of prototypes
- Creating sample code for technical research

**Discovery of Limitations:**
- The structure tends to break down in large-scale development
- Difficult to manage complex dependencies
- Difficult to maintain quality consistency

#### Phase 2: Combination with TDD (Current Method)
**Problem Recognition:**
- Large-scale development is difficult with live coding
- Lack of a quality assurance mechanism
- A system to maintain design consistency is needed

**Adoption of a Solution:**
- Combination with **TDD (Test-Driven Development)**
- Establishment of the **Red-Green-Refactor-Validation** cycle
- Construction of a systematic workflow

**Characteristics of the Current Method:**
```
Before Evolution (Live Coding):
Requirements → Direct Implementation → Operation Check → Correction → Complete

After Evolution (AITDD):
Requirements → Create TODO → Red → Green → Refactor → Validation → Complete
         ↑                                          ↓
         ←←←←←←← Feedback Loop ←←←←←←←←←←
```

### Experience in Building an Actual Development Workflow

#### Project Structure Optimization Process
**Initial Challenges:**
- File structure varied for each project
- Inappropriate granularity of TODOs
- Difficult to track Git history

**Improved Structure:**
```
project-root/
├── todo.md                    # Central task management
├── docs/                      # Systematized design documents
│   ├── requirements.md        # Clear requirements definition
│   ├── architecture.md        # Architecture design
│   └── api-spec.md            # Detailed API specifications
├── src/                       # Clear separation by feature
├── tests/                     # Systematized test code
└── scripts/                   # Automation scripts
```

#### Evolution of TODO Management

**Initial Problems:**
- TODOs were too large (e.g., "Implement the entire system")
- Unclear dependencies
- Difficult to track progress

**Current Optimized Approach:**

**Finding the Right Granularity:**
```markdown
# Optimal Granularity (30 minutes to 1 hour)
- [x] Implement user registration API
- [x] Password validation feature
- [ ] JWT authentication middleware
- [ ] Add tests for login feature

# Granularity to Avoid
❌ Implement the entire system (too large)
❌ Change a variable name (too small)
```

**Practical Sequential Execution Strategy:**
1.  **Process the TODO list from top to bottom**
2.  **Move to the next item after one is completely finished**
3.  **Adjust the order for items with dependencies**
4.  **Break down into units that can be completed in 30 minutes to 1 hour**

### Practical Operation of the Git Workflow

#### Branching Strategy Specialized for AITDD

**Strategy Actually Adopted:**
```bash
# Branch creation pattern for each TODO item
git checkout -b feature/user-registration    # TODO: User registration API
git checkout -b feature/auth-middleware      # TODO: Authentication middleware
git checkout -b feature/password-validation  # TODO: Password validation
```

**Commit Strategy Corresponding to the AITDD Cycle:**
```bash
# Red Phase (Create a failing test)
git add tests/user-registration.test.js
git commit -m "Red: Add failing tests for user registration"

# Green Phase (Minimal implementation to pass the test)
git add src/controllers/user.js
git commit -m "Green: Implement basic user registration"

# Refactor Phase (Improve the code)
git add src/controllers/user.js src/models/user.js
git commit -m "Refactor: Extract user validation logic"

# Validation Phase (Final verification and documentation)
git add docs/api-spec.md
git commit -m "Validation: Complete user registration with docs"
```

#### Practice of the Recovery Strategy in Case of Failure

**Decision Criteria in Actual Operation:**
```bash
# Pattern 1: Can be handled with a minor correction
if [ "difference from expectation" == "small" ]; then
    # Rerun with prompt adjustment
    echo "Retrying with a more detailed prompt"
fi

# Pattern 2: Major correction is needed
if [ "difference from expectation" == "large" ]; then
    git reset --hard HEAD~1  # Revert to the previous state
    echo "Rerunning after reviewing the prompt"
fi

# Pattern 3: Multiple failures
if [ "number of failures" -gt 3 ]; then
    git reset --hard <last_known_good_commit>
    echo "Fundamentally reviewing the approach"
fi
```

**Example of an Actual Recovery Pattern:**
```
Situation: Inappropriate error handling in the implementation of the user authentication API
Judgment: No improvement after 3 correction attempts
Action: Revert to the Red phase with `git reset --hard HEAD~4`
Rerun: Resumed with a more detailed prompt
Result: The expected implementation was completed
```

### Important Lessons Learned from Practice

#### Analysis of Success Factors

**1. The Effect of a Phased Approach:**
-   Steady progress in small steps
-   Quality confirmation at each stage
-   Limiting the scope of impact in case of failure

**2. The Importance of Documentation:**
-   Clarity of requirements definition directly affects the quality of AI output
-   The API specification serves as a guide for test design
-   Visualization of progress contributes to maintaining motivation

**3. The Cumulative Effect of Prompt Optimization:**
-   Improved efficiency by reusing the same patterns
-   Improved accuracy by analyzing failure cases
-   Accumulation of domain-specific knowledge

#### Common Problems and Solutions

**Problem 1: Unstable quality of AI output**
```
Symptom: Results vary day by day even with the same prompt
Cause: Ambiguity in the prompt, lack of context
Solution: Add more specific technical constraints and examples

Improvement Example:
"Make an API"
↓
"Create a POST /api/users API with Express.js + Mongoose:
- Request: {name: string, email: string}
- Validation: email format check, name required
- Response: 201 with the created user information
- Errors: 400(validation), 409(duplicate), 500(server)"
```

**Problem 2: Getting lost in a large-scale project**
```
Symptom: Losing track of the current work position
Cause: Inadequate TODO management, lack of progress tracking
Solution: Clear progress display and explicit next actions

Improvement Example:
## Current Implementation Status (2025-06-21)
- [x] User management feature (Complete)
- [ ] **Authentication feature (In progress: Creating JWT middleware)**
- [ ] Authorization feature (Not started)

### Next Actions
1. Implement JWT signature verification
2. Add token refresh functionality
3. Implement logout functionality
```

**Problem 3: Discrepancy between tests and code**
```
Symptom: Tests pass, but the actual behavior is not as expected
Cause: Flaws in test design, misunderstanding of requirements
Solution: Create more realistic test cases

Improvement Example:
# Insufficient test
test('should create user', () => {
  expect(user).toBeDefined();
});

# Improved test
test('should create user with valid email and return 201', async () => {
  const userData = { name: 'John', email: 'john@example.com' };
  const response = await request(app)
    .post('/api/users')
    .send(userData)
    .expect(201);

  expect(response.body.user.email).toBe(userData.email);
  expect(response.body.user.password).toBeUndefined(); // Should not include the password
});
```

## Overall Picture of the AITDD Development Workflow

### Basic Development Flow
```
Create TODO list → Select item → Execute AITDD → Review → Next item
     ↑                                            ↓
     ←←←←←←←←←← Adjust as needed ←←←←←←←←←←←←←←
```

### Detailed Cycle of AITDD Execution
```
Red (Create Test) → Green (Implement) → Refactor (Improve) → Validation (Verify)
      ↑                                                    ↓
      ←←←←←←←←←←←←← Feedback Loop ←←←←←←←←←←←←←←
```

## Designing the Project Structure

### Recommended Directory Structure

```
project-root/
├── todo.md                    # Main TODO list
├── docs/                      # Project documents
│   ├── requirements.md        # Requirements definition
│   ├── architecture.md        # Architecture design
│   └── api-spec.md            # API specification
├── src/                       # Source code
│   ├── models/                # Data models
│   ├── controllers/           # Controllers
│   ├── services/              # Business logic
│   └── utils/                 # Utilities
├── tests/                     # Test code
│   ├── unit/                  # Unit tests
│   ├── integration/           # Integration tests
│   └── fixtures/              # Test data
├── scripts/                   # Development scripts
└── README.md                  # Project overview
```

### Creating and Managing the TODO List

#### Basic Format of the TODO List

**Example of `todo.md`:**
```markdown
# Project TODO List

## Currently Being Implemented
- [ ] Implement user registration feature

## Completed
- [x] Initial project setup
- [x] Database connection setup

## Not Started (in priority order)
1. [ ] User authentication feature
   - [ ] Password hashing
   - [ ] JWT token generation
   - [ ] Login API

2. [ ] User management feature
   - [ ] Profile update API
   - [ ] User deletion API
   - [ ] User list API

3. [ ] Security enhancements
   - [ ] Implement rate limiting
   - [ ] Strengthen input validation
   - [ ] CORS settings

## To Be Considered in the Future
- [ ] Performance optimization
- [ ] Deployment automation
```

#### Setting an Effective TODO Granularity

**Examples of appropriate granularity:**
- ✅ `Implement user registration API` (30 mins - 1 hour)
- ✅ `Password validation feature` (30 mins - 1 hour)
- ✅ `JWT authentication middleware` (30 mins - 1 hour)

**Granularity to avoid:**
- ❌ `Implement the entire system` (too large)
- ❌ `Change a variable name` (too small)

### TODO Execution Strategy

#### Sequential Execution Approach
```markdown
Execution Policy:
1. Process the TODO list from top to bottom.
2. Move to the next item only after one is completely finished.
3. Adjust the order for items with dependencies.
4. Break down into units that can be completed in 30 minutes to 1 hour.
```

#### Dependency Management
```markdown
Example of dependencies:
- User model → User registration API → User authentication
- Database design → Migration → API implementation
- Basic features → Error handling → Security enhancements
```

## Setting up the Git Workflow

### Branching Strategy for AITDD

#### Basic Branching Model
```bash
main                    # For production environment
├── develop             # For development integration
└── feature/todo-item   # For each TODO item
```

#### Practical Example of Branch Creation
```bash
# Create a branch for each TODO item
git checkout -b feature/user-registration
git checkout -b feature/user-authentication
git checkout -b feature/password-validation

# When grouping by feature sets
git checkout -b feature/user-management
git checkout -b feature/security-enhancement
```

### Commit Strategy

#### Commits Corresponding to the AITDD Cycle
```bash
# Red Phase (Create test)
git add tests/
git commit -m "Red: Add tests for user registration"

# Green Phase (Implement)
git add src/
git commit -m "Green: Implement user registration functionality"

# Refactor Phase (Improve)
git add src/
git commit -m "Refactor: Improve user registration code structure"

# Validation Phase (Verify)
git add .
git commit -m "Validation: Complete user registration with documentation"
```

#### Recovery Strategy in Case of Failure
```bash
# If the AI does not produce the expected results
git reset --hard HEAD~1  # Cancel the last commit
# or
git reset --hard <commit-hash>  # Revert to a specific commit

# Adjust the prompt and rerun
# If successful, make a new commit
```

## Next Steps for Practice

### Action Plan After Completing Environment Setup

1.  **Preparation for Moving to Chapter 3**
    -   Detailed understanding of the AITDD process
    -   Mastering the Red-Green-Refactor-Validation cycle
    -   Experiencing the actual development flow

2.  **Planning Your First Project**
    -   Designing a small-scale sample project
    -   Defining clear functional requirements
    -   Creating a TODO list with an implementable scope

3.  **Preparation for Continuous Improvement**
    -   Improving prompt design skills
    -   Mastering effective interaction patterns with AI
    -   Practicing reviews and quality control

### Key Points for Success

#### Adopting a Phased Approach
-   **Start small**: Begin with simple features.
-   **Expand gradually**: Build on success experiences.
-   **Learn from failure**: Don't be afraid to use `git reset` and experiment.

#### Continuous Attention to Quality
-   **Test-first**: Always start by writing tests.
-   **Habituate reviews**: Always check AI-generated code.
-   **Practice documentation**: Properly record implementation details.

#### Preparation for Team Practice
-   **Build a common understanding**: Align perceptions with team members.
-   **Unify tools**: Work in the same development environment.
-   **Share knowledge**: Share success and failure stories.

## Confirmation of Environment Setup Completion

### Final Checklist

- [ ] **Basic Tools**
  - [ ] Claude Sonnet 4 (Claude Code) is available.
  - [ ] VS Code is properly configured.
  - [ ] The Git repository is initialized.

- [ ] **Project Structure**
  - [ ] The recommended directory structure has been created.
  - [ ] The `todo.md` file is ready.
  - [ ] Basic configuration files are in place.

- [ ] **Development Workflow**
  - [ ] The Git branching strategy has been decided.
  - [ ] Commit conventions are defined.
  - [ ] The test environment has been checked.

- [ ] **Documentation & Monitoring**
  - [ ] `README.md` has been created.
  - [ ] Logging settings are complete.
  - [ ] The debugging environment is ready.

### Operational Check Test

```bash
# Basic operational checks
npm test                     # Run tests
npm run test:coverage        # Check coverage
git status                   # Check Git status
git log --oneline -5         # Check recent commits

# Check integration with Claude Code
# Open the project in VS Code
# Check if the Claude Code plugin works correctly
# Request the AI to create a simple test case to check its operation
```

### Troubleshooting

#### Common Problems and Solutions

**Cannot connect to Claude Code**
```bash
# Check authentication
# Confirm Pro plan is active
# Check network settings
```

**Error in the test environment**
```bash
# Reinstall dependencies
npm install

# Clear package cache
npm cache clean --force
```

**Error with Git operations**
```bash
# Reconfigure authentication credentials
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Summary

In Chapter 2, we learned how to build a comprehensive development environment for practicing AITDD. The key points are as follows:

### Major Achievements
1.  **Tool Setup**: Built a development environment centered around Claude Sonnet 4.
2.  **Workflow Design**: A systematic process from TODO management to the Git flow.
3.  **Quality Control Foundation**: Prepared the test environment, logging, and debugging functions.

### Preparation for the Next Chapter
Now that the environment is set up, it's time to learn the actual process of AITDD. In Chapter 3, "Details of the AITDD Process," you will master the practical methods of the Red-Green-Refactor-Validation cycle.

**Learning Points:**
-   Specific tasks in each phase
-   Effective ways to interact with AI
-   Techniques for quality control and reviews

With the environment in place, you are now ready to actually develop software in collaboration with AI. Let's experience the true value of AITDD in the next chapter.
