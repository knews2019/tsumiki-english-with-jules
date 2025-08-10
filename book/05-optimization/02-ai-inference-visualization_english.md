# 5.2 AI Inference Visualization Technology

## Introduction

In the quality control of AI-generated code, the most important thing is to clearly grasp which parts the AI has "inferred". By using AI inference visualization technology with a traffic light system, you can achieve efficient reviews and high-quality assurance.

## Theoretical Background of the Traffic Light System

### Identifying the Challenge

AI-generated code has the following characteristics:

- **Wide Range of Autocompletion**: AI automatically completes parts that are not explicitly stated.
- **The "Looks Good" Trap**: The generated content may seem reasonable but may differ from the actual intent.
- **Unclear Basis for Inference**: It is unclear on what information the generation was based.

### Solution Approach

The traffic light system clarifies the review priority by classifying AI-generated content based on the following criteria:

```
🟢 Green Light → 🟡 Yellow Light → 🔴 Red Light
  Safe          Caution        Danger
```

## Detailed Definition of the Traffic Light System

### 🟢 Green Light (High Confidence/Safe)

**Definition:** Content that can be clearly inferred from the referenced source files.

**Characteristics:**
- Generation based on content explicitly stated in the original instructions or specifications.
- Implementation that follows the patterns of existing code.
- Implementation decisions with a clear basis.

**Specific Example:**
```javascript
// When it is clearly stated in the specification that "User ID is required"
function validateUser(userId) {
  if (!userId) {  // 🟢 Clearly derived from the specification
    throw new Error('User ID is required');
  }
}
```

**Review Priority:** Low
**Confirmation Points:** Accuracy of implementation, performance impact.

### 🟡 Yellow Light (Medium Confidence/Caution)

**Definition:** Content that is not in the referenced source files but is considered reasonable.

**Characteristics:**
- Complemented by the AI's reasonable inference.
- Implementation based on general best practices.
- Inference utilizing domain knowledge.

**Specific Example:**
```javascript
// Error handling when there are no details in the specification
function processData(data) {
  try {
    return transform(data);
  } catch (error) {  // 🟡 General but requires confirmation
    console.error('Data processing failed:', error);
    return null;
  }
}
```

**Review Priority:** High
**Confirmation Points:** Validity of the inference, consistency with business requirements.

### 🔴 Red Light (Judgment Required/Danger)

**Definition:** Content that is not in the referenced source files and cannot be directly inferred.

**Characteristics:**
- Generation based on the AI's independent judgment.
- Assumption of organization-specific customs or rules.
- Implementation choices without a clear basis.

**Specific Example:**
```javascript
// When there is no information about the organization's log format
function logUserAction(action) {
  // 🔴 The log format is organization-specific and requires confirmation
  logger.info(`[AUDIT] User performed: ${action} at ${new Date().toISOString()}`);
}
```

**Review Priority:** Highest
**Confirmation Points:** Consistency with organizational rules, security impact.

## Implementation Method and TODO File Format

### Standard TODO File Format

```markdown
## [Step Name] Result TODO

### 🟢 High Confidence Items
- [ ] Confirm that the type definition in [utils.js](./src/utils.js) matches the specification.
- [ ] Confirm the implementation of the required field check in [validation.js](./src/validation.js).

### 🟡 Medium Confidence Items
- [ ] Confirm the validity of the error response format in [error-handler.js](./src/error-handler.js).
- [ ] Confirm that the default value settings in [config.js](./src/config.js) comply with organizational policy.

### 🔴 Judgment Required Items
- [ ] Detailed confirmation: The log output format in [logger.js](./src/logger.js) complies with organizational standards.
- [ ] Detailed confirmation: The basis for selecting the session management method in [auth.js](./src/auth.js).
```

### How to Instruct in Prompts

**Basic Instruction Template:**
```markdown
## AI Inference Visualization Instruction

Please execute the following task and classify the generated content using the traffic light system:

**Task Content:**
[Specific task content]

**Classification Criteria:**
- 🟢 Green Light: Can be clearly derived from the reference file ([file_name]).
- 🟡 Yellow Light: Reasonable inference but not explicitly stated in the reference file.
- 🔴 Red Light: Generation based on independent judgment (organization-specific content, etc.).

**Output File:** `./todos/[step_name]-inference-check.md`

**Output Format:**
Add a traffic light mark to each generated item and create checklist items in TODO format.
```

### How to Manage Reference Source Files

**Recording File Relationships:**
```markdown
## Reference File Management

**Primary References:**
- [`requirements.md`](./docs/requirements.md) - Basic requirements definition
- [`api-spec.yaml`](./docs/api-spec.yaml) - API specification

**Secondary References:**
- [`existing-code/`](./src/existing/) - Existing implementation patterns
- [`config-samples/`](./config/) - Configuration file examples

**External References:**
- Technical documentation (official framework documentation)
- Industry standards (RFC, W3C, etc.)

**Tracking the Basis of Inference:**
- 🟢 items → Explicitly stated in primary references
- 🟡 items → Secondary references + general knowledge
- 🔴 items → Basis unclear/independent judgment
```

