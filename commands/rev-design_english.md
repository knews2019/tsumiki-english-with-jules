# rev-design

## Objective

To reverse-generate a technical design document from an existing codebase. To analyze the implemented architecture, data flow, API specifications, database schema, and TypeScript interfaces, and document them as a design document.

## Prerequisites

- The codebase to be analyzed exists.
- The `docs/reverse/` directory exists (if not, create it).
- If possible, `rev-tasks.md` has been executed beforehand.

## Execution Content

1.  **Analyze the Architecture**
    -   Identify the architectural pattern from the project structure.
    -   Confirm the layer structure (MVC, Clean Architecture, etc.).
    -   Check for the presence of a microservices configuration.
    -   The separation status of the frontend/backend.

2.  **Extract the Data Flow**
    -   The flow of user interaction.
    -   The flow of API calls.
    -   Database access patterns.
    -   The flow of state management.

3.  **Extract API Specifications**
    -   Generate a list of endpoints.
    -   Analyze the structure of requests/responses.
    -   Confirm the authentication/authorization method.
    -   The format of error responses.

4.  **Reverse-generate the Database Schema**
    -   Extract table definitions.
    -   Analyze relationships.
    -   Confirm index settings.
    -   Extract constraints.

5.  **Organize TypeScript Type Definitions**
    -   Extract entity types.
    -   Extract API types.
    -   Organize common types.
    -   Analyze type dependencies.

6.  **Analyze Component Design**
    -   UI component hierarchy.
    -   Props interface.
    -   Design of state management.
    -   Routing design.

7.  **Create Files**
    -   Create the following in the `docs/reverse/{project_name}/` directory:
        -   `architecture.md` - Architecture overview
        -   `dataflow.md` - Data flow diagram
        -   `api-specs.md` - API specification
        -   `database.md` - DB design
        -   `interfaces.ts` - Aggregated type definitions

## Example Output Format

### architecture.md

```markdown
# {Project Name} Architecture Design (Reverse-generated)

## Analysis Date
{Execution date}

## System Overview

### Implemented Architecture
- **Pattern**: {Identified architectural pattern}
- **Framework**: {Framework used}
- **Configuration**: {Discovered configuration}

### Technology Stack

#### Frontend
- **Framework**: {React/Vue/Angular, etc.}
- **State Management**: {Redux/Zustand/Pinia, etc.}
- **UI Library**: {Material-UI/Ant Design, etc.}
- **Styling**: {CSS Modules/styled-components, etc.}

#### Backend
- **Framework**: {Express/NestJS/FastAPI, etc.}
- **Authentication Method**: {JWT/Session/OAuth, etc.}
- **ORM/Data Access**: {TypeORM/Prisma/Sequelize, etc.}
- **Validation**: {Joi/Yup/zod, etc.}

#### Database
- **DBMS**: {PostgreSQL/MySQL/MongoDB, etc.}
- **Caching**: {Redis/Memcached, etc. or none}
- **Connection Pooling**: {Is it implemented?}

#### Infrastructure & Tools
- **Build Tool**: {Webpack/Vite/Rollup, etc.}
- **Test Framework**: {Jest/Vitest/Pytest, etc.}
- **Code Quality**: {ESLint/Prettier/SonarQube, etc.}

## Layer Structure

### Discovered Layers
```
{Actual directory structure}
```

### Layer Responsibility Analysis
- **Presentation Layer**: {Implementation status}
- **Application Layer**: {Implementation status}
- **Domain Layer**: {Implementation status}
- **Infrastructure Layer**: {Implementation status}

## Design Patterns

### Discovered Patterns
- **Dependency Injection**: {Is it implemented?}
- **Repository Pattern**: {Is it implemented?}
- **Factory Pattern**: {Where it is used}
- **Observer Pattern**: {Where it is used}
- **Strategy Pattern**: {Where it is used}

## Implementation Status of Non-functional Requirements

### Security
- **Authentication**: {Implementation method}
- **Authorization**: {Implementation method}
- **CORS Settings**: {Configuration status}
- **HTTPS Support**: {Support status}

### Performance
- **Caching**: {Implementation status}
- **Database Optimization**: {Indexes, etc.}
- **CDN**: {Usage status}
- **Image Optimization**: {Implementation status}

### Operation & Monitoring
- **Logging**: {Implementation status}
- **Error Tracking**: {Implementation status}
- **Metrics Collection**: {Implementation status}
- **Health Check**: {Implementation status}
```

### dataflow.md

```markdown
# Data Flow Diagram (Reverse-generated)

## User Interaction Flow

### Authentication Flow
\`\`\`mermaid
sequenceDiagram
    participant U as User
    participant F as Frontend
    participant B as Backend
    participant D as Database

    U->>F: Enter login information
    F->>B: POST /auth/login
    B->>D: User verification
    D-->>B: User information
    B-->>F: JWT token
    F-->>U: Login complete
\`\`\`

### Data Retrieval Flow
\`\`\`mermaid
flowchart TD
    A[User Action] --> B[React Component]
    B --> C[useQuery Hook]
    C --> D[Axios HTTP Client]
    D --> E[API Gateway/Express]
    E --> F[Controller]
    F --> G[Service Layer]
    G --> H[Repository Layer]
    H --> I[Database]
    I --> H
    H --> G
    G --> F
    F --> E
    E --> D
    D --> C
    C --> B
    B --> J[UI Update]
\`\`\`

## State Management Flow

### {Used State Management Library} Flow
\`\`\`mermaid
flowchart LR
    A[Component] --> B[Action Dispatch]
    B --> C[Reducer/Store]
    C --> D[State Update]
    D --> A
\`\`\`

## Error Handling Flow

\`\`\`mermaid
flowchart TD
    A[Error Occurs] --> B{Error Type}
    B -->|Authentication Error| C[Redirect to Login]
    B -->|Network Error| D[Retry Feature]
    B -->|Validation Error| E[Display Form Error]
    B -->|Server Error| F[Display Error Toast]
\`\`\`
```

