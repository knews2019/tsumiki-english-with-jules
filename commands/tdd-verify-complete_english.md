# TDD Test Case Completeness Verification

Verifies if the implementation of test cases in TDD development is fully complete.

## Verification Objective

To confirm that all planned test cases have been implemented after refactoring and to prevent any implementation omissions.

## Important Principle

**⚠️ No modifications are made in this process.**
- No code or test modifications are made in this verification phase.
- If a problem is found, the details are recorded in the memo file.
- Correction work is delegated to a later process (the next TDD cycle or another task).
- This phase is dedicated to verification, recording, and reporting.

## Verification Procedure

### 1. Confirming the Green State of Existing Tests

- **Prerequisite**: Confirm that all existing tests are successful.
- Run `npm test` or `jest` to check the test results.
- **If there are test failures**: Record them in the memo file and handle the correction in a later process.
- **No modifications in this process**: Do not correct test failures even if they are found here.
- Record the test status and proceed to the next step.

### 2. Prerequisites

Prepare the verification context:

1.  **Search for verification-related information with @agent-symbol-searcher and read the found files.**
    -   Search for test cases and features scheduled for completion, and read the corresponding files with the Read tool.
    -   Check existing test coverage and quality standards, and read the related files with the Read tool.
    -   Identify the marking pattern for completed tasks, and read the task files with the Read tool.

2.  **Read related files directly.**
    -   `docs/implements/{{task_id}}/{feature_name}-memo.md` - To check the existing development history.
    -   `docs/implements/{{task_id}}/{feature_name}-requirements.md` - To check the requirements definition.
    -   `docs/implements/{{task_id}}/{feature_name}-testcases.md` - To check the test case definitions.
    -   `docs/implements/{{task_id}}/{feature_name}-refactor-phase.md` - To check the results of the Refactor phase.
    -   Original task file (`docs/tasks/{taskfile}.md`) - To check the completion status of the task.

After reading is complete, start the test case completeness verification based on the prepared context information.

### 2. Confirming Implemented Test Cases

-   Check the current test files.
-   Count the number of implemented test cases.
-   Compare the content of each test case with the plan.

### 3. Analysis of Implementation Status and Judgment for Updating TODO.md

Please provide the analysis results in the following format:

```
## Test Case Implementation Status

### 📋 TODO.md Target Task Confirmation
- **Target Task**: [Name of the current TDD development target task]
- **Current Status**: [Incomplete/Partially Complete/Complete]
- **Completion Mark Required**: [Yes/No]

### 📋 Planned Test Cases (from requirements definition)
- **Total Count**: [Total number of planned test cases]
- **Classification**:
  - Happy Path: [Number]
  - Sad Path: [Number]
  - Edge Cases: [Number]
  - Other: [Number]

### ✅ Implemented Test Cases
- **Total Count**: [Total number of implemented test cases]
- **Success Rate**: [Number of passing tests]/[Number of implemented tests] ([Success rate]%)

### ❌ Unimplemented Test Cases ([Number])
1.  **Test Case Name**: [Unimplemented test that was planned]
    -   **Type**: [Happy Path/Sad Path/Edge Case]
    -   **Content**: [Detailed content of the test]
    -   **Importance**: [High/Medium/Low]
    -   **Requirement Item**: [Corresponding item in the requirements definition document]

2.  **Test Case Name**: [Second unimplemented test]
    ...

### 📋 Requirements Definition Document Coverage Check
- **Total Number of Requirement Items**: [Total number of items in the requirements definition document]
- **Implemented Items**: [Number of implemented and tested items]
- **Requirement Coverage Rate**: [Implemented]/[Total] = [Coverage rate]%

#### Uncovered Requirement Items ([Number])
1.  **Requirement Item**: [Name of the unimplemented requirement item]
    -   **Classification**: [Input parameter/Output specification/Constraint/Usage example/Error case, etc.]
    -   **Content**: [Detailed content of the requirement]
    -   **Reason for Non-implementation**: [Why it was not implemented]
    -   **Need for Correspondence**: [Mandatory/Recommended/Optional]

2.  **Requirement Item**: [Second uncovered item]
    ...

### 📊 Implementation Rate
- **Overall Implementation Rate**: [Implemented count]/[Planned count] = [Implementation rate]%
- **Happy Path Implementation Rate**: [Implemented count]/[Planned count] = [Implementation rate]%
- **Sad Path Implementation Rate**: [Implemented count]/[Planned count] = [Implementation rate]%
- **Edge Case Implementation Rate**: [Implemented count]/[Planned count] = [Implementation rate]%
```

### 4. Judgment Criteria

#### ✅ Fully Implemented (Automatically proceeds to the next step)