## Setting Check Priorities

### Priority Matrix

| Signal | High Impact | Medium Impact | Low Impact |
|---|---|---|---|
| 🔴 Red Light | **Highest Priority** | High Priority | Medium Priority |
| 🟡 Yellow Light | High Priority | Medium Priority | Low Priority |
| 🟢 Green Light | Medium Priority | Low Priority | **Postpone** |

### Impact Evaluation Criteria

**High Impact:**
- Implementations related to security
- Affects data integrity
- Affects the operation of the entire system

**Medium Impact:**
- Affects the operation of a specific feature
- Affects the user experience
- Affects performance

**Low Impact:**
- Log output or comments
- Internal variable names
- Supplementary features

### Practical Check Order

1.  **🔴×High Impact** - Immediately confirm and correct.
2.  **🔴×Medium Impact** and **🟡×High Impact** - Confirm before starting the next task.
3.  **Other 🔴 items** - Always confirm before completing the implementation.
4.  **🟡 items** - Confirm during review.
5.  **🟢 items** - Confirm during the final check.

## Practical Operation Examples and Case Studies

### Case Study 1: REST API Implementation

**Scenario:** Implementing a user management API
**Reference Files:** `user-api-spec.yaml`, `existing-user-model.js`

**Classification of AI Generation Results:**

```javascript
// 🟢 Endpoint specified in the API specification
app.post('/api/users', async (req, res) => {

  // 🟡 General validation, but details are not in the specification
  if (!req.body.email || !req.body.password) {
    return res.status(400).json({ error: 'Email and password required' });
  }

  // 🔴 The hashing algorithm depends on organization-specific policy
  const hashedPassword = bcrypt.hashSync(req.body.password, 12);

  // 🟢 Implementation that follows the pattern of the existing model
  const user = new User({
    email: req.body.email,
    password: hashedPassword
  });
});
```

**Generated TODO:**
```markdown
## API Implementation Result TODO

### 🟢 High Confidence Items
- [ ] Confirm that the endpoint definition in [user-controller.js](./src/controllers/user.js) matches the specification.
- [ ] Confirm that the existing pattern in [user-model.js](./src/models/user.js) is followed.

### 🟡 Medium Confidence Items
- [ ] Confirm the validity of the error message format in [validation.js](./src/middleware/validation.js).
- [ ] Confirm the selection of the status code in [user-controller.js](./src/controllers/user.js).

### 🔴 Judgment Required Items
- [ ] Detailed confirmation: The bcrypt salt rounds in [auth.js](./src/utils/auth.js) comply with organizational policy.
```

### Case Study 2: Test Case Generation

**Scenario:** Creating test cases for the above API
**Reference Files:** `user-api-spec.yaml`, `existing-test-patterns.js`

**Classification Results:**
```javascript
describe('User API', () => {
  // 🟢 Test case specified in the specification
  it('should create user with valid email and password', async () => {
    const response = await request(app)
      .post('/api/users')
      .send({ email: 'test@example.com', password: 'password123' });

    expect(response.status).toBe(201);  // 🟢 As per the specification
  });

  // 🟡 General edge case (not specified in the specification)
  it('should reject invalid email format', async () => {
    const response = await request(app)
      .post('/api/users')
      .send({ email: 'invalid-email', password: 'password123' });

    expect(response.status).toBe(400);  // 🟡 Based on inference
  });

  // 🔴 Inference based on organization-specific security requirements
  it('should enforce password complexity requirements', async () => {
    const response = await request(app)
      .post('/api/users')
      .send({ email: 'test@example.com', password: '123' });

    expect(response.status).toBe(400);  // 🔴 Depends on organizational policy
  });
});
```

## Effect Measurement and Improvement Methods

### Effect Measurement Indicators

**Quantitative Indicators:**
- Reduction rate of review time
- Improvement in bug detection rate
- Decrease in the number of corrections

**Qualitative Indicators:**
- Improved efficiency of reviews
- Prevention of overlooking important issues
- Improved developer confidence

### Example of Operational Data

```markdown
## Effect of Introducing the Traffic Light System (1 month)

**Traditional Review:**
- Average review time: 45 min/feature
- Bug detection rate: approx. 60%
- Oversights during review: 3-4 cases/month

**After Introducing the Traffic Light System:**
- Average review time: 25 min/feature (44% reduction)
- Bug detection rate: approx. 85% (25% improvement)
- Oversights during review: less than 1 case/month

**Typical Problems with 🔴 items:**
- Security-related: 40%
- Organizational policy violations: 35%
- Configuration/environment dependent: 25%
```

### Approach to Continuous Improvement

**1. Improving Classification Accuracy:**
```markdown
## Classification Criteria Improvement Log

**Week 1-2:**
- Problem: Ambiguous classification of log formats
- Improvement: Created a checklist for organization-specific items

**Week 3-4:**
- Problem: Unstable classification of error handling
- Improvement: Documented error handling patterns

**Month 2:**
- Problem: Difficulty classifying with a new technology stack
- Improvement: Created guidelines for each technology stack
```

