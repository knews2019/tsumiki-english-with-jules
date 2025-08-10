# TDD Related File Reading & Context Preparation (Deprecated)

**Note**: This command is deprecated. Other TDD commands use @agent-symbol-searcher and the Read tool directly to prepare the context.

The following is kept for reference purposes.

## Execution Task

Executes the following parallel reading/searching by @agent-symbol-searcher and the Task tool:

### 0. **Search for related information with @agent-symbol-searcher**
   - Search for existing symbols, functions, and classes related to the target feature.
   - Identify implementation patterns and architectures of similar features.
   - Check how to use TDD-related tools and frameworks.

```
1. [Read] Confirm the TDD memo file
   - Read tool: `docs/implements/{{task_id}}/{feature_name}-memo.md`
   - Grasp the existing development history, phase information, and verification results.

2. [Read] Confirm the requirements definition document
   - Read tool: `docs/implements/{{task_id}}/{feature_name}-requirements.md`
   - Grasp the functional specifications, inputs/outputs, and constraints.

3. [Read] Confirm the test case definition
   - Read tool: `docs/implements/{{task_id}}/{feature_name}-testcases.md`
   - Grasp the planned test cases, classification, and expected values.

4. [Search Only] Identify the project design document
   - Glob tool: Check for the existence of `docs/spec/{feature_name}-requirements.md`.
   - Glob tool: Identify files in the `docs/design/{feature_name}/` directory.
   - Record the found file paths (do not read them).

5. [Search Only] Identify the project structure and library files
   - Glob tool: Check for the existence of `package.json`.
   - Glob tool: Grasp the existing test file structure (`**/*test*.js`, `**/*spec*.js`, etc.).
   - Grep tool: Investigate implementation patterns of similar features (search for related keywords).
   - Record the found file paths (do not read them).

6. [Search Only] Identify the task management document
   - Glob tool: Check for the existence of `docs/tasks/{要件名}-tasks.md`.
   - Record the found file paths (do not read them).
```

## Organizing the Reading Results

After reading and searching are complete, organize the information in the following format:

### 📋 Development Context Information

```markdown
## TDD Development Context

### 🎯 Current Phase & Status
- **Target Feature**: {feature_name}
- **Current TDD Phase**: [Requirements/TestCases/Red/Green/Refactor/Verify]
- **Previously Completed Phase**: [Previously completed phase]
- **Scheduled for this Execution**: [Next step to be executed]

### 📄 Requirements & Specification Information
- **Feature Overview**: [Overview of the feature extracted from the requirements definition document]
- **Input Specification**: [Type, constraints, and range of input parameters]
- **Output Specification**: [Output format, structure, and expected values]
- **Constraints**: [Performance, security, and technical constraints]
- **Reference EARS Requirements**: [Requirement IDs such as REQ-XXX, NFR-XXX]

### 🔧 Technical & Implementation Information
- **Language Used**: [JavaScript/TypeScript, etc.]
- **Test Framework**: [Jest/Mocha, etc.]
- **Related Files**: [List of related file paths found by searching]
- **Design Document Paths**: [List of paths to found design documents]
- **Similar Implementation Paths**: [File paths of existing implementations that can be used as a reference]

### 📈 Progress & Quality Information
- **Overall Task Progress**: [Completed count]/[Total count] ([%])
- **Previous Verification Result**: [Pass/Fail/Not performed]
- **Quality Issues**: [Security/performance issues]
- **Required Improvements**: [Improvement points recorded last time]

### ⚠️ Points to Note & Constraints
- **Technical Constraints**: [Architectural/compatibility constraints]
- **Points to Note During Implementation**: [Important points recorded last time]
- **Unresolved Issues**: [Issues that require continued attention]
```

## Reliability Level Judgment

Judge the reliability level for each piece of information read:

- 🟢 **Green Light**: The file exists, and detailed information is available.
- 🟡 **Yellow Light**: The file exists, but the information is partial.
- 🔴 **Red Light**: The file does not exist, or inference is required.

## How to Use

Use at the beginning of each TDD command as follows:

```markdown
## Prerequisites

Prepare the development context:

**Execute Task tool**: Execute `/tdd-load-context` to read/search for TDD-related files and prepare the context.

After reading is complete, start the work for the {current phase} based on the prepared context information.
```

## Effects

- **Efficiency**: Shorten time by reading memos, requirements, and test cases, and only searching for others.
- **Consistency**: Unified context preparation for all TDD phases.
- **Improved Quality**: Prevents omission of necessary information reading.
- **Maintainability**: Centralized management of file reading/searching logic.
- **Lightweight**: Related files are only identified and can be read individually as needed.

This task allows you to efficiently prepare the necessary information for each phase of TDD development by combining the search results from @agent-symbol-searcher with the information from existing TDD files.
