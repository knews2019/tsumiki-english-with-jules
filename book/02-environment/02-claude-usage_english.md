# 2.2 How to Utilize Claude Sonnet 4

This section explains how to effectively use Claude Sonnet 4, the core of AITDD. You will learn how to develop high-quality software through collaboration between humans and AI, rather than just having the AI write code.

## Features and Strengths of Claude Sonnet 4

### Its Position in AITDD
- **The primary executor of the Red-Green-Refactor-Validation cycle**
- **Consistently handles everything from design to testing and implementation**
- **Balances high-quality code generation with quality checks**

### Reasons for Selection
- **Accessibility**: Can be used freely with Claude Code
- **Coding Performance**: Stable performance at a more-than-sufficient level
- **Cost-Effectiveness**: Reasonable cost ($20/month)
- **AITDD Suitability**: Optimized for a development style that emphasizes trials
- **Integration**: Excellent integration with the VS Code environment

## Basic Usage of Claude Code

### Startup and Basic Operations

1.  **Start Claude Code**
    ```bash
    # Start Claude Code within VS Code
    # Or access via the browser version of Claude
    ```

2.  **Integration with the Project**
    -   Specify the project directory
    -   Recognize the file structure
    -   Understand the existing code

### Basic Interaction Patterns in AITDD

#### 1. Goal Setting Phase
```
You: "I want to implement CRUD operations for a user management feature. First, please create a TODO list."

Claude: "I will create a TODO list for the user management feature:
1. Define the user model
2. Create test cases for user creation
3. Implement the user creation feature
..."
```

#### 2. Test Creation Phase
```
You: "Please create the test case for the first item on the TODO list."

Claude: "I will create a test case for the user model:
```javascript
describe('User Model', () => {
  test('should create user with valid data', () => {
    // test code
  });
});
```"
```

#### 3. Implementation Phase
```
You: "Please implement the code to make this test pass."

Claude: "I will implement the user model to make the test pass:
```javascript
class User {
  constructor(name, email) {
    // implementation code
  }
}
```"
```

## Effective Prompt Design

### Basic Principles of Prompt Design

#### 1. Clear Goal Setting
**Good Example:**
```
"I want to implement a user registration API (POST /users).
- With validation functionality
- Including error handling
- I want to proceed with a test-first approach"
```

**Bad Example:**
```
"Make a user feature"
```

#### 2. Providing Context
```
"Current project configuration:
- Express.js + MongoDB
- Jest for testing
- Existing User model is present

New feature to add:
- API for updating user profiles"
```

#### 3. Specifying Constraints
```
"Constraints:
- Maintain compatibility with existing APIs
- Implement with security in mind
- Performance requirement: response within 1 second"
```

### Iterative Process for Prompt Optimization

#### Step 1: First Run
1.  **Create a prompt**
2.  **Request execution from the AI**
3.  **Evaluate the result**

#### Step 2: Evaluate and Improve
1.  **Identify the difference from the expectation**
2.  **Analyze the problems in the prompt**
3.  **Design an improved version of the prompt**

#### Step 3: Rerun
1.  **Execute with the improved prompt**
2.  **Check the degree of improvement in the result**
3.  **Make further adjustments as needed**

### Practical Prompt Templates

#### Template for Feature Implementation
```
【Implementation Request】
Feature: [Specific feature name]
Tech Stack: [List of technologies used]
Requirements:
- [Requirement 1]
- [Requirement 2]
- [Requirement 3]

Constraints:
- [Constraint 1]
- [Constraint 2]

Expected Deliverables:
- Test cases
- Implementation code
- Documentation (if needed)
```

#### Template for Debugging
```
【Debugging Request】
Problem: [Specific problem description]
Error Message: [Actual error]
Steps to Reproduce:
1. [Step 1]
2. [Step 2]
3. [Step 3]

Relevant Code: [Problematic code]
Expected Behavior: [Intended behavior]
```

## Reviews and Quality Control

### Key Points for Human Review

#### 1. Check for Consistency with Specifications
- **Reflection of Design Intent**: Is the planned feature implemented correctly?
- **Coverage of Requirements**: Are all requirements met?
- **Adherence to Constraints**: Are the set constraints followed?

#### 2. Priority of Review Targets
1.  **Specification Document**: Consistency with requirements is most important.
2.  **Test Cases**: Appropriate coverage of the specifications.
3.  **Implementation Code**: Code quality and compliance with specifications.

#### 3. Review Checklist
- [ ] Are functional requirements met?
- [ ] Is error handling appropriate?
- [ ] Are security requirements considered?
- [ ] Are performance requirements met?
- [ ] Is test coverage sufficient?
- [ ] Is the code readable and maintainable?

