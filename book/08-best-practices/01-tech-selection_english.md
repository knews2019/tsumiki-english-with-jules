# 8.1 Technology Selection Guidelines

This section provides practical guidelines for engineers to make appropriate judgments when selecting technologies for practicing AITDD.

## Criteria for Selecting AI Tools

### Prioritizing Organizational Policy

#### Use of Company-designated AI Tools
We prioritize organizational governance and compliance over technical superiority.

- **Use only approved tools**: Use only AI tools designated by the company for business purposes.
- **Compliance with organizational policy**: Prioritize organizational rules over technical superiority.
- **Regular policy confirmation**: Regularly check for changes in the AI tool usage guidelines.

#### Recommended Tool: Claude Sonnet 4
Recommended tools based on current practical experience and the reasons for them:

- **High-quality implementation generation**: Code generation capabilities suitable for the TDD process.
- **Claude Code integration**: Improved efficiency through integration with the development environment.
- **Japanese language support**: Quality of specification descriptions and comment generation.
- **Token capacity**: Stable operation in a large context.

### Criteria for Technology Selection

#### Project Application Conditions

**Cases Suitable for Application**
- **New development projects**: Very suitable.
- **Modern technology stack**: AI support is effective.
- **Clear requirements definition**: When specifications are clarified.
- **Iterative development**: Agile/incremental development.

**Cases Not Suitable for Application**
- **Projects related to human life**: Not applicable.
- **Legacy systems**: Existing systems with complex constraints.
- **Extremely high quality requirements**: Projects with low risk tolerance.
- **Short-term, small-scale modifications**: When the cost of introducing AITDD is not justified.

## Security and Compliance

### Confidential Information Management

#### Criteria for Transmittable Information
Practical criteria for ensuring the safety of information sent to AI tools:

- **Exclusion of personal information**: Information that can identify individuals is not to be sent.
- **Exclusion of confidential data**: Information classified as company confidential is not to be sent.
- **General technical information**: Only publicly available technical information is permitted to be sent.

#### Practical Data Protection Methods
```
Pre-transmission checklist:
□ Check for the presence of personal information.
□ Confirm the removal of confidential data.
□ Evaluate the necessity of transmission.
□ Consider alternative methods.
```

### Consideration of Intellectual Property Rights

#### Compliance with Organizational Policy
- **Application of intellectual property policy**: Operation in accordance with the organization's intellectual property policy.
- **Collaboration with the legal department**: Consultation with the legal department as needed.
- **Confirmation of contract terms**: Confirmation of the terms of the AI tool usage agreement.

#### Risk Management
- **Awareness of copyright risk**: Understanding the copyright issues of AI-generated code.
- **Confirmation of license terms**: Compliance with the license terms of the AI tool being used.
- **Appropriateness of commercial use**: Confirmation of the possibility of use in commercial products.

## Team Composition and Skill Requirements

### Necessary Roles and Skills

#### Design Lead
**Required Level**: A reasonably experienced person should be in charge of the design.

Required skills:
- **API Design**: Experience designing RESTful APIs or GraphQL.
- **Database Design**: Ability to design appropriate schemas.
- **Architectural Design**: Experience designing the overall structure of a system.
- **AI-compatible Design**: The ability to create a structure that is easy for AI to handle.

#### Development Members
**Basic Requirements**: Basic programming knowledge and adaptability to AI utilization.

- **Understanding of TDD**: Basic concepts of Test-Driven Development.
- **Prompt Skills**: The ability to interact effectively with AI (can be learned).
- **Code Review Ability**: Appropriate evaluation of AI-generated code.
- **Willingness to learn continuously**: Adaptability to new methods.

### Dealing with the Prompt Skill Gap

#### Realistic Problem Recognition
**"The difference between those who can imagine the AI's response and those who cannot."**

Main differences:
- The difference in familiarity due to experience interacting with AI.
- The degree to which one understands the characteristics and quirks of the AI.
- The skill to predict the effect of a prompt in advance.
- The accumulation of trial-and-error experience.

#### Countermeasure Approach
- **Continuous practice**: A realistic recognition that "you just have to use it."
- **Phased learning**: Gaining experience by starting with small tasks.
- **Knowledge sharing**: Sharing success stories and best practices.
- **Pair programming**: Promoting learning through pairs of experienced and novice developers.

## Judging Cost-effectiveness

### Criteria for Evaluating Efficiency

#### Improvement in Development Speed
Effects based on practical data:
- **Implementation speed**: Achieved an improvement of 20 to 48 times compared to traditional methods.
- **Development cycle**: Tasks that took 1-2 days were shortened to about 1 hour.
- **Ease of trial and error**: The ability to try many approaches due to high-speed iteration.

#### New Cost Factors
- **Quality control cost**: The burden of confirming and reviewing AI-generated code.
- **Learning cost**: The time it takes for team members to learn AITDD.
- **Tool usage cost**: API fees for Claude Code, etc.

### Judging the Return on Investment

#### Basic Policy
- **Standard**: No problem as long as it is overwhelmingly faster than manual work.
- **Effect**: Significant reduction in developer time (shortened to 1/4 to 1/8).
- **Overall evaluation**: The balance between implementation efficiency and quality control cost.

#### Practical Introduction Judgment
```
Introduction consideration checklist:
□ Is there sufficient project duration (considering learning costs)?
□ Does the team have an understanding of AI utilization?
□ Does it conform to the organization's AI usage policy?
□ Is the required quality level within an appropriate range?
□ Are security risks manageable?
```

## Guidelines for Technology Stack Selection

### Technologies Suitable for AI Support

#### Recommended Technology Stack
- **Modern frameworks**: React, Vue.js, Next.js, etc.
- **Type-safe languages**: TypeScript, Rust, Go, etc.
- **Standard architectures**: RESTful API, MVC, microservices
- **Testable design**: Dependency injection, a structure that allows for unit testing

#### Technologies to Avoid
- **Complex legacy technologies**: Old technologies with insufficient documentation.
- **Non-standard architectures**: Unique designs that are difficult for AI to understand.
- **Structures that are difficult to test**: Designs not suitable for TDD.

### Phased Technology Introduction

#### Introduction Phases
1.  **Pilot project**: Trial with a small-scale new feature.
2.  **Partial application**: Apply to some features of an existing project.
3.  **Full-scale deployment**: Practice AITDD throughout the team.

#### Technology Migration Strategy
- **Parallel with existing technologies**: Reduce risk with a phased migration.
- **Knowledge succession**: Utilize the knowledge of traditional methods in AITDD.
- **Continuous improvement**: Optimize the method through practice.

---

Please use these technology selection guidelines to practice AITDD in a way that is appropriate for the characteristics of your organization and project.
