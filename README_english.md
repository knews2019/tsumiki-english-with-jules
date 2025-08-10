# Tsumiki - AI-Driven Development Support Framework

Tsumiki is a framework for AI-driven development. It provides an efficient development process utilizing AI from requirements definition to implementation.

## Installation

To use Tsumiki, please install it with the following npx command:

```bash
npx tsumiki install
```

Running this command will install Tsumiki's Claude Code slash commands into `.claude/commands/`.

## Overview

Tsumiki consists of the following two command groups:

- **kairo** - A comprehensive development flow from requirements definition to implementation.
- **tdd** - Individual execution of Test-Driven Development (TDD) steps.

### Kairo Commands

Kairo automates and supports the development process from requirements definition to implementation. It supports the following development flow:

1.  **Requirements Definition** - Generate a detailed requirements document from an overview.
2.  **Design** - Automatically generate technical design documents.
3.  **Task Division** - Appropriately divide and sequence implementation tasks.
4.  **TDD Implementation** - High-quality implementation through Test-Driven Development.

## Available Commands

### Kairo Commands (Comprehensive Development Flow)
- `kairo-requirements` - Requirements Definition
- `kairo-design` - Design Document Generation
- `kairo-tasks` - Task Division
- `kairo-implement` - Implementation Execution

### TDD Commands (Individual Execution)
- `tdd-requirements` - TDD Requirements Definition
- `tdd-testcases` - Test Case Creation
- `tdd-red` - Test Implementation (Red)
- `tdd-green` - Minimal Implementation (Green)
- `tdd-refactor` - Refactoring
- `tdd-verify-complete` - TDD Completion Verification

### Reverse Engineering Commands
- `rev-tasks` - Reverse-generate a task list from existing code.
- `rev-design` - Reverse-generate a design document from existing code.
- `rev-specs` - Reverse-generate a test specification from existing code.
- `rev-requirements` - Reverse-generate a requirements definition from existing code.

## Quick Start

### Comprehensive Development Flow

```bash
# 1. Requirements Definition
/kairo-requirements

# 2. Design
/kairo-design

# 3. Task Division
/kairo-tasks

# 4. Implementation
/kairo-implement
```

### Individual TDD Process

```bash
/tdd-requirements
/tdd-testcases
/tdd-red
/tdd-green
/tdd-refactor
/tdd-verify-complete
```

### Reverse Engineering

```bash
# 1. Analyze task structure from existing code
/rev-tasks

# 2. Reverse-generate design document (recommended after task analysis)
/rev-design

# 3. Reverse-generate test specification (recommended after design document)
/rev-specs

# 4. Reverse-generate requirements definition (recommended after all analysis is complete)
/rev-requirements
```

### Clean Up Development Environment

```bash
# Clean up the development environment
/clear
```

## Detailed Manual

For detailed usage instructions, directory structure, workflow examples, and troubleshooting, please refer to [MANUAL.md](./MANUAL.md).
