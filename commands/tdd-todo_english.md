You are an expert at creating implementable TODO lists. Please analyze the task file created by the kairo-tasks command and the related design documents, and create a structured TODO list in the following format.

## Input

- `docs/tasks/{requirement_name}-tasks.md` file
- Task ID for each task (TASK-001, TASK-101, etc.)
- Requirements definition document:
  - `docs/spec/{requirement_name}-requirements.md`
- Design documents:
  - `docs/design/{requirement_name}/architecture.md`
  - `docs/design/{requirement_name}/database-schema.sql`
  - `docs/design/{requirement_name}/api-endpoints.md`
  - `docs/design/{requirement_name}/interfaces.ts`
  - `docs/design/{requirement_name}/dataflow.md`

## Creation Procedure

1.  **Analyze the Requirements Definition Document**
    -   Search for related requirements and design documents with @agent-symbol-searcher.
    -   Understand the requirements in EARS notation.
    -   Grasp the user stories and their value.
    -   Confirm the functional and non-functional requirements.
    -   Understand the edge cases and acceptance criteria.

2.  **Analyze the Design Documents**
    -   Search for existing architectural patterns with @agent-symbol-searcher.
    -   Grasp the overall picture of the architectural design.
    -   Understand the structure of the database schema.
    -   Confirm the specifications of the API endpoints.
    -   Analyze the interface definitions.
    -   Understand the design of the data flow.

3.  **Analyze the Task Files**
    -   Search for related task IDs and completion statuses with @agent-symbol-searcher.
    -   Grasp the overall phase structure.
    -   Confirm the implementation content for each task ID.
    -   Understand the dependencies and execution order.
    -   Confirm consistency with the requirements definition and design documents.

4.  **Points to Note When Creating TODOs**
    -   Maintain traceability by keeping the task ID.
    -   Order tasks considering dependencies.
    -   Clarify the completion criteria for each task.
    -   Include test requirements and UI/UX requirements.
    -   Specify the correspondence with the REQ from the requirements definition.
    -   Reflect the acceptance criteria in the TODOs.
    -   Include considerations for edge cases.
    -   Reflect the details of the design documents in the implementation TODOs.
    -   Ensure consistency with the database schema.
    -   Maintain consistency with the API specifications.
    -   Distinguish the implementation method:
        -   **DIRECT**: Only configuration work (environment construction, configuration files, dependencies, etc.)
        -   **TDD**: Work that involves implementation according to specifications (business logic, API implementation, UI implementation, etc.)

5.  **Output Format**

```markdown
# {Requirement Name} Implementation TODO

## Overview

- Total Number of Tasks: {Number}
- Estimated Work Time: {Hours}
- Critical Path: {List of Task IDs}
- Referenced Requirements: {REQ-001, REQ-002...}
- Design Documents: {Overview of the referenced design documents}

## todo

### Phase 1: Foundation Building

- [ ] **TASK-001 [DIRECT]**: {Task Name} (Corresponds to REQ-{XXX})
  - [ ] {Implementation detail 1 (extracted from architecture.md)}
  - [ ] {Database configuration (extracted from database-schema.sql)}
  - [ ] {Test requirement 1}
  - [ ] {Acceptance criterion (extracted from requirements.md)}
  - [ ] {Completion criterion 1}

- [ ] **TASK-002 [DIRECT]**: {Task Name} (Corresponds to REQ-{XXX})
  - [ ] {Implementation detail 1 (extracted from architecture.md)}
  - [ ] {Environment configuration (extracted from dataflow.md)}
  - [ ] {Test requirement 1}
  - [ ] {Acceptance criterion (extracted from requirements.md)}
  - [ ] {Completion criterion 1}

### Phase 2: API Implementation

- [ ] **TASK-101 [TDD]**: {Task Name} (Corresponds to REQ-{XXX})
  - [ ] {Implementation detail 1 (extracted from api-endpoints.md)}
  - [ ] {Interface implementation (extracted from interfaces.ts)}
  - [ ] {Test requirement 1}
  - [ ] {Error handling 1 (extracted from Edge cases)}
  - [ ] {Acceptance criterion (extracted from requirements.md)}

### Phase 3: Frontend Implementation

- [ ] **TASK-201 [TDD]**: {Task Name} (Corresponds to REQ-{XXX})
  - [ ] {Implementation detail 1 (extracted from interfaces.ts)}
  - [ ] {Data flow implementation (extracted from dataflow.md)}
  - [ ] {UI/UX requirement 1}
  - [ ] {Usability requirement (extracted from NFR-201)}
  - [ ] {Test requirement 1}
  - [ ] {Acceptance criterion (extracted from requirements.md)}

### Phase 4: Integration & Optimization

- [ ] **TASK-301 [TDD]**: {Task Name} (Corresponds to REQ-{XXX})
  - [ ] {Implementation detail 1 (extracted from all design documents)}
  - [ ] {E2E test (extracted from dataflow.md)}
  - [ ] {Performance requirement (extracted from NFR-001)}
  - [ ] {Security requirement (extracted from NFR-101)}
  - [ ] {Test requirement 1}
  - [ ] {Acceptance criterion (extracted from requirements.md)}

## Execution Order

1.  **Foundation Building** ({List of Task IDs}) - Reason: Prerequisite for other tasks
2.  **API Implementation** ({List of Task IDs}) - Reason: Frontend dependency
3.  **Frontend Implementation** ({List of Task IDs}) - Reason: User interface
4.  **Integration & Optimization** ({List of Task IDs}) - Reason: Final quality assurance

## Implementation Process

### TDD Task Implementation Process

[TDD] tasks are implemented in the following order:

1.  `/{taskID}/tdd-requirements.md` - Detailed requirements definition (extracted from requirements definition document)
2.  `/{taskID}/tdd-testcases.md` - Test case creation (derived from acceptance criteria and Edge cases)
3.  `/{taskID}/tdd-red.md` - Test implementation (failing)
4.  `/{taskID}/tdd-green.md` - Minimal implementation (compliant with architectural design)
5.  `/{taskID}/tdd-refactor.md` - Refactoring (confirming consistency with design documents)
6.  `/{taskID}/tdd-verify-complete.md` - Quality confirmation (verifying with the acceptance criteria of the requirements definition)

### DIRECT Task Implementation Process

[DIRECT] tasks are implemented in the following order:

1.  `/{taskID}/direct-setup.md` - Execution of configuration work (based on design documents)
2.  `/{taskID}/direct-verify.md` - Configuration confirmation (operational check and testing)

## Linkage with Documents

- **{requirement_name}-requirements.md**: Functional requirements (REQ-XXX), non-functional requirements (NFR-XXX), acceptance criteria
- **architecture.md**: Overall implementation policy and architectural pattern
- **database-schema.sql**: Implementation details for database-related tasks
- **api-endpoints.md**: Specifications and verification conditions for API implementation tasks
- **interfaces.ts**: Contract between frontend and backend
- **dataflow.md**: Data processing flow and integration test scenarios
```

1.  **Responding to Feedback** After presenting the TODO list, adjust the following based on user feedback:

    -   Granularity of tasks (more detailed/larger)
    -   Changes in priority
    -   Addition of missing tasks
    -   Deletion of unnecessary tasks
    -   Changes in implementation policy
```
