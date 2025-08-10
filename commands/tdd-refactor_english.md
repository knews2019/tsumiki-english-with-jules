# TDD Refactor Phase (Code Improvement)

Executes the Refactor phase of TDD.

## Prerequisites

Prepare the development context:

1.  **Search for refactoring-related information with @agent-symbol-searcher and read the found files.**
    -   Search for existing code styles and best practices, and read the style guide with the Read tool.
    -   Identify the overall architectural pattern of the project, and read the design documents with the Read tool.
    -   Check for reusable utility functions and components, and read the related files with the Read tool.

2.  **Read related files directly.**
    -   `docs/implements/{{task_id}}/{feature_name}-memo.md` - To check the existing development history.
    -   `docs/implements/{{task_id}}/{feature_name}-requirements.md` - To check the requirements definition.
    -   `docs/implements/{{task_id}}/{feature_name}-testcases.md` - To check the test case definitions.
    -   `docs/implements/{{task_id}}/{feature_name}-green-phase.md` - To check the implementation of the Green phase.
    -   Also read related design documents and task files as needed.

After reading is complete, start the work for the Refactor phase (code improvement) based on the prepared context information.

## Reliability Level Instruction

When refactoring, please comment on the verification status with the original materials for each improvement content using the following signals:

- 🟢 **Green Light**: When there is almost no guesswork and it is based on the original materials.
- 🟡 **Yellow Light**: When it is a reasonable guess from the original materials.
- 🔴 **Red Light**: When it is a guess not found in the original materials.

## Goal

Please improve the code implemented in the Green phase from the following perspectives. **It is a major premise that the tests must continue to pass.**

## Perspectives for Improvement

### 1. Improving Readability

-   Improve variable/function names.
-   Enrich Japanese comments.
-   Make the code structure easy to understand.

### 2. Removing Duplicate Code (DRY Principle)

-   Commonalize similar processing.
-   Extract constants.
-   Create helper functions.

### 3. Improving the Design

-   Apply the Single Responsibility Principle.
-   Organize dependencies.
-   Consider modularization.

-   NEVER: Write mocks/stubs in the implementation code.
-   NEVER: Use in-memory storage instead of a DB in the implementation code.

### 4. Optimizing File Size

-   Split/optimize files to be under 500 lines.
-   Split long files by feature.
-   Set appropriate module boundaries.

### 5. Ensuring Code Quality

-   Resolve lint errors.
-   Resolve typecheck errors.
-   Unify formatting.
-   Pass static analysis tool checks.

### 6. Security Review

-   Detect and correct implementations that lead to vulnerabilities.
-   Strengthen input value validation.
-   Confirm SQL injection countermeasures.
-   Confirm XSS (Cross-Site Scripting) countermeasures.
-   Confirm CSRF (Cross-Site Request Forgery) countermeasures.
-   Avoid the risk of data leakage.
-   Appropriate implementation of authentication/authorization.

### 7. Performance Review

-   Analysis of the computational complexity of algorithms.
-   Optimization of memory usage.
-   Deletion of unnecessary processing.
-   Consideration of a caching strategy.
-   Optimization of database queries.
-   Improving the efficiency of loop processing.
-   Appropriate implementation of asynchronous processing.

### 8. Enhancing Error Handling

-   Validation of input values.
-   Appropriate error messages.
-   Improvement of exception handling.

## Requirements for Enhancing Japanese Comments During Refactoring

In refactoring, please improve existing Japanese comments and add new ones:

### Comments for Improved Functions/Methods

```javascript
/**
 * [Function Overview]: [Detailed explanation of the function after refactoring]
 * [Improvement Content]: [Explain what kind of improvements were made]
 * [Design Policy]: [The reason for choosing this design]
 * [Performance]: [Performance considerations]
 * [Maintainability]: [Ingenuity to make it easy to maintain]
 * 🟢🟡🔴 Reliability Level: [How much this improvement is based on the original materials]
 * @param {type} paramName - [Detailed explanation and constraints of the parameter]
 * @returns {type} - [Detailed explanation and guarantees of the return value]
 */
function improvedFunction(paramName) {
  // [Implementation Details]: [The content and reason for the improved implementation]
}
```

### Comments for Helper Functions/Utilities

