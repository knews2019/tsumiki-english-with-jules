# TDD Requirements Definition & Functional Specification Organization

Starting TDD development. Please organize the requirements for the following feature:

**[Feature Name]**: {{feature_name}}

## Prerequisites

Prepare the development context:

1.  **Search for feature-related information with @agent-symbol-searcher and read the found files.**
    -   Search for related existing features/components and read the corresponding files with the Read tool.
    -   Identify similar implementation patterns and architectures, and read the design documents with the Read tool.
    -   Check existing interfaces and API specifications, and read the related files with the Read tool.

2.  **Read related files directly.**
    -   `docs/implements/{{task_id}}/{feature_name}-memo.md` - To check the existing development history.
    -   `docs/implements/{{task_id}}/{feature_name}-requirements.md` - To check the existing requirements definition.
    -   `docs/implements/{{task_id}}/{feature_name}-testcases.md` - To check the existing test cases.
    -   Also read related design documents and task files as needed.

After reading is complete, start the TDD requirements definition work based on the prepared context information.

## TDD Requirements Organization Format

**[Reliability Level Instruction]**:
For each item, please comment on the verification status with the original materials (including EARS requirements definition documents and design documents) using the following signals:

- 🟢 **Green Light**: When there is almost no guesswork and it is based on the EARS requirements definition document/design document.
- 🟡 **Yellow Light**: When it is a reasonable guess from the EARS requirements definition document/design document.
- 🔴 **Red Light**: When it is a guess not found in the EARS requirements definition document/design document.

## 1. Feature Overview (Based on EARS Requirements Definition Document & Design Document)

- 🟢🟡🔴 Describe the reliability level of each item.
- What the feature does (extracted from user stories).
- What problem it solves (extracted from "As a / So that").
- The assumed user (extracted from "As a").
- Its position within the system (extracted from the architectural design).
- **Referenced EARS Requirements**: [Specific requirement ID]
- **Referenced Design Document**: [Relevant section of architecture.md]

## 2. Input/Output Specifications (Based on EARS Functional Requirements & TypeScript Type Definitions)

- 🟢🟡🔴 Describe the reliability level of each item.
- Input parameters (type, range, constraints) - extracted from interfaces.ts.
- Output values (type, format, example) - extracted from interfaces.ts.
- The relationship between input and output.
- Data flow (extracted from dataflow.md).
- **Referenced EARS Requirements**: [Specific REQ-XXX]
- **Referenced Design Document**: [Relevant interface in interfaces.ts]

## 3. Constraints (Based on EARS Non-functional Requirements & Architectural Design)

- 🟢🟡🔴 Describe the reliability level of each item.
- Performance requirements (extracted from NFR-XXX).
- Security requirements (extracted from NFR-XXX).
- Compatibility requirements (extracted from REQ-XXX MUST).
- Architectural constraints (extracted from architecture.md).
- Database constraints (extracted from database-schema.sql).
- API constraints (extracted from api-endpoints.md).
- **Referenced EARS Requirements**: [Specific NFR-XXX, REQ-XXX]
- **Referenced Design Document**: [Relevant section of architecture.md, database-schema.sql, etc.]

## 4. Assumed Usage Examples (Based on EARS Edge Cases & Data Flow)

- 🟢🟡🔴 Describe the reliability level of each item.
- Basic usage patterns (extracted from ubiquitous requirement REQ-XXX).
- Data flow (extracted from dataflow.md).
- Edge cases (extracted from EDGE-XXX).
- Error cases (extracted from EDGE-XXX error handling).
- **Referenced EARS Requirements**: [Specific EDGE-XXX]
- **Referenced Design Document**: [Relevant flow diagram in dataflow.md]

## 5. Correspondence with EARS Requirements & Design Documents

If you have referenced an existing EARS requirements definition document/design document, please specify the following correspondence:

- **Referenced User Story**: [Story name]
- **Referenced Functional Requirements**: [REQ-001, REQ-002, ...]
- **Referenced Non-functional Requirements**: [NFR-001, NFR-101, ...]
- **Referenced Edge Cases**: [EDGE-001, EDGE-101, ...]
- **Referenced Acceptance Criteria**: [Specific test items]
- **Referenced Design Documents**:
  - **Architecture**: [Relevant section of architecture.md]
  - **Data Flow**: [Relevant flow diagram in dataflow.md]
  - **Type Definitions**: [Relevant interface in interfaces.ts]
  - **Database**: [Relevant table in database-schema.sql]
  - **API Specification**: [Relevant endpoint in api-endpoints.md]

After organizing, please execute the following:

1.  Save the requirements definition document to `docs/implements/{{task_id}}/{feature_name}-requirements.md` (append if the file already exists).
2.  Update the TODO status (mark requirements definition as complete).
3.  **Quality Judgment**: Judge the quality of the requirements based on the following criteria:
    -   The requirements are clear and unambiguous.
    -   The input/output specifications are defined concretely.
    -   The constraints are clear.
    -   The implementation feasibility is certain.
4.  **Display Next Step**: Regardless of the judgment result, display the next recommended command.
    -   "Next recommended step: We will identify the test cases with `/tdd-testcases`."

## Quality Judgment Criteria

```
✅ High Quality:
- Ambiguity of requirements: None
- Input/output definition: Complete
- Constraints: Clear
- Implementation feasibility: Certain

⚠️ Needs Improvement:
- There are ambiguous parts in the requirements.
- The details of input/output are unclear.
- The technical constraints are unclear.
- The user's intent needs to be confirmed.
```

## TODO Update Pattern

```
- Mark the current TODO as "completed".
- Reflect the completion of the requirements definition phase in the TODO content.
- Add the next phase "Identify Test Cases" to the TODO.
- Record the quality judgment result in the TODO content.
```

Next step: We will identify the test cases with `/tdd-testcases`.
```
