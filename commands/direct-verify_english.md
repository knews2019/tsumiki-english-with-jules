# direct-verify

## Objective

To perform an operational check and test of the configuration work executed in a DIRECT task. To confirm that the settings have been applied correctly and that the system operates as expected.

## Prerequisites

- `direct-setup.md` has been executed.
- A task ID is provided.
- A record of the configuration work exists.

## Execution Content

**[Important]**: If any compilation or syntax errors are found in the files created by direct-setup, it will automatically attempt to resolve them.

1.  **Confirming the Configuration**
    -   Search for related settings and verification patterns with @agent-symbol-searcher, and read the found files with the Read tool.
    -   Read `docs/implements/{TASK-ID}/setup-report.md` with the Read tool to confirm the results of the configuration work.
    -   Check environment variables.
    -   Check the content of configuration files.
    -   Check the installation status of dependencies.
    -   Check the startup status of services.

2.  **Compilation/Syntax Check**
    -   Check for TypeScript/JavaScript syntax errors (if applicable).
    -   Check the syntax of configuration files (JSON, YAML, etc.).
    -   Check SQL syntax (if applicable).
    -   Resolve minimal compilation errors.

3.  **Executing Operational Tests**
    -   Search for existing test cases and verification scripts with @agent-symbol-searcher, and read the found files with the Read tool.
    -   Basic operational check.
    -   Connection test.
    -   Confirmation of permissions.
    -   Confirmation of error cases.

4.  **Quality Check**
    -   Confirmation of security settings.
    -   Confirmation of performance standards.
    -   Confirmation of logs.

## Output Destination

The confirmation record will be created as the following file in the `docs/implements/{TASK-ID}/` directory:
- `verify-report.md`: Configuration confirmation and operational test record

## Example Output Format

````markdown
# {TASK-ID} Configuration Confirmation & Operational Test

## Confirmation Overview

- **Task ID**: {TASK-ID}
- **Confirmation Content**: {Overview of the configuration confirmation}
- **Execution Date**: {Execution date}
- **Executor**: {Executor}

## Configuration Confirmation Results

### 1. Environment Variable Check

```bash
# Executed command
echo $NODE_ENV
echo $DATABASE_URL
```
````

**Confirmation Results**:

- [x] NODE_ENV: development (Expected: development)
- [x] DATABASE_URL: postgresql://localhost:5432/mydb (Expected: correct DB URL)

### 2. Configuration File Check

**File Checked**: `config/database.json`

```bash
# Executed command
cat config/database.json | jq .
```

**Confirmation Results**:

- [x] File exists.
- [x] JSON format is correct.
- [x] Contains the necessary configuration items.

## Compilation/Syntax Check Results

### 1. TypeScript/JavaScript Syntax Check

```bash
# If there are TypeScript files
npx tsc --noEmit --skipLibCheck

# JavaScript syntax check
node --check *.js
```

**Check Results**:

- [x] TypeScript syntax errors: None
- [x] JavaScript syntax errors: None
- [x] import/require statements: Normal

### 2. Configuration File Syntax Check

```bash
# JSON configuration file syntax check
cat config/*.json | jq empty

# YAML configuration file syntax check (if applicable)
yamllint config/*.yml
```

**Check Results**:

- [x] JSON syntax: Normal
- [x] YAML syntax: Normal (if applicable)
- [x] Validity of configuration items: Confirmed

### 3. SQL Syntax Check (if applicable)

```bash
# Basic SQL syntax check
psql -d mydb --single-transaction --set ON_ERROR_STOP=on -f schema.sql --dry-run
```

**Check Results**:

- [x] SQL syntax: Normal
- [x] Table definitions: Normal
- [x] Constraint definitions: Normal

### 3. Dependency Check

```bash
# Executed command
npm list express pg
```

**Confirmation Results**:

- [x] express: Installed
- [x] pg: Installed

### 4. Database Connection Test

```bash
# Executed command
psql -d mydb -c "SELECT 1;"
```

**Confirmation Results**:

- [x] Database connection successful.
- [x] Query execution successful.

## Operational Test Results

### 1. Basic Operational Test

```bash
# Executed test command
node -e "console.log('Hello, World!');"
```

**Test Results**:

- [x] Node.js execution environment: Normal
- [x] Basic JavaScript execution: Normal

### 2. Database Connection Test

```javascript
// Test script
const { Pool } = require('pg');
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

pool.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('Error:', err);
  } else {
    console.log('Connected:', res.rows[0]);
  }
  pool.end();
});
```

**Test Results**:

- [x] Database connection: Normal
- [x] Query execution: Normal
- [x] Connection termination: Normal

### 3. Security Settings Test

```bash
# Executed command
ls -la config/
ps aux | grep node
```

**Test Results**:

