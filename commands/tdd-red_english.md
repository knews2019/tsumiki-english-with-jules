# TDD Red Phase (Write a Failing Test)

Executes the Red phase of TDD.

## Prerequisites

Prepare the development context:

1.  **Search for test implementation-related information with @agent-symbol-searcher and read the found files.**
    -   Search for existing test files and test functions, and read the corresponding files with the Read tool.
    -   Identify test setup and mock usage patterns, and read the related files with the Read tool.
    -   Check the configuration of test frameworks such as Jest/Mocha, and read the configuration files with the Read tool.

2.  **Read related files directly.**
    -   `docs/implements/{{task_id}}/{feature_name}-memo.md` - To check the existing development history.
    -   `docs/implements/{{task_id}}/{feature_name}-requirements.md` - To check the requirements definition.
    -   `docs/implements/{{task_id}}/{feature_name}-testcases.md` - To check the test case definitions.
    -   Also read related design documents and task files as needed.

After reading is complete, start the work for the Red phase (creating a failing test) based on the prepared context information.

## Target Test Case

**[Target Test Case]**: {{test_case_name}}

## Target Number of Additional Test Cases

**Target number of additional test cases**: 10 or more (if there are less than 10 available test cases, add them all).

Please select and implement 10 or more test cases from the unimplemented test cases. If there are less than 10 available test cases, all available test cases will be the target for implementation.
If test cases have already been implemented, add tests from the test cases written in the test case definition.

## Reliability Level Instruction

When creating the test code, please comment on the verification status with the original materials for the content of each test case using the following signals:

- 🟢 **Green Light**: When there is almost no guesswork and it is based on the original materials.
- 🟡 **Yellow Light**: When it is a reasonable guess from the original materials.
- 🔴 **Red Light**: When it is a guess not found in the original materials.

## Requirements

- **Language/Framework Used**: {{language_framework}}
- The test must be created in a state where it will definitely fail.
- The test name should be easy to understand and written in Japanese.
- The assertion (verification of the expected value) should be clearly described.
- It should be created in a form that calls a function/method that has not yet been implemented.

## Test Code Creation Guidelines

- A structure conscious of the Given-When-Then pattern.
- Preparation of test data (Given).
- Execution of the actual process (When).
- Verification of the result (Then).

## Mandatory Japanese Comment Requirements

The test code must include the following Japanese comments:

### Comments at the Start of a Test Case

```javascript
describe('{{feature_name}}', () => {
  test('{{test_case_name}}', () => {
    // [Test Objective]: [Clearly state what this test confirms in Japanese]
    // [Test Content]: [Explain what kind of process is being tested specifically]
    // [Expected Behavior]: [Explain the result when it operates normally]
    // 🟢🟡🔴 Reliability Level: [How much the content of this test is based on the original materials]

    // [Test Data Preparation]: [The reason for preparing this data]
    // [Initial Condition Setting]: [Explain the state before test execution]
    const input = {{test_input}};

    // [Execute Actual Process]: [Explain which feature/method is being called]
    // [Processing Content]: [Explain the content of the process to be executed in Japanese]
    const result = {{function_name}}(input);

    // [Result Verification]: [Specifically explain what is being verified]
    // [Expected Value Confirmation]: [Explain the expected result and its reason]
    expect(result).toBe({{expected_output}}); // [Confirmation Content]: [The specific item being confirmed in this verification] 🟢🟡🔴
  });
});
```

### Setup/Teardown Comments (if necessary)

```javascript
beforeEach(() => {
  // [Pre-test Preparation]: [Explanation of the preparation work to be done before each test execution]
  // [Environment Initialization]: [The reason and method for resetting the test environment to a clean state]
});

afterEach(() => {
  // [Post-test Cleanup]: [Explanation of the cleanup work to be done after each test execution]
  // [State Restoration]: [The reason for restoring the state so as not to affect the next test]
});
```

### Comments for Each `expect` Statement

Each `expect` statement must have a Japanese comment:

```javascript
expect(result.property).toBe(expectedValue); // [Confirmation Content]: [The specific item being confirmed in this verification and the reason]
expect(result.array).toHaveLength(3); // [Confirmation Content]: [The reason for confirming that the length of the array matches the expected value]
expect(result.errors).toContain('error message'); // [Confirmation Content]: [The reason for confirming that a specific error message is included]
```

## Example of Test Code to be Created