### How to Deal with Cases Where the AI Doesn't Produce Expected Results

#### Fallback Strategy

**Basic Response Flow:**
1.  **`git reset`**: Revert to the previous state.
2.  **Prompt Adjustment**: Clarify and add detail to the instructions.
3.  **Rerun**: Retry with the same tool (Claude Sonnet 4).
4.  **Evaluate**: Check the degree of improvement in the result.

**When to `git reset`:**
-   When the final code deviates significantly from expectations.
-   When it's judged faster to start over than to request corrections.
-   When no improvement is seen after several correction attempts.

#### Prompt Adjustment Techniques

**Improving Specificity:**
```
# Before improvement
"Fix this code"

# After improvement
"Fix the following issues in this code:
1. Validation errors are not handled properly.
2. The return type differs from the specification.
3. Edge case tests are missing."
```

**Adding Context:**
```
# Before improvement
"Make an API"

# After improvement
"Create a RESTful API using Express.js:
- Endpoint: POST /api/users
- Request format: JSON
- Response format: JSON
- Use the existing User model
- Connected to MongoDB Atlas"
```

## Recording for Continuous Improvement

### Recording Success Patterns
```markdown
## Success Case Record

### Date: 2025-06-21
### Task: Implement User Authentication API
### Prompt Used:
[Specific prompt content]

### Result:
- Achieved the expected implementation in one shot.
- All tests passed 100%.

### Lessons Learned:
- Specifying the library for authentication is effective.
- It's important to specify security requirements in advance.
```

### Analyzing Failure Patterns
```markdown
## Improvement Case Record

### Date: 2025-06-21
### Task: Optimize a complex query
### Problem:
- The initial implementation did not meet performance requirements.
- No improvement after three correction attempts.

### Solution:
- Reverted to the initial state with `git reset`.
- Specified performance requirements numerically in the prompt.
- Provided a reference implementation example.

### Lessons Learned:
- Specify performance requirements quantitatively.
- Break down complex tasks into smaller pieces.
```

## Division of Use with Tools Other Than Claude Sonnet 4

### Detailed Collaboration with Gemini (for Research)

#### When to Use Gemini and Its Strengths
**When to Use:**
- Researching new libraries
- Reading large amounts of technical documentation
- Research tasks that require a long context
- Integrating information from multiple sources

**Gemini's Unique Strengths:**
- **Long Context**: Can process a large amount of information at once.
- **Information Gathering Ability**: Effectively integrates information from multiple sources.
- **Specialized for Research**: Excellent performance for deep dives into technical information.

#### Practical Collaboration Workflow

**Basic Collaboration Pattern:**
```
1. Identify research topic → Gather information with Gemini
2. Organize and summarize information → Analyze with Gemini
3. Formulate implementation plan → Provide information to Claude Sonnet 4
4. Execute AITDD → Consistent implementation by Claude Sonnet 4
```

**Specific Examples of Collaboration:**

**Example 1: Introducing a New Framework**
```
Gemini:
"Research the new features of Next.js 14 and organize the migration method from an existing Express.js application."

↓ Provide research results to Claude Sonnet 4

Claude Sonnet 4:
"Based on Gemini's research results, create a TODO list for a phased migration plan and implement the first feature with AITDD."
```

**Example 2: Deep Dive into Technical Specifications**
```
Gemini:
"Research the combination of OAuth 2.0 and JWT authentication, focusing on security best practices and implementation patterns."

↓ Organize security requirements and provide them to Claude Sonnet 4

Claude Sonnet 4:
"Based on the research results, create test cases for a secure authentication system and implement it using the AITDD method."
```

#### Criteria for Deciding Which Tool to Use

**When to use Gemini:**
- [ ] Initial research of new technologies/libraries
- [ ] When comparison of multiple options is needed
- [ ] When reading long technical documents is required
- [ ] When organizing complex requirements is necessary
- [ ] When researching prior examples is needed

**When to use Claude Sonnet 4:**
- [ ] Specific implementation work
- [ ] Creating test cases
- [ ] Code reviews and quality checks
- [ ] Debugging and troubleshooting
- [ ] Refactoring work

### Practical Operational Know-How

#### Advanced Techniques for Prompt Design

**Context Continuation Technique:**
```
# At the start of a session
"Please remember the following project configuration:
- Express.js + MongoDB + Jest
- User authentication feature is already implemented
- This time, the goal is to add a user profile management feature"

# Reference in a continuing session
"Based on the project configuration I just told you,
please create test cases for the profile update API."
```

