# 2.1 Required Tools and Setup

This section explains the setup procedure for the tools and environment required to practice AITDD. AITDD does not require special tools; you can get started simply by adding AI support tools to your existing development environment.

## List of Required Tools

### Essential Tools

#### 1. Claude Sonnet 4 + Claude Code
**Role**: Main AI development support tool
**Use**: Code generation, test creation, refactoring, validation
**Access Method**: Via Claude Code

#### 2. VS Code
**Role**: Integrated Development Environment
**Use**: Code editing, debugging, project management
**Feature**: Can be integrated with Claude Code

#### 3. Git + GitHub
**Role**: Version Control
**Use**: Code management, history tracking, recovery
**Importance**: A means of recovery if the AI does not produce the expected results

### Supplementary Tools

#### Gemini (Optional)
**Role**: AI for research and information gathering
**Use**: Library research, technical information gathering
**Feature**: Processing large amounts of information utilizing a long context

## Setup Procedure

### Step 1: Subscribe to the Claude Pro Plan

1.  **Create a Claude Account**
    -   Go to https://claude.ai
    -   Create an account

2.  **Upgrade to the Pro Plan**
    -   Subscribe to the Pro plan for $20/month
    -   A spending limit can be set up to $200
    -   Avoids uncapped costs like API fees

3.  **Enable Claude Code**
    -   Accessible with the Pro plan
    -   Allows for free use for development purposes

### Step 2: Set up VS Code

1.  **Install VS Code**
    ```bash
    # Windows
    winget install Microsoft.VisualStudioCode

    # macOS
    brew install --cask visual-studio-code

    # Linux
    sudo apt install code
    ```

2.  **Install Basic Extensions**
    -   Git Graph (Visualize Git operations)
    -   GitLens (Enhanced Git information display)
    -   Language-specific extensions (JavaScript, Python, etc.)

3.  **Configure Claude Code Integration**
    -   Set up via the VS Code plugin or Claude Code settings
    -   Configure integration with the project directory

### Step 3: Set up the Git Environment

1.  **Install and Configure Git**
    ```bash
    # Basic configuration
    git config --global user.name "Your Name"
    git config --global user.email "your.email@example.com"

    # Set default branch
    git config --global init.defaultBranch main
    ```

2.  **Prepare a GitHub Account**
    -   Create a GitHub account
    -   Set up an SSH key or Personal Access Token
    -   Prepare to create a repository

3.  **Branching Strategy for AITDD**
    ```bash
    # Basic workflow
    git checkout -b feature/new-functionality
    # Practice AITDD
    git add .
    git commit -m "Implement feature with AITDD"
    git push origin feature/new-functionality
    ```

## AI Tool Comparison and Selection Criteria

### Why We Chose Claude Sonnet 4

This section explains why we chose Claude Sonnet 4 as our primary tool for practicing AITDD from among the many AI tools available.

#### Selection Based on Overall Evaluation

**Key Considerations:**
1.  **Cost-Effectiveness**: Frequent trials in AITDD make a reasonable cost level essential.
2.  **Coding Performance**: Emphasize stable performance over peak performance.
3.  **Accessibility**: Can be used freely with a less restrictive plan.
4.  **Integration**: Integration with the development environment and workflow consistency.

**Advantages of Claude Sonnet 4:**
-   **Claude Code Integration**: Tight integration via the VS Code plugin.
-   **Pro Plan**: $20/month with a spending limit settable up to $200 (avoids uncapped API costs).
-   **AITDD Suitability**: Optimized for a development style that emphasizes trials.
-   **Overall Balance**: The optimal balance of performance, cost, and ease of use.

#### Comparison Results with Other Tools

**AI Tools Considered:**
-   ChatGPT: High performance but has cost issues.
-   GitHub Copilot: Specializes in code completion, insufficient for AITDD as a whole.
-   Other AI tools: After trials, we converged on Claude Sonnet 4 for its overall capabilities.

**Reason for Convergence:**
```
Item               Claude Sonnet 4    Other Tools
──────────────────────────────────────────
Cost-Effectiveness ◎                △
Coding Performance   ○                ◎
Accessibility      ◎                △
Integration        ◎                ○
AITDD Suitability  ◎                △
──────────────────────────────────────────
Overall Evaluation   Optimal            Has issues
```

### Strategy for Using Gemini in Conjunction

While Claude Sonnet 4 is the primary tool, Gemini is used as a supplementary tool for specific purposes.

#### Basic Policy for Division of Use

**Claude Sonnet 4 (Primary Tool):**
-   All implementation phases (Design → Test → Implement → Refactor → Validation)
-   Consistent execution of the entire AITDD process
-   Balancing code generation and quality checks

**Gemini (Supplementary Tool):**
-   Technical research and information gathering
-   Processing large amounts of information using a long context
-   Researching necessary libraries
-   Tasks that require a large amount of investigation

#### Specific Collaboration Patterns

```
Research Phase:
Gemini → Gather technical info → Provide info to Claude Sonnet 4

Implementation Phase:
Claude Sonnet 4 → Execute a consistent AITDD process
```

