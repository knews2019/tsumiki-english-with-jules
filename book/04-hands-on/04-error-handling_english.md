# 4.4 Error Handling and Debugging

## Learning Objectives

In this chapter, you will learn how to deal with various errors that occur during AITDD development and effective debugging techniques:

- Understanding error patterns specific to AI-generated code
- Identifying and correcting errors caused by prompts
- Establishing an efficient debugging process
- Deciding when to switch to manual implementation and practicing it
- Best practices for error prevention

## Error Classification and Response Strategies

In AITDD development, different types of errors occur compared to traditional development. It is important to classify them appropriately and apply corresponding countermeasures.

### Basic Error Classification

**1. Prompt-induced Errors**
- Caused by ambiguity in instructions
- Caused by unclear requirements
- Caused by lack of context

**2. AI Implementation-induced Errors**
- Bugs in AI-generated code
- Consistency issues with existing code
- Performance issues

**3. Integration-induced Errors**
- Problems when integrating multiple features
- Interface inconsistencies
- Dependency problems

**4. Traditional Errors**
- General programming errors
- Environment configuration problems
- External dependency problems

## Practical Debugging Process

### Step 1: Comprehensive Collection of Error Information

When an error occurs, first collect information systematically.

**Information to Collect**:
```markdown
## Error Information Collection Checklist

### Basic Information
- [ ] Error message (full version)
- [ ] Stack trace
- [ ] Time of occurrence
- [ ] Execution environment

### Contextual Information
- [ ] Command that was executed
- [ ] Input data
- [ ] Expected behavior
- [ ] Actual behavior

### AI-related Information
- [ ] The prompt that was used
- [ ] The relevant part of the AI-generated code
- [ ] Related existing code

### Execution Environment
- [ ] OS/browser information
- [ ] Node.js/TypeScript version
- [ ] State of dependent packages
```

**Practical Example of Information Collection**:
```
Example of a record when an error occurs:

Error Message:
TypeError: Cannot read property 'map' of undefined
    at getAllTasks (TaskController.ts:15)
    at Router.handle (express/lib/router/layer.js:95)

Time of Occurrence:
During the test execution of the GET /api/tasks endpoint

Input Data:
GET http://localhost:3000/api/tasks

Expected Behavior:
A response including an empty array should be returned.

Actual Behavior:
Error calling map on undefined.

Prompt Used:
"Please implement an API endpoint that calls the getAllTasks method of the TaskManager class and returns the response."
```

### Step 2: Cause Analysis by AI

Pass all the collected information to the AI and request a cause analysis of the error.

**Effective Analysis Prompt**:
```
Please analyze the cause of the following error:

## Error Information
[Paste all collected error information]

## Related Code
[The entire source code where the error occurred]

## Analysis Request
1. The direct cause of the error
2. The root cause (design/implementation problem)
3. The possibility of it being caused by the prompt
4. A proposal for a correction policy
5. Preventive measures for similar errors

Please provide an analysis that is as specific and practical as possible.
```

**Example of Analysis by AI**:
```
## Error Analysis Results

### Direct Cause
In the TaskController.getAllTasks method, taskManager.getAllTasks() is returning undefined.

### Root Cause
1. A problem with the instantiation of the TaskManager class.
2. The task array is not initialized in the implementation of the getAllTasks method.

### Possibility of Being Caused by the Prompt
The instruction "use the existing TaskManager class" was ambiguous, and it's possible that the implementation was done without checking the actual class definition.

### Correction Policy
1. Confirm the initialization of the TaskManager class.
2. Validate the return value of the getAllTasks method.
3. Add a null/undefined check.

### Preventive Measures
1. Include details of existing code in the prompt.
2. Strengthen the type safety of return values.
3. Add null/undefined cases in unit tests.
```

### Step 3: Phased Investigation and Hypothesis Testing

Based on the AI's analysis, investigate the problem in phases.