### api-specs.md

```markdown
# API Specification (Reverse-generated)

## Base URL
\`{Discovered base URL}\`

## Authentication Method
{Details of the discovered authentication method}

## Endpoint List

### Authentication Related

#### POST /auth/login
**Description**: User login

**Request**:
\`\`\`typescript
{
  email: string;
  password: string;
}
\`\`\`

**Response**:
\`\`\`typescript
{
  success: boolean;
  data: {
    token: string;
    user: {
      id: string;
      email: string;
      name: string;
    }
  };
}
\`\`\`

**Error Response**:
\`\`\`typescript
{
  success: false;
  error: {
    code: string;
    message: string;
  }
}
\`\`\`

#### POST /auth/logout
**Description**: User logout

**Header**:
\`\`\`
Authorization: Bearer {token}
\`\`\`

### {Other Endpoints}

## Error Code List

| Code | Message | Description |
|---|---|---|
| AUTH_001 | Invalid credentials | Invalid credentials |
| AUTH_002 | Token expired | The token has expired |
| VALID_001 | Validation failed | Validation error |

## Common Response Format

### Success Response
\`\`\`typescript
{
  success: true;
  data: T; // Type varies depending on the endpoint
}
\`\`\`

### Error Response
\`\`\`typescript
{
  success: false;
  error: {
    code: string;
    message: string;
    details?: any;
  }
}
\`\`\`
```

### database.md

```markdown
# Database Design (Reverse-generated)

## Schema Overview

### Table List
{List of discovered tables}

### ER Diagram
\`\`\`mermaid
erDiagram
    USERS {
        uuid id PK
        varchar email UK
        varchar name
        timestamp created_at
        timestamp updated_at
    }

    POSTS {
        uuid id PK
        uuid user_id FK
        varchar title
        text content
        timestamp created_at
        timestamp updated_at
    }

    USERS ||--o{ POSTS : creates
\`\`\`

## Table Details

### users Table
\`\`\`sql
{Actual CREATE TABLE statement}
\`\`\`

**Column Description**:
- \`id\`: {Description}
- \`email\`: {Description}
- \`name\`: {Description}

**Indexes**:
- \`idx_users_email\`: For searching the email column

### {Other Tables}

## Constraints & Relationships

### Foreign Key Constraints
{Discovered foreign key constraints}

### Unique Constraints
{Discovered unique constraints}

## Data Access Patterns

### Frequently Used Queries
{Query patterns discovered from the code}

### Performance Considerations
{Discovered index strategy}
```

### interfaces.ts

```typescript
// ======================
// Entity Type Definitions
// ======================

export interface User {
  id: string;
  email: string;
  name: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface Post {
  id: string;
  userId: string;
  title: string;
  content: string;
  createdAt: Date;
  updatedAt: Date;
  user?: User;
}

// ======================
// API Type Definitions
// ======================

export interface LoginRequest {
  email: string;
  password: string;
}

export interface LoginResponse {
  success: boolean;
  data: {
    token: string;
    user: User;
  };
}

export interface ApiResponse<T = any> {
  success: boolean;
  data?: T;
  error?: {
    code: string;
    message: string;
    details?: any;
  };
}

// ======================
// Component Props Types
// ======================

export interface LoginFormProps {
  onSubmit: (data: LoginRequest) => void;
  loading?: boolean;
  error?: string;
}

// ======================
// State Management Types
// ======================

export interface AuthState {
  user: User | null;
  token: string | null;
  isAuthenticated: boolean;
  loading: boolean;
}

// ======================
// Configuration Types
// ======================

export interface AppConfig {
  apiBaseUrl: string;
  tokenStorageKey: string;
  supportedLanguages: string[];
}
```

## Analysis Algorithm

### 1. File Scanning & Pattern Matching
- Extraction of functions, classes, and interfaces by AST analysis.
- Analysis of configuration files by regular expressions.
- Estimation of the architecture from the directory structure.

### 2. Automatic Generation of API Specifications
- Analysis of Express/NestJS route definitions.
- Analysis of FastAPI schema definitions.
- Estimation of requests/responses from TypeScript type definitions.

### 3. Extraction of the Database Schema
- Analysis of migration files.
- Analysis of ORM model definitions.
- Analysis of SQL files.

## Example Execution Commands

```bash
# Full analysis (generate all design documents)
claude code rev-design

# Generate only a specific design document
claude code rev-design --target architecture
claude code rev-design --target api
claude code rev-design --target database

# Analyze a specific directory
claude code rev-design --path ./backend

# Specify the output format
claude code rev-design --format markdown,openapi
```

## Confirmation After Execution

-   Display a list of the generated design document files.
-   Display statistical information such as the number of extracted APIs, tables, and type definitions.
-   Present any missing design elements or recommended improvements.
-   Propose the next reverse engineering step (requirements definition generation, etc.).
```