- [x] Configuration file permissions: Appropriate
- [x] Process execution permissions: Appropriate
- [x] Protection of sensitive information: Appropriate

## Quality Check Results

### Performance Confirmation

- [x] Startup time: within 2 seconds
- [x] Memory usage: within 256MB
- [x] CPU usage: within 10%

### Log Confirmation

- [x] Error logs: No abnormalities
- [x] Warning logs: No problems
- [x] Info logs: Outputting appropriately

## Overall Confirmation Results

- [x] Configuration work has been completed correctly.
- [x] All operational tests have succeeded.
- [x] Quality standards are met.
- [x] Ready to proceed to the next task.

## Discovered Problems and Solutions

### Resolution of Syntax/Compilation Errors

**Problems to attempt automatic resolution for**:
- TypeScript/JavaScript syntax errors
- JSON/YAML syntax errors
- Basic SQL syntax errors
- Problems with import/require statements

### Problem 1: {Describe if there is a problem}

- **Problem Content**: {Details of the problem}
- **Discovery Method**: {Syntax check/compilation/operational test}
- **Importance**: {High/Medium/Low}
- **Automatic Resolution**: {Executed resolution command/correction content}
- **Resolution Result**: {Resolved/Manual intervention required}

### Resolution Execution Log

```bash
# Example of an executed resolution command
# Fix syntax error
sed -i 's/typo/correct/g' config.js

# Fix dependencies
npm install missing-package

# Fix configuration file
jq '.port = 3000' config.json > temp.json && mv temp.json config.json
```

**Resolution Results**:
- [x] Problem 1: Resolved
- [x] Problem 2: Resolved
- [ ] Problem 3: Manual intervention required (details in recommendations)

## Recommendations

- {Describe if there are improvement proposals}
- {Describe if there are optimization proposals}

## Next Steps

- Report task completion.
- Prepare to start related tasks.
- Make fine adjustments to the settings as needed.

````

## Confirmation After Execution
- Confirm that the `docs/implements/{TASK-ID}/verify-report.md` file has been created.
- Confirm that all confirmation items have been completed.
- If any problems were discovered, confirm that they have been dealt with appropriately.
- Confirm that the task completion criteria have been met.
- Confirm that preparations for the next task are complete.

## Directory Confirmation

Please confirm that the `docs/implements/{TASK-ID}/` directory exists (it should have been created by direct-setup).

## Marking the Task as Complete
If the quality check is sufficient and all confirmation items have been cleared, please mark the corresponding task file in the `tasks` directory as complete.

### Completion Criteria
The task will be marked as complete if all of the following conditions are met:
- [ ] All configuration confirmation items are cleared.
- [ ] Compilation/syntax checks are successful (all errors resolved).
- [ ] All operational tests are successful.
- [ ] Quality check items meet the standards.
- [ ] Discovered problems have been dealt with appropriately.
- [ ] Security settings are appropriate.
- [ ] Performance standards are met.

### How to Mark as Complete
1. Confirm the task file specified by the user.
2. Add a `✅ Complete` or `[COMPLETED]` mark to the relevant section or task item in the file.
3. Record the completion date and the person who confirmed it.

## Updating README.md
If the task is complete, please create or update the `README.md` in the project's root directory.

### Content to Update
1.  **Confirm the current README.md**: If an existing README.md exists, check its content.
2.  **Add information about the completed task**:
    -   Overview of the implemented feature
    -   Configuration procedure
    -   Operational check method
    -   How to use
3.  **Update overall project information**:
    -   Setup procedure
    -   Dependencies
    -   Environmental requirements
    -   Development/operational procedures

### README.md Update Format Example

```markdown
# Project Name

## Overview
{Project overview}

## Completed Features
### {TASK-ID}: {Task Name}
- **Implementation Date**: {Implementation date}
- **Overview**: {Overview of the feature}
- **Configuration Content**: {Configured content}
- **Operational Check**: {Result of the operational check}

## Setup Procedure
### Prerequisites
- {Required environment/tools}

### Installation
```bash
# Install dependencies
{Installation command}

# Set environment variables
{Environment variable settings}
````

### How to Start

```bash
# Start the development server
{Start command}
```

## Configuration

### Environment Variables

- `{variable_name}`: {Description}

### Configuration Files

- `{config_file_path}`: {Description}

## How to Use

{Description of how to use}

## Development

### Preparing the Development Environment

{Procedure for preparing the development environment}

### Testing

{How to run tests}

## Troubleshooting

### Common Problems

- **Problem**: {Content of the problem}
- **Solution**: {Solution}

## Update History

- {Date}: {TASK-ID} {Description of change}

```

### Execution Procedure
1. Confirm the current README.md (create a new one if it doesn't exist).
2. Add information about the completed task.
3. Update other sections as needed.
4. Commit the changes.
```