**Practical Example of Collaboration:**
1.  **Research a new library**: Gather information with Gemini.
2.  **Integrate research results**: Provide the results to Claude Sonnet 4.
3.  **Execute implementation**: Run the AITDD process with Claude Sonnet 4.

### Fallback Strategy

This section explains how to handle situations where the AI does not produce the expected results.

#### Basic Fallback Procedure

**Step 1: Restore the State**
```bash
# Revert to the previous state
git reset --hard HEAD~1
# Or revert to a specific commit
git reset --hard <commit-hash>
```

**Step 2: Adjust the Prompt**
-   Clarify and add detail to the instructions.
-   Add contextual information.
-   Explicitly state constraints.

**Step 3: Rerun**
-   Retry with the same tool (Claude Sonnet 4).
-   Do not switch to another tool.
-   Maintain a consistent approach.

#### Fallback Decision Criteria

**When to run `git reset`:**
-   When the final code deviates significantly from expectations.
-   When it's judged faster to start over than to request corrections.
-   When no improvement is seen after several correction attempts.

**Guidelines for Prompt Adjustment:**
```
# Before improvement (ambiguous)
"Fix this code"

# After improvement (specific)
"Fix the following issues in this code:
1. Validation errors are not handled properly.
2. The return type differs from the specification.
3. Edge case tests are missing."
```

#### Characteristics of the Fallback Strategy

**Simplicity:**
-   Avoids complex decision logic.
-   Emphasizes rapid recovery.

**Consistency:**
-   Based on retrying with the same tool.
-   Avoids confusion from switching tools.

**Learnability:**
-   Hone your instincts through repetition.
-   Accumulate experience to improve judgment criteria.

### How to Evaluate New AI Tools

To ensure continuous improvement, we also define a method for evaluating new AI tools.

#### Evaluation Process

**Information Gathering Phase:**
1.  **Constant Monitoring**: Always check for information on new AI tools.
2.  **Check for Buzz**: Is there sustained interest, not just a temporary boom?
3.  **Community Reaction**: Check the evaluation in the developer community.

**Trial Decision Criteria:**
-   **Sustainability**: Has the topic been discussed for several months?
-   **Practicality**: Can it be applied to the AITDD workflow?
-   **Cost-Effectiveness**: Does it have an advantage over the current tool setup?

**A Cautious Approach:**
-   Don't jump on it right away; gather sufficient information.
-   Evaluate while maintaining the current stable workflow.
-   Consider migrating only if a clear advantage is confirmed.

## Recommended Technology Stack

### Programming Languages

#### Recommended Languages
**JavaScript/TypeScript**
-   Package Management: npm/yarn
-   Transparency: Visualization of dependencies with package.json
-   AI Compatibility: Can dynamically research libraries

**Python**
-   Package Management: pip/poetry
-   Transparency: Visualization of dependencies with requirements.txt
-   AI Compatibility: Rich library information is available to AI

#### Languages Requiring Caution
**Compiled languages like Java/C#**
-   Reason: Binary distribution of jars and ddls makes it difficult for AI to dynamically research dependencies.
-   Response: Can be used, but requires prior preparation and human assistance.

### Project Types

#### Optimal Projects
-   **Applications centered on CRUD operations**
-   **Web API development**
-   **Database-integrated applications**
-   **Relatively large-scale projects**

#### Effective Code Patterns
-   Situations where a lot of similar code is created.
-   Processes that are easy to template.
-   Implementation of standard design patterns.

## Cost Management

### Expected Costs
-   **Claude Pro**: $20/month
-   **GitHub**: Free for personal use, $4/user/month for team use
-   **VS Code**: Free
-   **Other**: Project-specific dependency costs

### Key Points for Cost Optimization
1.  **Set a limit for Claude Pro**: Set a maximum of $200.
2.  **Efficient Use**: Optimize AI usage with clear goal setting.
3.  **Git History Management**: An appropriate commit strategy to avoid wasteful trial and error.

## Confirmation of Setup Completion

Check the following items to confirm that the setup is complete:

-   [ ] Claude Pro plan is active.
-   [ ] Claude Code is accessible.
-   [ ] VS Code is installed.
-   [ ] Basic VS Code extensions are installed.
-   [ ] Git is configured.
-   [ ] GitHub account is ready.
-   [ ] A project directory has been created.
-   [ ] The basic environment for the selected tech stack is ready.

## Troubleshooting

### Common Problems and Solutions

**Cannot access Claude Code**
-   Confirm that the Pro plan is active.
-   Clear the browser cache.
-   Check the network connection.

**Problem with VS Code integration**
-   Reinstall the Claude Code plugin.
-   Restart VS Code.
-   Check the configuration files.

**Error during Git operations**
-   Reconfigure authentication credentials.
-   Check the remote repository URL.
-   Check access permissions.

## Next Steps

Once the tool setup is complete, let's learn how to use the AI tools specifically in the next chapter, "2.2 How to Utilize Claude Sonnet 4". By mastering the techniques of effective prompt design and collaboration with AI, you will be able to unlock the true potential of AITDD.
