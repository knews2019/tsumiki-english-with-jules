# 6.1 Balance Strategy to Avoid Over-reliance

To effectively utilize AITDD, it is important to maintain the developer's own creativity and judgment while making the most of AI's power. This section explains the appropriate division of roles between AI and humans and practical strategies to avoid over-reliance.

## Problems Caused by Over-reliance on AI

### Major Challenges

One of the biggest challenges in AITDD is that **relying too much on AI makes it difficult for the developer's own intentions and thoughts to be incorporated**. This problem is not limited to Claude Sonnet 4 but occurs with other AI tools as well, and it has the following effects:

- **Design Judgment**: It becomes easy to be swayed by AI's suggestions, and independent judgment is restricted.
- **Creativity**: It becomes difficult for original ideas and solutions to emerge.
- **Learning Opportunities**: Opportunities to think for oneself decrease, which affects skill improvement.

### Lessons from Vibe Coding

In the development process of the AITDD method, it is common to go through an initial stage called "Vibe Coding." This is a coding method of **creating with AI based on gut feeling and momentum**, but it has been found to have the following limitations:

- A single implementation is very fast, but it reaches its **limit at the integration of about three features**.
- The AI ends up generating a **large amount of uninstructed code** on its own.
- **Completely different implementations** are likely to be born from the same request, lacking consistency.
- As a result, it ends up in a situation where **manual work is faster**.

## Establishing an Appropriate Division of Roles

### Areas That Humans Should Handle

In AITDD, the area where humans should exert the most creativity is in **requirements definition and design**:

#### Most Important Area: Requirements Definition and Design
- **Imaging "what you want to do"** is the point where creativity is most exerted.
- Determining the direction of problem-solving.
- The source of value creation.
- The process of converting business requirements into system requirements.

#### Human's Area of Expertise
- **Goal Setting**: Defining the project's objectives and success indicators.
- **Value Judgment**: Determining the priority of features and quality requirements.
- **Creative Ideas**: Proposing new approaches and solutions.
- **Overall System Consistency**: Ensuring consistency at the architectural level.

### Areas Where AI Excels

On the other hand, AI can effectively support humans in the following areas:

- **Implementation Support**: Code generation and detailed implementation.
- **Quality Improvement**: Test case generation and bug detection.
- **Efficiency Improvement**: Automation of routine tasks.
- **Document Generation**: Creation of comments and design documents.

## Practical Balance Strategy

### 1. Visualizing the AI's Inferred Content

By making the AI's judgment process transparent, it becomes possible to supervise and correct it appropriately:

#### Current Efforts
- Marking the parts inferred/complemented by the AI through工夫 in prompt design.
- Introduction of a mechanism to mark the content inferred by the AI.
- Visualization of uncertain judgments.

#### Future Development Direction
- Construction of a system for complete visualization of AI's inferred content.
- Mitigation of the black box problem.
- Realization of more precise supervision by humans.

### 2. Clarifying Checkpoints

Clarify what humans should check to achieve efficient reviews:

#### Setting Checkpoints
- **Objective**: To grasp what humans should check.
- **Effect**: To achieve efficient reviews.
- **Quality**: To prevent overlooking important judgments.

#### Specific Checklist Items
- Has the AI implemented features that were not instructed?
- Does the implementation method conform to the requirements?
- Is consistency with the existing system maintained?
- Is future extensibility considered?

### 3. Phased Improvement Approach

It is important to improve collaboration with AI in phases:

#### Improvement Steps
1.  **Present**: Recognize the issues and consider solutions.
2.  **Next Phase**: Introduce a marking mechanism in prompt design.
3.  **Future**: A system for complete visualization of AI's inferred content.

#### Continuous Adjustment
- Improving the method through practice.
- Sharing best practices within the team.
- Responding to new AI tools.

## Implementing the Balance Strategy

### Division of Roles in the TDD Process

In the Red-Green-Refactor-Validation cycle, we will clarify the roles of humans and AI at each step:

#### Red Step (Human-led)
- Definition of test requirements and decision on design policy.
- Design of test case structure and expected values.
- Request the AI to implement the test code.

#### Green Step (AI-led, Human-supervised)
- Generation of implementation code by the AI.
- Confirmation of the implementation policy by a human.
- Adjustment of the implementation content as needed.

#### Refactor Step (Collaborative)
- The refactoring policy is decided by a human.
- The specific implementation is handled by the AI.
- The quality standards are judged by a human.

#### Validation Step (Human-led)
- Setting of quality evaluation criteria.
- Interpretation of the AI's verification results.
- Final judgment on acceptance.

### Ingenuity in Prompt Design

Key points for prompt design to achieve an effective balance:

```markdown
# Example Prompt (Emphasizing Balance)
Please implement the code based on the following specifications.

## Implementation Requirements
- [Specific requirements]

## Important Constraints
- Match the existing code style.
- Do not implement additional features based on inference.

## Output Format
In addition to the implementation code, please specify the following:
- [Inference] The part inferred from the specifications.
- [Confirmation] Judgment points that require confirmation.
- [Alternative] If there are other implementation methods, please present them.
```

## Expected Effects

By implementing an appropriate balance strategy, the following effects can be expected:

### Maintaining and Improving Developer Skills
- Skill retention through appropriate role division between AI and humans.
- Securing opportunities for developers to exert creativity.
- Learning effect by improving the transparency of AI support.

### Improving the Efficiency of Quality Control
- Clarification of important judgment points.
- Realization of efficient reviews.
- Establishment of a continuous quality assurance process.

### Improving Long-term Development Capabilities
- Accumulation of the organization's ability to utilize AI.
- Establishment of a collaborative model between humans and AI.
- Construction of a sustainable development process.

## Summary

The balance strategy in AITDD is a key element for achieving both the efficiency of AI and the creativity of humans. To make the most of AI's power while avoiding over-reliance, a clear division of roles and continuous improvement are necessary. In the next section, we will explain in detail the specific points for humans to exert creativity within this balance.
