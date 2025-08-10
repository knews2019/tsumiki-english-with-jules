# TDD Green Phase (Implementation)

Executes the Green phase of TDD.

## Prerequisites

Prepare the development context:

1.  **Search for implementation-related information with @agent-symbol-searcher and read the found files.**
    -   Search for existing similar features or utility functions and read the corresponding files with the Read tool.
    -   Identify implementation patterns and architectural guidelines, and read the design documents with the Read tool.
    -   Check dependencies and import paths, and read the related files with the Read tool.

2.  **Read related files directly.**
    -   `docs/implements/{{task_id}}/{feature_name}-memo.md` - To check the existing development history.
    -   `docs/implements/{{task_id}}/{feature_name}-requirements.md` - To check the requirements definition.
    -   `docs/implements/{{task_id}}/{feature_name}-testcases.md` - To check the test case definitions.
    -   `docs/implements/{{task_id}}/{feature_name}-red-phase.md` - To check the tests from the Red phase.
    -   Also read related design documents and task files as needed.

After reading is complete, start the work for the Green phase (implementation) based on the prepared context information.

**Use the Task tool when running tests.**

## Reliability Level Instruction

When creating the implementation code, please comment on the verification status with the original materials for each implementation content using the following signals:

- 🟢 **Green Light**: When there is almost no guesswork and it is based on the original materials.
- 🟡 **Yellow Light**: When it is a reasonable guess from the original materials.
- 🔴 **Red Light**: When it is a guess not found in the original materials.

## Goal

Please perform the **implementation** to make the tests created in the Red phase pass.

## Implementation Principles

- **The top priority is to make the tests pass for sure.**
- The beauty of the code is secondary (it will be improved in the next Refactor phase).
- A "just works" level is OK.
- Postpone complex logic and aim for a simple implementation.
- If the tests do not pass easily, use the Task tool to investigate the cause of failure, then plan the correction and implement it.
- If an existing test fails, correct it appropriately based on the specification.
- **Restriction on using mocks**: Do not write mocks outside of the test code (the implementation code should write the actual logic).
- **File size management**: Consider splitting the file when the implementation file exceeds 800 lines.
- NEVER: Do not skip necessary tests.
- NEVER: Do not delete necessary test cases.
- NEVER: Do not write mocks/stubs in the implementation code.
- NEVER: Do not use in-memory storage instead of a DB in the implementation code.
- NEVER: Do not omit DB operations in the implementation code.

## Japanese Comment Requirements for Implementation

The implementation code must include the following Japanese comments:

### Function/Method Level Comments

```javascript
/**
 * [Function Overview]: [Explain what this function does in Japanese]
 * [Implementation Policy]: [Explain why this implementation method was chosen]
 * [Test Correspondence]: [Specify which test cases this implementation is for]
 * 🟢🟡🔴 Reliability Level: [How much this implementation is based on the original materials]
 * @param {type} paramName - [Parameter description]
 * @returns {type} - [Return value description]
 */
function {{function_name}}(paramName) {
  // [Implementation Content]: [Detailed explanation of the implemented process]
}
```

### Processing Block Level Comments

```javascript
function processData(input) {
  // [Input Value Validation]: [Reason and method for checking the validity of the input value] 🟢🟡🔴
  if (!input) {
    throw new Error('Invalid input value'); // [Error Handling]: [Explain why this error is necessary] 🟢🟡🔴
  }

  // [Start Data Processing]: [Explicitly state the start of the main process] 🟢🟡🔴
  // [Processing Policy]: [Explain how this process contributes to passing the tests] 🟢🟡🔴
  const result = {
    // [Result Structure]: [Explain the structure of the return value and its reason]
    validData: [],
    invalidData: [],
    errors: [],
  };

  // [Return Result]: [Explanation of the reason and content of returning the processing result]
  return result;
}
```

### Variable/Constant Comments

```javascript
// [Constant Definition]: [The reason this constant is necessary and its purpose]
const MAX_FILE_SIZE = 1024 * 1024; // [Limit Value]: Set the upper limit of the file size (1MB)

// [Variable Initialization]: [Explain why this variable is necessary to pass the test]
let processedCount = 0; // [Counter]: A counter to track the number of processed files
```

### Error Handling Comments

```javascript
try {
  // [Execute Actual Process]: [Explanation of the part that executes the actual process]
  const data = processFile(filePath);
} catch (error) {
  // [Catch Error]: [Policy for handling when an error occurs]
  // [Test Requirement Correspondence]: [Processing to satisfy the error handling expected in the test]
  return {
    success: false,
    error: error.message, // [Error Information]: Appropriately return the error message to be verified in the test
  };
}
```

## Implementation Example

```javascript
/**
 * [Function Overview]: Validates a JSON file path and classifies valid/invalid paths.
 * [Implementation Policy]: Implements only the minimum necessary functions to pass the test cases.
 * [Test Correspondence]: Implementation to pass the test cases created in the tdd-red phase.
 */
function {{function_name}}(input) {
  // [Input Value Validation]: Detects invalid input values early to prevent errors.
  if (!input) {
    // [Error Handling]: Corresponds to the error case expected in the test.
    throw new Error('Input value is required');
  }

  // [Minimal Implementation]: The simplest implementation to pass the test.
  // [Hardcoding Allowed]: It is OK to use a fixed value at this stage because it is scheduled to be improved in the refactoring stage.
  return {{simple_return_value}};
}
```

