# 4.1 Your First AITDD Project

## Learning Objectives

In this chapter, you will learn the following through a first project where you can experience the basic flow of AITDD:

- Understand the overall flow of the AITDD process
- Practice the series of steps from TODO creation to implementation completion
- Experience the appropriate balance between AI support and human review
- Realize the effects of AITDD with a small-scale feature

## Project Selection Criteria

### Characteristics Suitable for a First Project

**Implementation Scope**:
- A small-scale feature that can be completed in about 30 minutes to 1 hour
- A simple process with a single responsibility
- A highly independent feature with few external dependencies

**Technical Complexity**:
- Use a familiar technology stack
- Content for which you can imagine the implementation method
- A process that is relatively easy to debug

**Learning Effect**:
- You can experience each step of AITDD
- Content that makes it easy to have a successful experience
- A feature that can serve as a foundation for later expansion

### Recommended Project Examples

**1. Simple Calculation Feature**
```
Example: Tax-included price calculator
- Input: Product price, tax rate
- Output: Tax-included price, tax amount
- Process: Basic numerical calculation
```

**2. Data Conversion Feature**
```
Example: Format conversion of CSV data
- Input: CSV string
- Output: JSON format data
- Process: Parsing and conversion logic
```

**3. Validation Feature**
```
Example: Email address validation
- Input: String
- Output: Validation result (boolean)
- Process: Format check with regular expressions
```

## Practical Hands-On: Tax-Included Price Calculator

In this example, you will learn the AITDD process by implementing a tax-included price calculator.

### Step 1: Create TODO

Create a `todo.md` file in your project and clarify the feature to be implemented.

```markdown
# TODO: Implement a tax-included price calculator

## Feature to be implemented
- [ ] A function to calculate the tax-included price from the product price and tax rate
- [ ] A function to calculate the tax amount
- [ ] Validation of input values
- [ ] Error handling (negative values, null values, etc.)

## Completion Criteria
- Calculations with normal values work correctly
- Appropriate error handling for abnormal values
- Achieve 100% test coverage
```

**Key Points**:
- Break down the feature concretely
- Clarify the completion criteria
- Adjust the granularity to be completable in 30 minutes to 1 hour

### Step 2: Create Specifications

Create detailed specifications based on the TODO in collaboration with the AI.

**Example Prompt for AI**:
```
Please create a detailed specification document from the following TODO:

[Paste the content of todo.md]

Please include the following in the specification document:
- Function signatures (arguments, return values)
- Constraints on input values
- Error conditions and responses
- Details of the calculation logic
```

**Expected Specification Document (Example)**:
```markdown
# Tax-Included Price Calculator Specification

## Function Specifications

### calculateTaxIncludedPrice(price: number, taxRate: number): number
- Calculates the tax-included price from the product price and tax rate
- Arguments:
  - price: Product price (a number greater than or equal to 0)
  - taxRate: Tax rate (a decimal between 0 and 1, e.g., 0.1 = 10%)
- Return value: Tax-included price (rounded to the first decimal place)

### calculateTax(price: number, taxRate: number): number
- Calculates the tax amount
- Arguments and return value are the same as above
- Return value: Tax amount (rounded to the first decimal place)

## Error Handling
- Negative price: Error("Price must be greater than or equal to 0")
- Tax rate out of range: Error("Tax rate must be between 0 and 1")
- null/undefined: Error("Please enter a valid number")
```

**Checkpoints for Human Review**:
- [ ] Is the intent of the TODO correctly reflected?
- [ ] Is the scope of responsibility for the functions appropriate?
- [ ] Are the error conditions covered?
- [ ] Is the content implementable?

### Step 3: Create Test Cases

Have the AI create test cases based on the specification document.

**Example Prompt for AI**:
```
Please create comprehensive test cases based on the following specification document:

[Paste the content of the specification document]

Please create test cases from the following perspectives:
- Happy Path: Check the operation with general values
- Boundary Values: Check the operation at boundaries such as 0 and 1
- Sad Path: Check the operation of error conditions
- Test framework: Use Jest
```

**Example of Generated Test Cases**:
```typescript
import { calculateTaxIncludedPrice, calculateTax } from './taxCalculator';

describe('Tax-Included Price Calculator', () => {
  describe('calculateTaxIncludedPrice', () => {
    // Happy Path
    test('General tax-included price calculation', () => {
      expect(calculateTaxIncludedPrice(1000, 0.1)).toBe(1100);
      expect(calculateTaxIncludedPrice(150, 0.08)).toBe(162);
    });

    // Boundary Values
    test('when price is 0', () => {
      expect(calculateTaxIncludedPrice(0, 0.1)).toBe(0);
    });

    test('when tax rate is 0', () => {
      expect(calculateTaxIncludedPrice(1000, 0)).toBe(1000);
    });

    // Sad Path
    test('error with a negative price', () => {
      expect(() => calculateTaxIncludedPrice(-100, 0.1))
        .toThrow('Price must be greater than or equal to 0');
    });

    test('error when tax rate is out of range', () => {
      expect(() => calculateTaxIncludedPrice(1000, -0.1))
        .toThrow('Tax rate must be between 0 and 1');
      expect(() => calculateTaxIncludedPrice(1000, 1.1))
        .toThrow('Tax rate must be between 0 and 1');
    });
  });

  describe('calculateTax', () => {
    test('tax amount calculation', () => {
      expect(calculateTax(1000, 0.1)).toBe(100);
      expect(calculateTax(150, 0.08)).toBe(12);
    });
  });
});
```