```
- Existing Test Status: All green
- Requirement Coverage Rate: 100% (all requirement items implemented and tested)
- Test Success Rate: 100%
- Unimplemented Important Requirements: 0
- Quality Standard: Full fulfillment of the requirements definition achieved
```

#### ⚠️ Implementation Incomplete (Additional implementation required)

```
- Existing Test Status: Failing tests exist OR
- Requirement Coverage Rate: Less than 100% (implementation for items in the requirements definition is insufficient)
- Important requirement items are unimplemented/untested
- Quality risk in requirement fulfillment
```

### 5. Recording Verification Results in Memo File and Updating TODO.md

#### Integrated Update of Memo File

After verification is complete, organize and integrate the existing content of `docs/implements/{{task_id}}/{feature_name}-memo.md` and update it with the following information:

```markdown
# [Feature Name] TDD Development Completion Record

## Documents to be Checked

- `docs/tasks/{path_to_task_file}.md`
- `docs/implements/{{task_id}}/{feature_name}-requirements.md`
- `docs/implements/{{task_id}}/{feature_name}-testcases.md`

## 🎯 Final Result ([Date])
- **Implementation Rate**: [Number]% ([Implemented count]/[Planned count] test cases)
- **Quality Judgment**: [Pass/Fail]
- **TODO Update**: [✅Completion mark added/Needs improvement]

## 💡 Important Technical Lessons
### Implementation Patterns
[Important implementation methods that can be reused in the future]

### Test Design
[Effective test approaches]

### Quality Assurance
[Important perspectives for ensuring quality]

## ⚠️ Points to Note & Items Requiring Correction (only if applicable)
[Important points to note during implementation or uncompleted items]

### 🔧 Correction Targets in a Later Process
#### Test Failures
- [Name of the failing test case]
- **Failure Content**: [Specific failure content]
- **Correction Policy**: [Recommended correction method]

#### Implementation Insufficiency
- [Unimplemented features or requirements]
- **Insufficient Content**: [Specific insufficient content]
- **Response Policy**: [Recommended response method]

#### Quality Improvement
- [Parts that need quality improvement]
- **Improvement Content**: [Specific improvement content]
- **Improvement Policy**: [Recommended improvement method]

---
*Integrate important information from existing memo content, and delete duplicate and detailed progress records.*
```

**Integrated Update Rules:**
1.  **Retain Important Information**: Integrate technical learning points and reusable patterns from existing memos.
2.  **Delete Duplicates**: Consolidate similar records and detailed progress into the latest information.
3.  **Be Concise**: Retain only the final results for details such as dates and numbers.
4.  **Prioritize Reusability**: Preferentially leave information that will be useful for future development.
5.  **Prioritize Related Information**: Preferentially leave information such as specification information.

#### Automatic Update of the Original Task File Completion Mark

If the verification is complete, automatically update the original task file with the following procedure:

1.  **Identify the Completed Task**: Identify the current TDD development target task from the original task file.
2.  **Add Completion Mark**: Add a `✅ **Complete**` mark to the corresponding task.
3.  **State Reason for Completion**: Append `(TDD development complete - [Number] test cases all passed)`.
4.  **Update Subtasks**: Also add a `[x]` checkmark to related subtasks.

Example:

```markdown
### 1. JSON file path argument processing feature ✅ **Complete** (TDD development complete - 15 test cases all passed)

- [x] Added a feature to receive JSON file paths as command-line arguments.
- [x] Supports multiple JSON file paths (reading the entire sample/ directory).
- [x] Argument validation feature.
```

### 6. Corresponding Actions

#### If Fully Implemented

Display the following message along with the next recommended command:

```
✅ Test Case Completeness Verification: Pass
- Planned test cases: All [Number] implemented
- Test success rate: 100%
- Quality standard: Achieved

Next recommended step: Start the next TDD cycle with `/tdd-cycle`.
```

**Memo File Recording**: Automatically append the verification results to the memo file.
**Original Task File Update**: Automatically add a ✅Complete mark to the completed task.

#### If Implementation is Incomplete

Provide the following message and record the situation:

```
⚠️ Detected insufficient test case implementation.

There are [Number] unimplemented test cases.
The following content has been recorded in the memo file:

[List of unimplemented test cases]

[Important] No modifications are made in this process.
The necessary corrections are described in the memo file and will be handled in a later process.

Completing the current record and proceeding to the next step.
```

**Memo File Recording**: Record the verification results and correction policy for the insufficient implementation in detail in the memo file.
**Original Task File Update**: Even if the implementation is incomplete, appropriately mark any partially completed tasks.
**Prohibition of Correction Work**: Do not perform any correction work in this process.

## Files to be Verified

### Documents to be Checked

