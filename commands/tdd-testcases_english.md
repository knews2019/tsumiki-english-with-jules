# TDD Test Case Identification

Based on the requirements organized earlier, we will identify the test cases.

## Prerequisites

Prepare the development context:

1.  **Search for test-related information with @agent-symbol-searcher and read the found files.**
    -   Search for existing test patterns and test cases, and read the corresponding test files with the Read tool.
    -   Identify test methods and mock strategies for similar features, and read the related files with the Read tool.
    -   Check how to use test frameworks like Jest/Mocha, and read the configuration files with the Read tool.

2.  **Read related files directly.**
    -   `docs/implements/{{task_id}}/{feature_name}-memo.md` - To check the existing development history.
    -   `docs/implements/{{task_id}}/{feature_name}-requirements.md` - To check the requirements definition.
    -   `docs/implements/{{task_id}}/{feature_name}-testcases.md` - To check the existing test cases.
    -   Also read related design documents and task files as needed.

After reading is complete, start the work of identifying test cases based on the prepared context information.

## Reliability Level Instruction

When creating each test case, please be sure to comment on the verification status with the original materials (requirements definition, existing implementation, library documentation, etc.) using the following signals:

- 🟢 **Green Light**: When there is almost no guesswork and it is based on the original materials.
- 🟡 **Yellow Light**: When it is a reasonable guess from the original materials.
- 🔴 **Red Light**: When it is a guess not found in the original materials.

## Test Case Classification

### 1. Happy Path Test Cases (Basic Operation)

Please describe in the following format:

- **Test Name**: [Easy-to-understand Japanese name]
  - **What to test**: [The specific operation or feature you want to confirm with this test]
  - **Expected Behavior**: [What kind of processing should be executed normally]
- **Input Value**: [Specific value]
  - **Meaning of the input data**: [Why this input value was chosen, what it represents]
- **Expected Result**: [Specific expected value]
  - **Reason for the expected result**: [Why this result is considered correct]
- **Test Objective**: [What to confirm]
  - **Confirmation Points**: [Points to be verified with particular attention]
- 🟢🟡🔴 Describe the reliability level of this test case.

### 2. Sad Path Test Cases (Error Handling)

- **Test Name**: [Easy-to-understand Japanese name]
  - **Overview of the error case**: [What kind of abnormal situation is assumed]
  - **Importance of error handling**: [Why this error handling is necessary]
- **Input Value**: [Invalid value or a value that exceeds the boundary]
  - **Reason for being invalid**: [Why this input value is considered invalid]
  - **Actual occurrence scenario**: [In what situations it occurs in actual operation]
- **Expected Result**: [Appropriate error message or exception]
  - **Content of the error message**: [Is it an easy-to-understand message for the user?]
  - **System safety**: [Can the system maintain a safe state in case of an error?]
- **Test Objective**: [Confirmation of error handling]
  - **Quality assurance perspective**: [How this test contributes to system quality]
- 🟢🟡🔴 Describe the reliability level of this test case.

### 3. Boundary Value Test Cases (Min value, max value, null, etc.)

- **Test Name**: [Easy-to-understand Japanese name]
  - **Meaning of the boundary value**: [Why this value is important as a boundary]
  - **Guarantee of operation at the boundary**: [Confirmation of consistent operation near the boundary]
- **Input Value**: [Boundary value]
  - **Basis for selecting the boundary value**: [Why this value was chosen as a boundary value]
  - **Actual usage scene**: [How this boundary value affects actual operation]
- **Expected Result**: [Operation at the boundary]
  - **Accuracy at the boundary**: [Is the calculation or processing at the boundary value performed accurately?]
  - **Consistent operation**: [Is the operation consistent inside and outside the boundary?]
- **Test Objective**: [Confirmation of boundary conditions]
  - **Confirmation of robustness**: [Does the system operate stably even under extreme conditions?]
- 🟢🟡🔴 Describe the reliability level of this test case.

## Development Language/Framework