**Example Investigation Procedure**:
```typescript
// 1. Check the state of the TaskManager class
describe('TaskManager Debugging', () => {
  test('TaskManager instantiation confirmation', () => {
    const manager = new TaskManager();
    console.log('TaskManager instance:', manager);
    expect(manager).toBeDefined();
  });

  test('getAllTasks return value confirmation', () => {
    const manager = new TaskManager();
    const result = manager.getAllTasks();
    console.log('getAllTasks result:', result);
    console.log('result type:', typeof result);
    expect(result).toBeDefined();
  });

  test('Check the initial state of the task array', () => {
    const manager = new TaskManager();
    const tasks = manager.getAllTasks();
    expect(Array.isArray(tasks)).toBe(true);
    console.log('Initial tasks array:', tasks);
  });
});
```

**Executing the Debug**:
```bash
npm test -- --verbose TaskManager Debugging
```

### Step 4: Collaborative Correction Implementation with AI

Provide feedback on the investigation results to the AI and request a corrected implementation.

**Correction Request Prompt**:
```
As a result of the debugging investigation, the following was found:

## Investigation Results
[Output results of the debug test]

## Identified Problems
1. Improper array initialization in the TaskManager class.
2. The return value of the getAllTasks method is undefined.

## Correction Request
Please implement a correction that satisfies the following:
1. The array is properly initialized.
2. Type safety is ensured.
3. A null/undefined check is added.
4. Existing tests pass.
5. New test cases are also added.

Please also provide the corrected code and an explanation of the corrections.
```

## Identifying and Correcting Prompt-induced Errors

### Criteria for Judging Prompt Problems

**Judgment by Frequency**:
```
Occurrence status of a similar error pattern:
- 1st time: Treat as an implementation error.
- 2nd time: Consider the possibility of a prompt problem.
- 3rd time: Prompt correction is mandatory.
```

**Typical Signs of Prompt Problems**:
- Different implementations are generated for the same request.
- Output that is very different from what was expected.
- Unintentionally modifies existing code.
- Implementation that goes beyond the scope of the instructions.

### The Process of Correcting Prompt Problems

#### 1. Prompt Diagnosis

**Requesting Diagnosis from the AI**:
```
Please analyze the following prompt and point out any problems:

## Prompt Used
[The problematic prompt]

## Expected Result
[The expected output]

## Actual Result
[The actual output]

## Diagnosis Request
1. Ambiguous parts of the prompt
2. Missing information
3. Expressions that could be misleading
4. Suggestions for improvement
```

#### 2. Creating a Prompt Improvement Plan

**Example of an Improved Prompt**:
```
Before Improvement (Problematic Prompt):
"Create an API endpoint using the TaskManager class."

After Improvement:
"Please implement the GET /api/tasks endpoint using the following existing TaskManager class.

Existing Code:
[The complete code of the TaskManager class]

Requirements:
1. Do not change any of the existing code.
2. Use the Express.js Router.
3. Response format: { success: boolean, data: Task[] }
4. Include error handling.
5. Ensure TypeScript type safety.

Output Format:
- routes/tasks.ts file
- controllers/TaskController.ts file
- The corresponding test file"
```

#### 3. Verifying the Improved Prompt

**Verification Process**:
```typescript
describe('Prompt Improvement Verification', () => {
  test('Reproduce the problem with the unimproved prompt', async () => {
    // Request implementation with the problematic prompt
    // Confirm that the expected problem occurs
  });

  test('Confirm resolution with the improved prompt', async () => {
    // Request implementation with the improved prompt
    // Confirm that the problem is resolved
  });

  test('Check for side effects of the improved prompt', async () => {
    // Confirm that the improvement has not caused new problems
  });
});
```

## Deciding When to Switch to Manual Implementation

### Deciding on the Switching Timing

**Judgment before starting implementation**:
```markdown
## Manual Implementation Consideration Checklist

### Presence of an Implementation Image
- [ ] Can you think of specific implementation steps?
- [ ] Are the technologies/libraries to be used clear?
- [ ] Can you predict the pitfalls of the implementation?

### Technical Complexity
- [ ] Is performance optimization necessary?
- [ ] Is a complex algorithm necessary?
- [ ] Is deep domain knowledge necessary?

### Difficulty of Explaining to AI
- [ ] Can't clearly verbalize the requirements?
- [ ] The prompt becomes unusually long?
- [ ] Difficult to explain the prerequisite knowledge?
```

