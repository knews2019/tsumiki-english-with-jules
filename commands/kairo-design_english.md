# kairo-design

## Objective

To generate a technical design document based on an approved requirements definition document. To perform a comprehensive design including data flow diagrams, TypeScript interfaces, database schemas, and API endpoints.

## Prerequisites

- A requirements definition document exists in `docs/spec/`.
- The requirements have been approved by the user.

## Execution Content

**[Reliability Level Instruction]**:
For each item, please comment on the verification status with the original materials (including EARS requirements definition documents and design documents) using the following signals:

- 🟢 **Green Light**: When there is almost no guesswork and it is based on the EARS requirements definition document/design document.
- 🟡 **Yellow Light**: When it is a reasonable guess from the EARS requirements definition document/design document.
- 🔴 **Red Light**: When it is a guess not found in the EARS requirements definition document/design document.

1.  **Analyze Requirements**
    -   Search for the requirements definition document with @agent-symbol-searcher, and read the found file with the Read tool.
    -   Check for related existing design documents with @agent-symbol-searcher, and read the found files with the Read tool.
    -   Organize functional and non-functional requirements.
    -   Clarify the system boundaries.

2.  **Architectural Design**
    -   Decide on the overall system architecture.
    -   Separate the frontend/backend.
    -   Consider the need for microservices.

3.  **Create a Data Flow Diagram**
    -   Visualize the data flow with Mermaid syntax.
    -   The flow of user interaction.
    -   The flow of data between systems.

4.  **Define TypeScript Interfaces**
    -   Type definitions for entities.
    -   Type definitions for API requests/responses.
    -   Definition of common types.

5.  **Design the Database Schema**
    -   Table definitions.
    -   Relationships.
    -   Index strategy.
    -   Decision on the normalization level.

6.  **Design API Endpoints**
    -   RESTful API design.
    -   Endpoint naming conventions.
    -   Appropriate use of HTTP methods.
    -   Structure of requests/responses.

7.  **Create Files**
    -   Create the following in the `docs/design/{requirement_name}/` directory:
        -   `architecture.md` - Architecture overview
        -   `dataflow.md` - Data flow diagram
        -   `interfaces.ts` - TypeScript type definitions
        -   `database-schema.sql` - DB schema
        -   `api-endpoints.md` - API specification

## Example Output Format

### architecture.md

```markdown
# {Requirement Name} Architecture Design

## System Overview

{System overview description}

## Architectural Pattern

- Pattern: {Selected pattern}
- Reason: {Reason for selection}

## Component Configuration

### Frontend

- Framework: {Framework used}
- State Management: {State management method}

### Backend

- Framework: {Framework used}
- Authentication Method: {Authentication method}

### Database

- DBMS: {DBMS used}
- Caching: {Caching strategy}
```

### dataflow.md

```markdown
# Data Flow Diagram

## User Interaction Flow

\`\`\`mermaid
flowchart TD
A[User] --> B[Frontend]
B --> C[API Gateway]
C --> D[Backend]
D --> E[Database]
\`\`\`

## Data Processing Flow

\`\`\`mermaid
sequenceDiagram
participant U as User
participant F as Frontend
participant B as Backend
participant D as Database

    U->>F: Action
    F->>B: API Request
    B->>D: Execute Query
    D-->>B: Return Result
    B-->>F: Response
    F-->>U: Update Screen

\`\`\`
```

### interfaces.ts

```typescript
// Entity Definition
export interface User {
  id: string;
  email: string;
  name: string;
  createdAt: Date;
  updatedAt: Date;
}

// API Request/Response
export interface CreateUserRequest {
  email: string;
  name: string;
  password: string;
}

export interface ApiResponse<T> {
  success: boolean;
  data?: T;
  error?: {
    code: string;
    message: string;
  };
}
```

### database-schema.sql

```sql
-- Users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index
CREATE INDEX idx_users_email ON users(email);
```

### api-endpoints.md

```markdown
# API Endpoint Specification

## Authentication

### POST /auth/login

Request:
\`\`\`json
{
"email": "user@example.com",
"password": "password"
}
\`\`\`

Response:
\`\`\`json
{
"success": true,
"data": {
"token": "jwt-token",
"user": { ... }
}
}
\`\`\`

## User Management

### GET /users/:id

### POST /users

### PUT /users/:id

### DELETE /users/:id
```

## Confirmation After Execution

-   Check the consistency between the created design and the existing system with @agent-symbol-searcher.
-   Display a list of the created files.
-   Display a summary of the main points of the design.
-   Display a message prompting the user for confirmation.
```