Please also specify the language and test framework to be used for implementation:

- **Programming Language**: {{language}}
  - **Reason for choosing the language**: [Why this language was chosen]
  - **Features suitable for testing**: [Features of this language that are advantageous for testing]
- **Test Framework**: {{test_framework}}
  - **Reason for choosing the framework**: [Why this test framework was chosen]
  - **Test execution environment**: [In what kind of environment the tests will be executed]
- 🟢🟡🔴 Describe the reliability level of this content.

## Japanese Comment Guidelines for Test Case Implementation

Each test case implementation must include the following Japanese comments:

### Comments at the Start of a Test Case

```javascript
// [Test Objective]: [Clearly state what this test confirms in Japanese]
// [Test Content]: [Explain what kind of process is being tested specifically]
// [Expected Behavior]: [Explain the result when it operates normally]
// 🟢🟡🔴 Reliability level of this content
```

### Comments for the Given (Preparation) Phase

```javascript
// [Test Data Preparation]: [The reason for preparing this data]
// [Initial Condition Setting]: [Explain the state before test execution]
// [Prerequisite Confirmation]: [Specify the prerequisites necessary for test execution]
```

### Comments for the When (Execution) Phase

```javascript
// [Execute Actual Process]: [Explain which feature/method is being called]
// [Processing Content]: [Explain the content of the process to be executed in Japanese]
// [Execution Timing]: [Explain why it is executed at this timing]
```

### Comments for the Then (Verification) Phase

```javascript
// [Result Verification]: [Specifically explain what is being verified]
// [Expected Value Confirmation]: [Explain the expected result and its reason]
// [Quality Assurance]: [Explain how this verification contributes to system quality]
```

### Comments for Each `expect` Statement

```javascript
// [Verification Item]: [The specific item being confirmed in this verification]
// 🟢🟡🔴 Reliability level of this content
expect(result.validPaths).toHaveLength(2); // [Confirmation Content]: Confirm that exactly 2 valid paths are detected.
expect(result.invalidPaths).toContain('nonexistent.json'); // [Confirmation Content]: Confirm that a non-existent file is properly classified as an invalid path.
```

### Setup/Teardown Comments

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

After identifying everything, please execute the following:

1.  Save the test case list to `docs/implements/{{task_id}}/{feature_name}-testcases.md` (append if the file already exists).
2.  Update the TODO status (mark test case identification as complete).
3.  **Quality Judgment**: Judge the quality of the test cases based on the following criteria:
    -   Test Case Classification: Happy path, sad path, and boundary values are covered.
    -   Expected Value Definition: The expected value for each test case is clear.
    -   Technology Selection: The programming language and test framework are finalized.
    -   Implementation Feasibility: It is feasible with the current technology stack.
4.  **Display Next Step**: Regardless of the judgment result, display the next recommended command.
    -   "Next recommended step: Start the Red phase (creating a failing test) with `/tdd-red`."

## Quality Judgment Criteria

The quality of the test cases will be judged based on the following criteria:

```
✅ High Quality:
- Test Case Classification: Happy path, sad path, and boundary values are covered.
- Expected Value Definition: The expected value for each test case is clear.
- Technology Selection: The programming language and test framework are finalized.
- Implementation Feasibility: It is feasible with the current technology stack.

⚠️ Needs Improvement:
- There are omissions or duplicates in the test cases.
- The expected values are ambiguous or insufficient.
- There is hesitation in technology selection.
- It is too complex to implement.

❌ Inappropriate:
- It is not consistent with the requirements.
- The test cases are insufficient.
- There is a problem with technical feasibility.
```

## TODO Update Pattern

```
- Mark the current TODO "Identify Test Cases" as "completed".
- Reflect the completion of the test case definition phase in the TODO content.
- Record the quality judgment result in the TODO content.
- Add the next phase "Red Phase (Create Failing Test)" to the TODO.
```

Next step: We will identify the test cases with `/tdd-testcases`.
```