**Judgment to switch during implementation**:
```
Criteria for the switching judgment:
1. The same error occurs 3 or more times.
2. It is not resolved even with prompt correction.
3. The debugging time exceeds the implementation time.
4. The quality of the AI-generated code is inconsistent.
```

### Effective Manual Implementation Approach

#### Phased AI Combination Strategy

**Partial AI utilization, not fully manual**:
```typescript
// 1. Manually implement complex logic parts
const complexAlgorithm = (data: any[]) => {
  // Manually implement (parts difficult to explain to AI)
  let result = [];
  for (let i = 0; i < data.length; i++) {
    // Complex calculation logic
  }
  return result;
};

// 2. Request standard code from the AI
const generateApiResponse = (data: any) => {
  // This part can be generated by AI
  return {
    success: true,
    data,
    meta: {
      timestamp: new Date().toISOString(),
      count: Array.isArray(data) ? data.length : 1
    }
  };
};

// 3. Combine for the final implementation
export const processData = async (inputData: any[]) => {
  try {
    const processedData = complexAlgorithm(inputData); // Manual part
    return generateApiResponse(processedData); // AI-generated part
  } catch (error) {
    // Error handling can also be supported by AI
  }
};
```

#### Utilizing AI Support in Manual Implementation

**1. Utilizing IDE completion features**:
```typescript
// Actively use AI completion in VS Code, etc.
const taskManager = new TaskManager();
// ↑ Utilize AI completion where it is effective here
```

**2. Requesting partial code generation**:
```
Example of an AI request for a part where you have a clear implementation image:

"Please create a validation function based on the following type definition:

interface TaskInput {
  title: string;
  description?: string;
}

Requirements:
- title is required, 1-100 characters
- description is optional, 0-500 characters
- A specific error message for invalid cases
- Function as a TypeScript type guard"
```

#### Continuation of the Quality Process

**The Validation step is mandatory even for manual implementation**:
```
Validation checklist for manual implementation:
1. Consistency with specification requirements
2. Ensuring type safety
3. Appropriateness of error handling
4. Confirmation of test coverage
5. Appropriateness of performance
6. Readability/maintainability of the code
```

## Best Practices for Error Prevention

### Improving Prompt Design

**1. Clarifying the Context**:
```
Good prompt example:

"Please add a new feature to the following existing system:

Existing Code:
[Paste all relevant code]

New Feature Requirements:
[Specific and clear requirements]

Constraints:
- Do not change existing code
- Ensure TypeScript type safety
- Error handling is mandatory

Expected Output:
- Implementation code
- Test code
- Usage examples
- Points to note"
```

**2. Phased Implementation Instructions**:
```
Phased implementation of a complex feature:

"Please implement the following in phases:

Step 1: Interface design
Step 2: Basic implementation
Step 3: Error handling
Step 4: Test creation

Please proceed while checking with me at each step."
```

### Strengthening the Test Strategy

**1. Tests specific to AI-generated code**:
```typescript
describe('AI-generated code verification test', () => {
  test('Confirm that there are no unintentional modifications to existing code', () => {
    // Test that important existing functions have not been changed
    const originalFunction = require('./legacy/original-module');
    expect(originalFunction.criticalMethod).toBeDefined();
    expect(typeof originalFunction.criticalMethod).toBe('function');
  });

  test('Check the scope of implementation by guessing', () => {
    // Check that the part implemented by AI's guessing is within the requirements
    const implementation = new FeatureImplementation();
    expect(implementation.getImplementedFeatures())
      .toEqual(expect.arrayContaining(REQUIRED_FEATURES));
  });

  test('Check for type safety', () => {
    // Test that TypeScript's type checking works correctly
    // Test that no compilation errors occur
  });
});
```