- **Original Task File**: `docs/tasks/{path_to_task_file}.md` - Overall task completion status of the project (target for updating the completion mark)
- `docs/implements/{{task_id}}/{feature_name}-requirements.md`
- `docs/implements/{{task_id}}/{feature_name}-testcases.md`

### Test Files to be Checked

- `src/__tests__/*.test.ts`
- `src/__tests__/*.test.js`

### Implementation Files to be Checked

- `src/*.ts`
- `src/*.js`

### Files Changed in Git

- Files changed in `git status`
- Files changed in `git diff --name-only`

## Quality Standards

### Minimum Quality Standards

- **Implementation Rate**: 80% or more
- **Success Rate**: 100%
- **Important Tests**: All implemented
- **Requirement Coverage**: Covers all major features of the requirements definition document.
- **Compilation Errors**: None

### Ideal Quality Standards

- **Implementation Rate**: 100%
- **Success Rate**: 100%
- **Comprehensiveness**: Covers all cases
- **Full Requirement Coverage**: Covers all items in the requirements definition document.

### Requirements Definition Document Coverage Check

Confirm that the following items described in the requirements definition document (requirements.md) have been implemented and tested:

#### Mandatory Checklist Items

- **Input Parameters**: Handling of all required and optional arguments.
- **Output Specification**: Implementation of the expected output format/structure.
- **Constraints**: Performance, security, and compatibility requirements.
- **Basic Usage Examples**: Assumed basic usage patterns.
- **Edge Cases**: Handling of boundary values and exceptional conditions.
- **Error Cases**: Appropriate handling of sad paths.
- **Main Algorithms**: The core processing logic of the feature.

#### Coverage Judgment Criteria

```
✅ Full Coverage (100%):
- All items in the requirements definition document have been implemented and tested.
- All patterns of input parameters are tested.
- All formats of the output specification are verified.
- All error cases and edge cases are covered.

⚠️ Partial Coverage (80-99%):
- Major features are implemented, but some items are not.
- Basic usage examples are covered.
- Some non-critical error cases are not implemented.

❌ Insufficient (<80%):
- Important items in the requirements definition document are not implemented.
- There are omissions in the basic usage examples.
- Error handling is insufficient.
```

## Automatic Transition Judgment

### Quality Judgment Criteria

```
✅ High Quality (Full requirement fulfillment achieved):
- Existing Test Status: All green
- Requirement Coverage Rate: 100% (full implementation and testing for all items in the requirements definition document)
- Test Success Rate: 100%
- Unimplemented Important Requirements: 0
- Requirement Fulfillment: Full fulfillment of the requirements definition achieved.

⚠️ Needs Improvement (Insufficient requirement fulfillment):
- Existing Test Status: Failing tests exist OR
- Requirement Coverage Rate: Less than 100% (insufficient implementation and testing for items in the requirements definition document)
- Important requirement items are unimplemented/untested.
- Requirement Fulfillment: Insufficient fulfillment of the requirements definition.
- Improvement of requirement fulfillment through additional implementation is necessary.
```

## Usage Example

```bash
# Automatically executed after the refactor phase
/tdd-refactor
# ↓ Automatically executed
/tdd-verify-complete
# ↓ Automatically executed if implementation is complete
/tdd-cycle
```

## Output Format

Output in one of the following formats depending on the implementation status:

### If Fully Implemented

```
✅ **Test Case Completeness Verification: Pass**

📊 Requirement Fulfillment for This Task:
- Target Requirement Items: [Number]
- Implemented & Tested: [Number] / Unimplemented: [Number]
- Requirement Coverage Rate: 100%
- Requirement Fulfillment: Fully achieved

📊 Overall Test Status:
- Total Number of Test Cases: [Number]
- Success: [Number] / Fail: [Number]
- Overall Test Success Rate: [Number]%

🚀 Full fulfillment of the requirements definition has been achieved.
Automatically proceeding to the next TDD cycle.
```

### If Implementation is Incomplete

```
⚠️ **Detected insufficient test case implementation**

📊 Requirement Fulfillment for This Task:
- Target Requirement Items: [Number]
- Implemented & Tested: [Number] / Unimplemented: [Number]
- Requirement Coverage Rate: [Number]%
- Requirement Fulfillment: [Fulfillment level]

📊 Overall Test Status:
- Total Number of Test Cases: [Number]
- Success: [Number] / Fail: [Number]
- Overall Test Success Rate: [Number]%

❌ Unimplemented Test Cases:
[Detailed list of unimplemented test cases]

📝 **Correction content has been recorded in the memo file.**
It is scheduled to be handled in a later process. No modifications are made in this process.
```

This verification ensures the quality and completeness of TDD development.
```