**Checkpoints for Human Review**:
- [ ] Does it cover all the requirements of the specification?
- [ ] Is the testing of the sad path appropriate?
- [ ] Are the expected values of the tests correct?
- [ ] Are there any test cases that should be added?

### Step 4: The Red-Green-Refactor-Validation Cycle

#### 4.1 Red (Test Fails)

Run the tests and confirm the expected failure.

```bash
npm test
```

Expected Output:
```
FAIL  src/taxCalculator.test.ts
  ✕ calculateTaxIncludedPrice is not defined
  ✕ calculateTax is not defined
```

#### 4.2 Green (Minimal Implementation)

Request the minimal implementation from the AI.

**Example Prompt for AI**:
```
Please create the minimal implementation that passes the following test cases:

[Paste the test cases]

Requirements:
- Prioritize passing the tests above all else
- Do not make it overly complex
- Implement error handling appropriately
```

**Example of Generated Implementation**:
```typescript
export function calculateTaxIncludedPrice(price: number, taxRate: number): number {
  validateInputs(price, taxRate);
  const tax = calculateTax(price, taxRate);
  return Math.round((price + tax) * 10) / 10;
}

export function calculateTax(price: number, taxRate: number): number {
  validateInputs(price, taxRate);
  return Math.round((price * taxRate) * 10) / 10;
}

function validateInputs(price: number, taxRate: number): void {
  if (price < 0) {
    throw new Error('Price must be greater than or equal to 0');
  }
  if (taxRate < 0 || taxRate > 1) {
    throw new Error('Tax rate must be between 0 and 1');
  }
}
```

Run tests:
```bash
npm test
# Confirm that all tests pass
```

#### 4.3 Refactor (Refactoring)

Request code improvement from the AI.

**Example Prompt for AI**:
```
Please refactor the following code:

[Paste the implementation code]

Points for improvement:
- Improve code readability
- Divide function responsibilities
- Optimize performance
- Improve TypeScript type safety
```

#### 4.4 Validation (Verification)

Have the AI verify the validity of the implementation.

**Example Prompt for AI**:
```
Please comprehensively verify the following implementation:

[Paste the refactored code]
[Also paste the test cases]

Verification perspectives:
- Consistency with specification requirements
- Code quality (readability, maintainability)
- Appropriateness of test coverage
- Potential problems
- Performance concerns
```

### Step 5: Final Review

**Checkpoints for Human Review**:

**Functional Aspect**:
- [ ] All tests are passing
- [ ] Specification requirements are met
- [ ] Error handling is appropriate

**Code Quality**:
- [ ] High readability
- [ ] Appropriate function division
- [ ] Follows naming conventions
- [ ] Appropriate TypeScript type definitions

**Maintainability**:
- [ ] A structure that is easy to extend
- [ ] Tests are easy to maintain
- [ ] Documentation is appropriate

## Retrospective and Learning Points

### Success Patterns

**Process Adherence**:
- Execute each step without skipping
- Reliably perform human reviews
- Do not take AI output at face value

**Appropriate AI Utilization**:
- Use clear and specific prompts
- Provide sufficient context
- Specify the expected output format

### Common Failure Patterns and Countermeasures

**Failure 1: Ambiguous Prompts**
```
❌ Bad Example: "Make a tax calculation function"
✅ Good Example: "Please create a function to calculate the tax-included price from the product price and tax rate, according to the following specifications: [Detailed specifications]"
```

**Failure 2: Skipping Human Review**
```
❌ Problem: Using the AI's output as is
✅ Countermeasure: Always check for consistency with the specifications
```

**Failure 3: Insufficient Test Design**
```
❌ Problem: Only happy path tests
✅ Countermeasure: Comprehensive tests including boundary values and sad paths
```

### Preparation for the Next Step

The sense you should acquire in this first project:
- The rhythm of collaborative development with AI
- The importance of quality control
- The basics of prompt design
- Understanding of review points

Next chapter, you will acquire the applied skills of AITDD by implementing more complex CRUD operations.

## Summary

In your first AITDD project, emphasize the following:

1.  **Gaining a Successful Experience**: Experience the complete process, even on a small scale.
2.  **Establishing Basic Habits**: Understand the importance of each step.
3.  **A Sense of AI Utilization**: The basics of appropriate prompt design.
4.  **Fostering a Quality Mindset**: Realize the value of human reviews.

Having this foundation will enable you to effectively utilize AITDD in more complex projects.