## Phased Implementation Guidelines

1.  **First, make only one test case pass**
    -   [Implementation Strategy]: Avoid trying to handle multiple tests at the same time as it leads to complication.
    -   [Ensuring Quality]: Ensure quality by implementing one by one reliably.
2.  **Implement in the simplest way**
    -   [Simple Implementation]: Add complex algorithms in a later refactoring.
    -   [Emphasize Readability]: Prioritize ease of understanding at this stage.
3.  **Implement with file size in mind**
    -   [800-line limit]: Consider splitting the file when the implementation file exceeds 800 lines.
    -   [Module Design]: Appropriately separate files by functional unit.
    -   [Function Splitting]: Implement long functions by splitting them into smaller units.
    -   [Responsibility Boundary]: Implement with a clear scope of responsibility for each file.
    -   [Splitting Strategy]: Separate files by feature/layer/domain.
4.  **Consider code quality standards**
    -   [Static Analysis Correspondence]: Aim for an implementation that does not produce errors in lint or typecheck.
    -   [Unified Formatting]: Implement according to the project's existing format.
    -   [Adherence to Naming Conventions]: Implement according to the project's naming conventions.
5.  **Postpone other test cases**
    -   [Phased Development]: Proceed one step at a time according to the principles of TDD.
    -   [Limited Scope of Impact]: Minimize the impact of changes.
6.  **Error handling is also minimal**
    -   [Minimum Necessary]: Implement only the parts required by the test.
    -   [Future Extensible]: Plan to add detailed error handling at the refactoring stage.
7.  **Restriction on using mocks**
    -   [Implementation Code Restriction]: Do not use mocks/stubs in the implementation code.
    -   [Test Code Only]: Use mocks only within the test code.
    -   [Actual Logic Implementation]: The implementation code should describe the actual processing.
    -   [Dependency Injection]: Implement with the dependency injection pattern as needed.

## Please Provide

1.  **Implementation Code**: Code that passes the tests (with the required Japanese comments).
2.  **Test Execution Results**: Confirmation that the tests actually pass using the Task tool.
3.  **Explanation of Implementation**: An explanation of the thinking behind the implementation (correspondence with the Japanese comments).
4.  **Identification of Issues**: Problems with the current implementation (clarification of the target for refactoring).
5.  **File Size Check**: Confirmation of the number of lines in the implementation file (a plan for splitting if it exceeds 800 lines).
6.  **Mock Usage Check**: Confirmation that the implementation code does not contain mocks/stubs.

After completing the implementation, please execute the following:

1.  **Update the memo file**: Update the Green phase section of the `docs/implements/{{task_id}}/{feature_name}-memo.md` file.
    -   Record the implementation policy, implementation code, test results, and issues/improvements.
    -   Record in detail so that it can be referenced in the next Refactor phase.
2.  Save the implementation code and design content to `docs/implements/{{task_id}}/{feature_name}-green-phase.md` (append if the file already exists).
3.  Update the TODO status (mark the Green phase as complete).
4.  **Automatic Transition Judgment**: If the following conditions are met, automatically execute `/tdd-refactor`.
    -   It has been confirmed that all tests are successful using the Task tool.
    -   The implementation is simple and easy to understand.
    -   There are clear parts to be refactored.
    -   There are no functional problems.
5.  **Manual Confirmation**: If the automatic transition conditions are not met, please provide the following:
    -   "I have confirmed that the tests passed using the Task tool."
    -   "Current implementation: [Brief description]"
    -   "Japanese comments included in the implementation: [Purpose and content of the comments]"
    -   "Candidates for refactoring: [Points to be improved]"
    -   "Is it okay to proceed to the next Refactor phase?"

## Quality Judgment Criteria

```
✅ High Quality:
- Test Results: All successful when executed with the Task tool.
- Implementation Quality: Simple and works.
- Refactoring Points: Clearly identifiable.
- Functional Problems: None.
- Compilation Errors: None.
- File Size: 800 lines or less, or a clear plan for splitting.
- Mock Usage: The implementation code does not contain mocks/stubs.

⚠️ Needs Improvement:
- Some tests fail (detected by the Task tool).
- The implementation is too complex.
- The refactoring policy is unclear.
- There are concerns about the functionality.
- There are compilation errors.
- The file size exceeds 800 lines and the splitting plan is unclear.
- The implementation code contains mocks/stubs.
```

## TODO Update Pattern

```
- Mark the current TODO "Green Phase (Minimal Implementation)" as "completed".
- Reflect the completion of the minimal implementation phase in the TODO content.
- Record the quality judgment result in the TODO content.
- Add the next phase "Refactor Phase (Quality Improvement)" to the TODO.
```

Next step: Improve the quality of the code with `/tdd-refactor`.
```