```javascript
// Test file: {{test_file_name}}
describe('{{feature_name}}', () => {
  beforeEach(() => {
    // [Pre-test Preparation]: Initialize the test environment before each test execution to ensure consistent test conditions.
    // [Environment Initialization]: Reset the file system state to a clean state so as not to be affected by the previous test.
  });

  afterEach(() => {
    // [Post-test Cleanup]: Delete temporary files and directories created after test execution.
    // [State Restoration]: Restore the system to its original state so as not to affect the next test.
  });

  test('{{test_case_name}}', () => {
    // [Test Objective]: {{test_purpose}}
    // [Test Content]: {{test_description}}
    // [Expected Behavior]: {{expected_behavior}}
    // 🟢🟡🔴 Reliability Level: [How much the content of this test is based on the original materials]

    // [Test Data Preparation]: {{test_data_reason}}
    // [Initial Condition Setting]: {{initial_condition}}
    const input = {{test_input}};

    // [Execute Actual Process]: {{function_description}}
    // [Processing Content]: {{process_description}}
    const result = {{function_name}}(input);

    // [Result Verification]: {{verification_description}}
    // [Expected Value Confirmation]: {{expected_result_reason}}
    expect(result).toBe({{expected_output}}); // [Confirmation Content]: {{specific_verification_point}}
  });
});
```

## Please Provide

1.  **Test Code**: In an executable format, with the mandatory Japanese comments.
2.  **Test Execution Command**: How to execute it.
3.  **Expected Failure Message**: What kind of error will appear.
4.  **Explanation of Comments**: The intent and purpose of each Japanese comment.

After creating the test code, please execute the following:

1.  **Create/Update Memo File**: Create or append the content of the Red phase to the `docs/implements/{{task_id}}/{feature_name}-memo.md` file.
    -   If an existing memo file exists, update the Red phase section.
    -   If the memo file does not exist, create a new one.
2.  Save the design content of the test code to `docs/implements/{{task_id}}/{feature_name}-red-phase.md` (append if the file already exists).
3.  Update the TODO status (mark the Red phase as complete).
4.  **Quality Judgment**: Judge the quality of the test code based on the following criteria:
    -   Test Execution: Executable and confirmed to fail.
    -   Expected Value: Clear and specific.
    -   Assertion: Appropriate.
    -   Implementation Policy: Clear.
5.  **Display Next Step**: Regardless of the judgment result, display the next recommended command.
    -   "Next recommended step: Start the Green phase (minimal implementation) with `/tdd-green`."

## TDD Memo File Format

Format of the `docs/implements/{{task_id}}/{feature_name}-memo.md` file:

```markdown
# TDD Development Memo: {feature_name}

## Overview

- Feature Name: [Feature Name]
- Development Start: [Date]
- Current Phase: [Red/Green/Refactor]

## Related Files

- Original Task File: `docs/tasks/{path_to_task_file}.md`
- Requirements Definition: `docs/implements/{{task_id}}/{feature_name}-requirements.md`
- Test Case Definition: `docs/implements/{{task_id}}/{feature_name}-testcases.md`
- Implementation File: `[Path to implementation file]`
- Test File: `[Path to test file]`

## Red Phase (Write a Failing Test)

### Creation Date

[Date]

### Test Case

[Overview of the created test case]

### Test Code

[Actual test code]

### Expected Failure

[What kind of failure is expected]

### Requirements for the Next Phase

[What should be implemented in the Green phase]

## Green Phase (Minimal Implementation)

### Implementation Date

[Date]

### Implementation Policy

[Policy for minimal implementation]

### Implementation Code

[Actual implementation code]

### Test Results

[Result of passing the tests]

### Issues & Improvements

[Points to be improved in the Refactor phase]

## Refactor Phase (Quality Improvement)

### Refactoring Date

[Date]

### Improvement Content

[Specific improvement content]

### Security Review

[Confirmation results from a security perspective]

### Performance Review

[Confirmation results from a performance perspective]

### Final Code

[Code after refactoring]

### Quality Evaluation

[Final quality evaluation]
```

## Quality Judgment Criteria

```
✅ High Quality:
- Test Execution: Successful (confirmed to fail).
- Expected Value: Clear and specific.
- Assertion: Appropriate.
- Implementation Policy: Clear.

⚠️ Needs Improvement:
- The test cannot be executed.
- The expected value is ambiguous.
- The implementation approach is unclear.
- The test case is complex.
```

## TODO Update Pattern

```
- Mark the current TODO "Red Phase (Write Failing Test)" as "completed".
- Reflect the completion of the failing test creation phase in the TODO content.
- Record the quality judgment result in the TODO content.
- Add the next phase "Green Phase (Minimal Implementation)" to the TODO.
```

Next step: Perform the minimal implementation to make the tests pass with `/tdd-green`.
```