```javascript
/**
 * [Helper Function]: [The role of this function and the reason for its creation]
 * [Reusability]: [In what situations it can be reused]
 * [Single Responsibility]: [The scope of responsibility of this function]
 */
function helperFunction(input) {
  // [Processing Efficiency Improvement]: [Ingenuity to improve processing efficiency] 🟢🟡🔴
  // [Readability Improvement]: [Mechanism to improve the readability of the code] 🟢🟡🔴
}
```

### Comments for Constants/Configuration Values

```javascript
// [Configuration Constant]: [The role of this constant and the reason for its setting] 🟢🟡🔴
// [Adjustability]: [The possibility and method of needing adjustment in the future] 🟢🟡🔴
const IMPROVED_CONSTANT = 100; // [Optimized]: Optimized based on performance tests 🟢🟡🔴

// [Configuration Object]: [The reason for grouping the settings and the management policy]
const CONFIG = {
  // [Each Setting Item]: [The meaning and scope of impact of each setting value]
  maxRetries: 3, // [Number of Retries]: An appropriate number based on experience in actual operation
  timeout: 5000, // [Timeout]: A time setting that considers usability
};
```

### Comments for Improved Error Handling

```javascript
try {
  // [Safe Process Execution]: [The possibility of an exception occurring and countermeasures]
  const result = riskyOperation();
} catch (error) {
  // [Detailed Error Handling]: [Appropriate handling according to the type of error]
  // [Usability]: [Error handling that is easy for the user to understand]
  if (error.code === 'SPECIFIC_ERROR') {
    // [Specific Error Handling]: [The reason for the handling specific to this error]
    return handleSpecificError(error);
  }
  // [General Error Handling]: [Safe handling of unexpected errors]
  return handleGenericError(error);
}
```

## Refactoring Procedure

1.  **Confirm that all current tests pass**
    -   [Quality Assurance]: Confirm operation before refactoring.
    -   [Ensuring Safety]: Prevent functional breakdown due to changes.
    -   [Execution Method]: Run tests using the Task tool and analyze the results in detail.
2.  **Code/Test Exclusion Check**
    -   [.gitignore Confirmation]: Check that code files that should be checked are not excluded.
    -   [Test Exclusion Confirmation]: Check that tests are not disabled with `describe.skip`, `it.skip`, `test.skip`, etc.
    -   [jest Configuration Confirmation]: Check that test files are not excluded by `testPathIgnorePatterns` in `jest.config.js` or `package.json`.
    -   [Execution Target Confirmation]: Check that the tests and code that should actually be executed are properly included in the target.
3.  **Clean up development-generated files**
    -   [Detect Unnecessary Files]: Detect and delete temporary files created during development.
    -   [Target File Patterns]: Check files that match the following patterns:
        -   `debug-*.js`, `debug-*.ts`: Debugging scripts
        -   `test-*.js`, `test-*.ts`, `temp-*.js`: Temporary test files
        -   `*.tmp`, `*.temp`, `*.bak`, `*.orig`: Temporary/backup files
        -   `*~`, `.DS_Store`: Editor/system generated files
        -   `test-output-*`, `*.test-output`: Test output files
    -   [Safety Confirmation]: Before deleting, check the content of each file to see if it contains important code.
    -   [Selective Deletion]: Delete only the files judged to be unnecessary and keep the necessary files.
    -   [Deletion Log]: Record the deleted files and the reason for deletion as a log.
    -   [Execution Procedure]:
        1. Detect files with `find . -name "debug-*" -o -name "test-*" -o -name "temp-*" -o -name "*.tmp" -o -name "*.temp" -o -name "*.bak" -o -name "*.orig" -o -name "*~" -o -name ".DS_Store" | grep -v node_modules`
        2. Check the content of each file with the Read tool.
        3. Delete the files judged to be unnecessary and record the reason for deletion.
4.  **Conduct a Security Review**
    -   [Vulnerability Scan]: Identify security holes in the entire code.
    -   [Input Validation Confirmation]: Confirm the defense function against invalid input values.
    -   [Application of Security Guidelines]: Apply industry-standard security best practices.
5.  **Conduct a Performance Review**
    -   [Complexity Analysis]: Evaluate the time and space complexity of algorithms.
    -   [Bottleneck Identification]: Identify problem areas in processing speed and memory usage.
    -   [Optimization Strategy]: Formulate specific performance improvement measures.
6.  **Apply small improvements one by one**
    -   [Phased Improvement]: Safe changes with a limited scope of impact.
    -   [Traceability]: Ensuring the traceability of changes.
