# Contribution Guide

Thank you for your interest in contributing to the Tsumiki project! This guide explains how you can contribute to the project.

## Development Environment Setup

### Prerequisites

- Node.js 18.0.0 or higher
- pnpm 10.13.1 or higher

### Setup Steps

1.  Fork and clone the repository:

    ```bash
    git clone https://github.com/YOUR_USERNAME/tsumiki.git
    cd tsumiki
    ```

2.  Install dependencies:

    ```bash
    pnpm install
    ```

3.  Set up the pre-commit hook:

    ```bash
    pnpm prepare
    ```

## Development Workflow

### Branching Strategy

-   `main` branch: Stable version of the code
-   Feature development: `feature/feature-name`
-   Bug fixes: `bugfix/bug-name`
-   Hotfixes: `hotfix/fix-description`

### Development Steps

1.  Create a new branch:

    ```bash
    git checkout -b feature/your-feature-name
    ```

2.  Make your code changes.

3.  Run code quality checks:

    ```bash
    # Type check
    pnpm typecheck

    # Code check
    pnpm check

    # Auto-fix
    pnpm fix

    # Secret scanning
    pnpm secretlint
    ```

4.  Run a build test:

    ```bash
    pnpm build:run
    ```

5.  Commit your changes:

    ```bash
    git add .
    git commit -m "feat: Add new feature"
    ```

## Commit Message Convention

Please use the [Conventional Commits](https://www.conventionalcommits.org/) format:

-   `feat:` A new feature
-   `fix:` A bug fix
-   `docs:` Documentation changes
-   `style:` Code style changes (that do not affect functionality)
-   `refactor:` Refactoring
-   `test:` Adding or fixing tests
-   `chore:` Changes to the build process or tools

Example:
```
feat: add new install command for .sh files
fix: resolve path handling issue in install command
docs: update README with new command examples
```

## Code Quality Standards

### Automatic Checks

The following are run automatically via a pre-commit hook:

-   **secretlint**: Checks for leaked secrets (API keys, passwords, etc.)
-   **typecheck**: TypeScript type checking
-   **fix**: Automatic code fixing by Biome

### Manual Checks

Please run the following commands before making changes:

```bash
# Run all checks
pnpm typecheck && pnpm check && pnpm secretlint

# Auto-fix code
pnpm fix
```

## Project Structure

```
tsumiki/
├── src/
│   ├── cli.ts              # CLI entry point
│   └── commands/
│       └── install.tsx     # UI implementation for the install command
├── commands/               # Command templates (.md, .sh)
├── dist/                   # Build output
├── package.json
├── CLAUDE.md               # Project instructions
└── README.md
```

## Pull Requests

### Creating a Pull Request

1.  Push your changes:

    ```bash
    git push origin feature/your-feature-name
    ```

2.  Create a pull request on GitHub.

3.  Provide a description according to the pull request template.

### Pull Request Requirements

-   [ ] The changes are clearly explained.
-   [ ] Related issues are linked (if applicable).
-   [ ] Code quality checks have passed.
-   [ ] The build is successful.
-   [ ] No sensitive information is included.

## Reporting Issues

Bug reports and feature requests are accepted via [Issues](https://github.com/classmethod/tsumiki/issues).

### Bug Reports

Please include the following information:

-   Steps to reproduce
-   Expected behavior
-   Actual behavior
-   Environment information (OS, Node.js version, etc.)
-   Error message (if applicable)

### Feature Requests

Please include the following information:

-   Description of the proposed feature
-   Use case
-   Expected benefits
-   Implementation proposal (if any)

## Security

If you discover a security-related issue, please report it privately instead of in a public issue.

## License

This project is released under the MIT License. By contributing, you agree that your contributions will be licensed under this license.

## Questions & Support

-   [Issues](https://github.com/classmethod/tsumiki/issues) - Bug reports, feature requests
-   [Discussions](https://github.com/classmethod/tsumiki/discussions) - Questions, discussions

We look forward to your contributions!
