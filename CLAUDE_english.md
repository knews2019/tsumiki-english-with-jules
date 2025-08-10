# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Tsumiki is a CLI tool that provides command templates for an AI-driven development framework. This project is a CLI application built with TypeScript + React and Ink, which installs command templates for Claude Code into the user's `.claude/commands/` directory.

## Development Commands

```bash
# Development Environment
pnpm install                # Install dependencies

# Build
pnpm build                  # Build the project and copy the commands directory to dist/
pnpm build:run              # Run the CLI after building (for testing)

# Code Quality
pnpm check                  # Check code with Biome
pnpm fix                    # Automatically fix code with Biome
pnpm typecheck              # Type check with TypeScript (using tsgo)
pnpm secretlint             # Scan for secrets

# pre-commit hook
pnpm prepare                # Set up simple-git-hooks
```

## Project Structure

- **`src/cli.ts`**: CLI entry point, defines commands using commander
- **`src/commands/install.tsx`**: UI implementation for the install command using React + Ink
- **`commands/`**: Claude Code command templates for the Tsumiki AI development framework (`.md` and `.sh` files)
- **`dist/`**: Build output, templates are copied to `dist/commands/`

## Technology Stack

- **CLI Framework**: Commander.js
- **UI Framework**: React + Ink (for React rendering in the CLI)
- **Build Tool**: tsup (based on TypeScript + ESBuild)
- **Code Quality**: Biome (linter and formatter)
- **TypeScript**: tsgo (for fast type checking)
- **Package Manager**: pnpm

## Build Process

During the build (`pnpm build`), the following actions are performed:
1. Clean the `dist` directory
2. Create the `dist/commands` directory
3. Copy `.md` and `.sh` files from `commands/` to `dist/commands/`
4. Build the TypeScript code into both ESM and CJS formats using tsup

## Installation Behavior

The `tsumiki install` command performs the following:
1. Creates a `.claude/commands/` directory in the current directory
2. Copies all `.md` and `.sh` files from the pre-built `dist/commands/`
3. Displays a progress bar and a list of files using React + Ink

## Quality Control

The following are run automatically via a pre-commit hook:
- `pnpm secretlint`: Checks for sensitive information
- `pnpm typecheck`: Type checking
- `pnpm fix`: Automatic code fixing

When modifying code, please be sure to run `pnpm check` and `pnpm typecheck` before committing.