7.  **Run tests after each improvement**
    -   [Continuous Verification]: Confirm operation with each improvement.
    -   [Early Detection]: Early detection and correction of problems.
    -   [Execution Method]: Run tests using the Task tool and confirm the impact of the improvement.
8.  **Immediately revert if a test fails**
    -   [Rapid Recovery]: A quick response when a problem occurs.
    -   [Maintaining Stability]: Maintaining a stable state of the system.

## Points to Note

-   **Do not make functional changes** (adding new features is NG).
-   **Immediately correct if a test no longer passes**.
-   **Do not make large changes at once**.
-   **Also improve the quality of Japanese comments**.
-   **Use the Task tool when running tests for quality confirmation**.


## Please Provide

1.  **Security Review Results**: The presence of vulnerabilities and countermeasures.
2.  **Performance Review Results**: Analysis of performance issues and improvement measures.
3.  **Improved Code**: The code after refactoring (with enhanced Japanese comments).
4.  **Explanation of Improvement Points**: What was improved and how (including security and performance perspectives).
5.  **Test Execution Results**: Confirmation that all tests continue to pass using the Task tool.
6.  **Quality Evaluation**: The quality level of the current code (including security and performance evaluation).
7.  **Comment Improvement Content**: How the Japanese comments were enhanced.

## Refactoring Example

```javascript
// Before: Hardcoding
function add(a, b) {
  return 5; // Implementation that just works for now
}

// After: Appropriate implementation (with improved Japanese comments)
/**
 * [Function Overview]: Adds two numbers and returns the result.
 * [Improvement Content]: Removed hardcoding and implemented the actual addition process.
 * [Design Policy]: A design that emphasizes input value validation and type safety.
 * [Error Handling]: Implemented appropriate exception handling for invalid input.
 */
function add(firstNumber, secondNumber) {
  // [Input Value Validation]: Detects non-numeric input early to prevent errors.
  // [Type Safety]: Performs runtime validation in conjunction with TypeScript's type checking.
  if (typeof firstNumber !== 'number' || typeof secondNumber !== 'number') {
    // [Usability]: Provides an error message that is easy for developers to understand.
    throw new Error('Arguments must be numbers');
  }

  // [Main Process]: Simple and reliable addition process.
  // [Performance]: An efficient implementation that avoids unnecessary processing.
  return firstNumber + secondNumber;
}
```

After completing the refactoring, please execute the following:

1.  **Final Update of Memo File**: Update the Refactor phase section and the overview of the `docs/implements/{{task_id}}/{feature_name}-memo.md` file.
    -   Record the improvement content, security review results, and performance review results.
    -   Record the final code and quality evaluation.
    -   Update the current phase in the overview section to "Complete."
2.  Save the refactoring content and design improvements to `docs/implements/{{task_id}}/{feature_name}-refactor-phase.md` (append if the file already exists).
3.  Update the TODO status (mark the Refactor phase as complete).
4.  **Quality Judgment**: Judge the quality of the refactoring results based on the following criteria:
    -   Test Results: All tests continue to succeed.
    -   Security: No critical vulnerabilities have been discovered.
    -   Performance: No critical performance issues have been discovered.
    -   Refactor Quality: The goals have been achieved.
    -   Code Quality: Improved to an appropriate level.
5.  **Display Next Step**: Regardless of the judgment result, display the next recommended command.
    -   "Next recommended step: Execute completeness verification with `/tdd-verify-complete`."

## Quality Judgment Criteria

```
✅ High Quality:
- Test Results: All continue to succeed when executed with the Task tool.
- Security: No critical vulnerabilities.
- Performance: No critical performance issues.
- Refactor Quality: Goals achieved.
- Code Quality: Appropriate level.
- Documentation: Complete.

⚠️ Needs Improvement:
- Some tests fail (detected by the Task tool).
- Security vulnerability discovered.
- Performance issue discovered.
- Refactor goals not met.
- Insufficient quality improvement.
- Incomplete documentation.
```

## TODO Update Pattern

```
- Mark the current TODO "Refactor Phase (Quality Improvement)" as "completed".
- Reflect the completion of the refactoring phase in the TODO content.
- Record the quality judgment result in the TODO content.
- Add the next phase "Completeness Verification" to the TODO.
- If there are parts that need improvement, add them as a new TODO.
```