**2. Prompt Optimization:**
```markdown
## Prompt Improvement Cycle

**Challenge before improvement:**
- Detection rate of 🔴 items was about 70%
- Classification was inconsistent

**Improvement Content:**
- Provided an explicit list of organization-specific items
- Added abundant examples of judgment criteria

**Effect after improvement:**
- Detection rate of 🔴 items improved to 90% or more
- Classification consistency improved significantly
```

## Practical Introduction Steps

### Step 1: Build the Basic System

```bash
# Prepare the project structure
mkdir -p todos
mkdir -p docs/inference-guides

# Create the basic template
cat > docs/inference-guides/classification-template.md << 'EOF'
## AI Inference Classification Template

### 🟢 Green Light Judgment Criteria
- Content explicitly stated in the reference file "[file_name]"
- Implementation that follows established patterns in existing code

### 🟡 Yellow Light Judgment Criteria
- Implementation based on general best practices
- Technically reasonable but not explicitly stated in the reference file

### 🔴 Red Light Judgment Criteria
- Depends on organization-specific policies or customs
- Independent judgment without a clear basis
EOF
```

### Step 2: Document Organization-specific Rules

```markdown
## Organization-specific Checkpoints

**Security-related:**
- [ ] Password hashing algorithm and strength
- [ ] Session management method
- [ ] API authentication method

**Logging/Auditing-related:**
- [ ] Log output format and level
- [ ] Audit log output items
- [ ] Log retention period and rotation

**Coding Standards:**
- [ ] Naming conventions (variables, functions, classes)
- [ ] Error handling patterns
- [ ] Commenting rules
```

### Step 3: Establish Team Operations

```markdown
## Team Operation Rules

**Responsibility for Classification Work:**
- The AI executor does the initial classification
- The reviewer confirms the validity of the classification

**Division of Check Work:**
- 🔴 items: Confirmed by a senior engineer
- 🟡 items: Pair-reviewed within the team
- 🟢 items: Automated tests + minor confirmation

**Knowledge Accumulation:**
- Weekly meeting to review classification criteria
- Sharing of misclassification patterns
- Documentation of improvement cases
```

## Troubleshooting

### Common Problems and Countermeasures

**Problem 1: Inconsistent classification**

```markdown
**Symptom:** Classification results differ for similar content.
**Cause:** Ambiguous classification criteria, unclear instructions in the prompt.
**Countermeasure:**
1. Create a more specific list of organization-specific items.
2. Include past classification examples in the prompt.
3. Record and standardize matters of judgment.
```

**Problem 2: Overlooking 🔴 items**

```markdown
**Symptom:** Important organization-specific items are classified as 🟡 or 🟢.
**Cause:** The AI does not understand the organization's context.
**Countermeasure:**
1. Provide an explicit list of organization-specific items.
2. Set a principle to "classify as 🔴 if in doubt."
3. Check the validity of the classification by a reviewer.
```

**Problem 3: Too many TODO items**

```markdown
**Symptom:** The number of generated TODO items exceeds a manageable range.
**Cause:** Classification is too detailed, impact assessment is too lenient.
**Countermeasure:**
1. Group similar items.
2. Stricter impact assessment.
3. Introduction of an "Importance × Urgency" matrix.
```

## Practical Exercises

### Exercise 1: Creating Classification Criteria

Classify the following code snippet using the traffic light system:

```javascript
function authenticateUser(username, password) {
  // Case 1: Check if user exists
  const user = await User.findOne({ username });
  if (!user) {
    return { success: false, message: 'User not found' };
  }

  // Case 2: Password verification
  const isValid = await bcrypt.compare(password, user.hashedPassword);
  if (!isValid) {
    return { success: false, message: 'Invalid password' };
  }

  // Case 3: JWT token generation
  const token = jwt.sign(
    { userId: user.id, role: user.role },
    process.env.JWT_SECRET,
    { expiresIn: '24h' }
  );

  // Case 4: Log output
  console.log(`User ${username} authenticated successfully at ${new Date().toISOString()}`);

  return { success: true, token };
}
```

**Reference File:** `auth-spec.md` (describes only the basic authentication flow)

### Exercise 2: Setting TODO Item Priorities

Based on the classification results above, arrange the TODO items in order of priority.

## Summary

With AI inference visualization technology, you can achieve the following effects:

1.  **Efficient Reviews**: Quality checks focused on important areas.
2.  **Risk Mitigation**: Reliable discovery of high-risk inferred parts.
3.  **Knowledge Accumulation**: Documentation and sharing of organization-specific judgment criteria.
4.  **Continuous Improvement**: Optimization of classification criteria and prompts based on data.

The traffic light system is an important technology for balancing the human factor and AI support in AITDD. In the next section, we will learn about continuous improvement and prompt optimization utilizing these technologies.