**Phased Detailing Technique:**
```
# Phase 1: High-level
"Please think about the overall design of the user management system."

# Phase 2: Feature-level
"From the previous design, please create detailed specifications for the profile update feature."

# Phase 3: Implementation-level
"Based on the specifications, please implement the test cases and the API endpoint."
```

#### Advanced Strategies for Error Handling

**Pattern Analysis of Prompt Adjustments:**

**Pattern 1: Failure due to lack of specificity**
```
# Failure example
"Make an API"
→ Implementation very different from what was expected

# Success example
"Create a POST /api/users/profile API with Express.js:
- Request: {name, email, bio}
- Validation: email format, name required
- Response: Updated user information
- Error Handling: Handle 400, 401, 500"
```

**Pattern 2: Failure due to unspecified technical constraints**
```
# Failure example
"Write the database operation code"
→ Implementation with an ORM that is not being used

# Success example
"Implement the update operation for the User schema using Mongoose 7.x:
- Use the existing User model
- Use the findByIdAndUpdate method
- Handle validation errors appropriately"
```

**Practical Checklist for Prompt Adjustment:**
- [ ] Specify the tech stack being used
- [ ] Specifically define input/output formats
- [ ] Instruct to consider error cases
- [ ] Ensure consistency with existing code
- [ ] Specify performance requirements
- [ ] Instruct on security considerations

#### Recording Method for Continuous Improvement

**Templating Success Patterns:**
```markdown
## Prompt Template: API Implementation

### Basic Format
"Implement a [HTTP Method] [Endpoint] API with [Framework Name]:
- Request format: [Details]
- Response format: [Details]
- Validation: [Requirements]
- Error Handling: [Status codes to handle]
- Use the existing [Model Name] model"

### Application Example
[Specific usage example]

### Expected Result
[Output pattern upon success]
```

**Analysis Record of Failure Patterns:**
```markdown
## Improvement Record: [Date]

### Problematic Prompt
[Original prompt]

### Problem that Occurred
- [Specific problem 1]
- [Specific problem 2]

### Improved Prompt
[Revised prompt]

### Points of Improvement
- [Improvement point 1]
- [Improvement point 2]

### Future Application Guidelines
[How to apply to other cases]
```

### Details on Comparison with Other AI Tools

**Why consolidate on Claude Sonnet 4:**

**1. Importance of Consistency**
- A unified approach with the same tool
- Learned optimizations have a cumulative effect
- Knowledge of tool-specific quirks and limitations accumulates

**2. Maximizing Learning Efficiency**
- Efficiency improves by mastering one tool
- Know-how in prompt design deepens
- Accumulation of error patterns and their solutions

**3. Simplification of Cost Management**
- A single tool is easier to manage than multiple tools
- Simplification of budget planning
- Centralized monitoring of usage

**4. Simplicity of the Fallback Strategy**
- Avoids complex decision logic
- No need to decide "which tool to retry with"
- Enables rapid problem resolution

**Benefits of Tool Consolidation:**
```
Item                     Consolidated    Multiple Tools
─────────────────────────────────────────────────────
Learning Cost            Low               High
Prompt Optimization Eff. High              Low
Cost Mgmt Complexity     Low               High
Fallback Decision        Simple            Complex
Knowledge Accum. Eff.    High              Dispersed
─────────────────────────────────────────────────────
Overall Dev. Efficiency  Optimized         Inefficient
```

### Future-Proofing the AI Tool Environment

#### Policy for Responding to New Technologies
**Systematization of Evaluation Criteria:**
- **Performance Evaluation**: Compare performance in the existing workflow
- **Cost Analysis**: Evaluate the total cost of ownership (including learning cost)
- **Integration Evaluation**: Compatibility with the current development environment
- **Migration Cost**: Estimate the cost associated with changing tools

**Phased Introduction Approach:**
1.  **Information Gathering Period**: 3-6 month observation period
2.  **Small-scale Test**: Trial on non-critical projects
3.  **Comparative Evaluation**: Quantitative comparison of performance and efficiency
4.  **Phased Migration**: Cautious migration after confirming a clear advantage

**Quantification of Decisions:**
```
Threshold for adopting a new tool:
- Performance improvement: 20% or more
- Cost reduction: 15% or more
- Learning cost: Within 2 weeks
- Integration cost: 50% or less of the current tool
```

## Next Steps

Now that you understand how to use Claude Sonnet 4, let's build a comprehensive development environment for practicing AITDD in the next chapter, "2.3 Building a Development Environment and Workflow". We will establish a systematic development process, from TODO management to the Git workflow.
