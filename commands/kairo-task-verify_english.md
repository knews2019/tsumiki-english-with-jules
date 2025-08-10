# kairo-task-verify

## Objective

To check the content of the created task file and add any missing information according to the example output format.

## Prerequisites

- `docs/tasks/{requirement_name}-tasks.md` exists.
- The task file has been created by the kairo-tasks command.

## Execution Content

**[Reliability Level Instruction]**:
For each item, please comment on the verification status with the original materials (including EARS requirements definition documents and design documents) using the following signals:

- 🟢 **Green Light**: When there is almost no guesswork and it is based on the EARS requirements definition document/design document.
- 🟡 **Yellow Light**: When it is a reasonable guess from the EARS requirements definition document/design document.
- 🔴 **Red Light**: When it is a guess not found in the EARS requirements definition document/design document.

1.  **Check the Task File**
    -   Search for the task file with @agent-symbol-searcher, and read the found file with the Read tool.
    -   Read `docs/tasks/{requirement_name}-tasks.md` with the Read tool.

2.  **Compare with the Example Output Format**
    -   Search for related task formats with @agent-symbol-searcher, and read the found files with the Read tool.
    -   Read the kairo-tasks command file with the Read tool and check the example output format.
    -   Identify any information that is missing from the created task file.

3.  **Add Missing Information**
    Check if the following items are included, and add them if they are missing:
    -   Overview section (total number of tasks, estimated work time, critical path)
    -   Checkbox for each task
    -   Explicitly state the task type (TDD/DIRECT)
    -   Requirements link
    -   Dependent tasks
    -   Implementation details
    -   Test requirements
    -   UI/UX requirements (for frontend tasks)
    -   Error handling requirements
    -   Completion criteria
    -   Execution order (Mermaid Gantt chart)
    -   Subtask template information

4.  **Update the File**
    -   Update the file by adding the missing information.

## Confirmation After Execution

-   Display the path of the updated file.
-   Display an overview of the added information.
-   Confirm that the task file is complete.