**2. Strengthening integration tests**:
```typescript
describe('Feature integration test', () => {
  test('Confirm regression in the integration of 3 features', async () => {
    // Test that the 3 features work correctly even when combined
    const feature1 = await executeFeature1();
    const feature2 = await executeFeature2(feature1.result);
    const feature3 = await executeFeature3(feature2.result);

    expect(feature3.result).toMatchExpectedOutput();
  });
});
```

### Continuous Improvement Process

**1. Accumulating error patterns**:
```markdown
## Error Pattern Management

### Frequently Occurring Errors
1. undefined/null access error
   - Cause: Insufficient initialization in AI-generated code
   - Countermeasure: Explicit initialization instructions

2. Type mismatch error
   - Cause: Insufficient type information in the prompt
   - Countermeasure: Explicitly provide type definitions

3. Existing code modification error
   - Cause: Incomplete "do not change" instruction
   - Countermeasure: Specific constraint instructions
```

**2. Improving prompt templates**:
```
Improved prompt template:

### Basic Template
```
Feature: [Feature Name]
Implementation Target: [Specific implementation content]

Existing Code:
[All relevant code]

Requirements:
[Clear and specific requirements]

Constraints:
- Do not change existing code
- [Other constraints]

Output Requirements:
- [Expected output format]

Quality Requirements:
- TypeScript type safety
- Error handling
- Including test code
```

## Practical Debugging Techniques

### Log-based Debugging

**Effective Log Output**:
```typescript
// Debugging log helper
class DebugLogger {
  static log(context: string, data: any) {
    if (process.env.NODE_ENV === 'development') {
      console.log(`[${context}]`, {
        timestamp: new Date().toISOString(),
        data: JSON.stringify(data, null, 2)
      });
    }
  }

  static error(context: string, error: any) {
    console.error(`[ERROR:${context}]`, {
      message: error.message,
      stack: error.stack,
      timestamp: new Date().toISOString()
    });
  }
}

// Usage example
export const taskController = {
  getAllTasks: async (req, res, next) => {
    try {
      DebugLogger.log('TaskController.getAllTasks', 'Starting execution');

      const tasks = taskManager.getAllTasks();
      DebugLogger.log('TaskController.getAllTasks', { tasksCount: tasks?.length });

      const response = generateResponse(tasks);
      DebugLogger.log('TaskController.getAllTasks', { response });

      res.json(response);
    } catch (error) {
      DebugLogger.error('TaskController.getAllTasks', error);
      next(error);
    }
  }
};
```

### Test-Driven Debugging

**Working backward from a failing test**:
```typescript
describe('Bug reproduction test', () => {
  test('Reproduce null error under specific conditions', () => {
    // Identify the minimal conditions under which the bug occurs
    const manager = new TaskManager();
    const result = manager.getAllTasks();

    // An error should occur at this point
    expect(() => result.map(x => x.id)).toThrow();
  });

  test('Confirm operation after correction', () => {
    // Test the expected behavior after correction
    const manager = new TaskManager();
    const result = manager.getAllTasks();

    expect(Array.isArray(result)).toBe(true);
    expect(() => result.map(x => x.id)).not.toThrow();
  });
});
```

## Summary

In this chapter, we learned comprehensive error handling and debugging techniques in AITDD development:

**Major Learning Outcomes**:
- Appropriate classification and countermeasures for errors
- An efficient debugging process utilizing AI
- Identifying and correcting prompt-induced errors
- Deciding when to switch to manual implementation and the AI combination strategy
- Best practices for error prevention

**Practical Skills**:
- Comprehensive information gathering techniques
- Error analysis in collaboration with AI
- A phased problem-solving approach
- Continuous improvement of quality control

**Preparation for the Next Chapter**:
With these skills, you are ready to learn more advanced AITDD methods and optimization techniques. We will proceed to prompt design and AI utilization optimization.

Through the AITDD practical hands-on series, you have acquired a full range of skills from basic to applied. In the next part, we will refine these techniques further and learn advanced techniques for utilizing them in a real production environment.
