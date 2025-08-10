# direct-setup

## Objective

Executes the setup work for a DIRECT task. Based on the design document, it performs environment construction, configuration file creation, dependency installation, etc.

## Prerequisites

- A task ID is provided.
- Related design documents exist.
- The necessary permissions and environment are prepared.

## Execution Content

1.  **Confirm the Design Document**
    -   Search for related design documents and configuration patterns with @agent-symbol-searcher, and read the found files with the Read tool.
    -   Read `docs/design/{requirement_name}/architecture.md` with the Read tool.
    -   Read `docs/design/{requirement_name}/database-schema.sql` with the Read tool.
    -   Read other related design documents with the Read tool.

2.  **Execute the Setup Work**
    -   Search for existing configuration files and environment variables with @agent-symbol-searcher, and read the found files with the Read tool.
    -   Set environment variables.
    -   Create/update configuration files.
    -   Install dependencies.
    -   Initialize the database.
    -   Configure service startup.
    -   Set permissions.

3.  **Create a Work Record**
    -   Record the executed commands.
    -   Record the changed settings.
    -   Record any problems encountered and their solutions.

## Output Destination

The work record will be created as the following file in the `docs/implements/{TASK-ID}/` directory:
- `setup-report.md`: Setup work execution record

## Example Output Format

````markdown
# {TASK-ID} Setup Work Execution

## Work Overview

- **Task ID**: {TASK-ID}
- **Work Content**: {Overview of the setup work}
- **Execution Date**: {Execution date}
- **Executor**: {Executor}

## Design Document Reference

- **Referenced Documents**: {List of referenced design documents}
- **Related Requirements**: {REQ-XXX, REQ-YYY}

## Work Performed

### 1. Setting Environment Variables

```bash
# Executed command
export NODE_ENV=development
export DATABASE_URL=postgresql://localhost:5432/mydb
```
````

**Configuration Content**:

- NODE_ENV: Set to the development environment
- DATABASE_URL: URL of the PostgreSQL database

### 2. Creating a Configuration File

**File Created**: `config/database.json`

```json
{
  "development": {
    "host": "localhost",
    "port": 5432,
    "database": "mydb"
  }
}
```

### 3. Installing Dependencies

```bash
# Executed command
npm install express pg
```

**Installation Content**:

- express: Web framework
- pg: PostgreSQL client

### 4. Initializing the Database

```bash
# Executed command
createdb mydb
psql -d mydb -f database-schema.sql
```

**Execution Content**:

- Create the database
- Apply the schema

## Work Results

- [ ] Environment variables set.
- [ ] Configuration file created.
- [ ] Dependencies installed.
- [ ] Database initialized.
- [ ] Service startup configured.

## Problems Encountered and Solutions

### Problem 1: {Overview of the problem}

- **Situation**: {The situation in which the problem occurred}
- **Error Message**: {Error message}
- **Solution**: {Solution}

## Next Steps

- Run `direct-verify.md` to confirm the settings.
- Make adjustments to the settings as needed.

```

## Confirmation After Execution
- Confirm that the `docs/implements/{TASK-ID}/setup-report.md` file has been created.
- Confirm that the settings have been applied correctly.
- Confirm that preparations for the next step (direct-verify) are complete.

## Directory Creation

Please create the necessary directories before execution:
```bash
mkdir -p docs/implements/{TASK-ID}
```
```
