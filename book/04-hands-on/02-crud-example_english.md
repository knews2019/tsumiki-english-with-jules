# 4.2 CRUD Operation Implementation Example

## Learning Objectives

In this chapter, you will learn the following by implementing more practical CRUD (Create, Read, Update, Delete) operations:

- Utilizing AITDD for integrating multiple features
- Designing and implementing data management logic
- Experiencing something close to actual application development
- Experiencing the difference from Vibe Coding

## Project Overview: Simple Task Management System

### Feature to be Implemented

Create a simple memory-based task management system:

```typescript
interface Task {
  id: string;
  title: string;
  description: string;
  completed: boolean;
  createdAt: Date;
  updatedAt: Date;
}
```

**CRUD Operations**:
- **Create**: Create a new task
- **Read**: Get tasks (all, single, conditional search)
- **Update**: Update a task
- **Delete**: Delete a task

### Level of Technical Complexity

The following complexities are added compared to the calculation feature in the previous chapter:
- Data persistence (memory-based)
- Multiple entity operations
- Combination of validations
- Diversification of error handling

## Practical Hands-On

### Step 1: TODO Creation and Feature Decomposition

An important lesson from AITDD is that **integrating about three features is the practical limit**. Therefore, we will decompose the features into appropriate granularities.

```markdown
# TODO: Implement Task Management System CRUD

## Phase 1: Foundation Implementation
- [ ] Define the Task interface
- [ ] Basic structure of the TaskManager class
- [ ] Implement memory-based storage

## Phase 2: Basic CRUD (up to 3 features)
- [ ] Create: Create a new task
- [ ] Read: Get all tasks
- [ ] Read: Get a single task by ID

## Phase 3: Extended CRUD (remaining features)
- [ ] Update: Update a task
- [ ] Delete: Delete a task
- [ ] Read: Conditional search (completion status, etc.)

## Technical Requirements
- Use TypeScript
- Test with Jest
- Memory-based data management
- Appropriate error handling
```

**Key Points**:
- Control the complexity of integration by dividing into phases
- Each phase can be tested independently
- Allows for gradual feature addition

### Step 2: Phase 1 Implementation

#### Specification Creation

**Prompt for AI**:
```
Please create the specifications for the foundation of the task management system.

Requirements:
- Define the Task interface
- Design the TaskManager class
- Memory-based storage functionality
- Ensure type safety with TypeScript

Please refer to the following TODOs:
[Paste the TODOs for Phase 1]
```

**Example of Generated Specifications**:
```markdown
# Task Management System Foundation Specification

## Task Interface
```typescript
interface Task {
  id: string;          // Unique ID in UUID format
  title: string;       // Task title (1-100 characters)
  description: string; // Task description (0-500 characters)
  completed: boolean;  // Completion status
  createdAt: Date;     // Creation datetime
  updatedAt: Date;     // Update datetime
}
```

## TaskManager Class
- Memory-based task management
- Task persistence (array)
- Automatic ID generation
- Basic validation

## Error Handling
- If a task is not found: TaskNotFoundError
- Validation failure: ValidationError
- Invalid ID format: InvalidIdError
```

#### Test Case Creation

**AI Prompt**:
```
Please create test cases for the foundation part based on the following specifications:

[Paste the foundation specifications]

Test perspectives:
- Type checking of the interface
- Initialization of TaskManager
- Confirmation of memory storage operation
- Confirmation of error class definitions
```

#### Executing the Red-Green-Refactor-Validation Cycle

Request the AI to implement step-by-step:

1.  **Red**: Confirm test failure
2.  **Green**: Minimal implementation of the foundation class
3.  **Refactor**: Improve the design
4.  **Validation**: Verify the validity of the foundation

### Step 3: Phase 2 Implementation (Basic CRUD)

#### Points to Note During Integration

A key difference from Vibe Coding is the need for a **structured approach**:

**AITDD Method**:
```
1. Clear specification definition
2. Comprehensive test design
3. Phased implementation
4. Quality check
→ Easy integration, stable quality
```

**Vibe Coding Method (to be avoided)**:
```
1. Request implementation from AI on a whim
2. Tests are an afterthought
3. Discover problems during integration
4. Manual correction
→ Breaks down at the integration of 3 features
```

#### Implementing the Create Feature

**Specification**:
```markdown
## Task Creation Feature

### Method: createTask(taskData)
- Argument: { title: string, description: string }
- Return value: The created Task
- Validation:
  - title is required, 1-100 characters
  - description is 0-500 characters
- Automatic setting: id, createdAt, updatedAt, completed=false
```

**Example AI Prompt**:
```
Please create the test cases and implementation for the createTask method with the following specifications:

[Paste the specifications]

Requirements:
1. Comprehensive test cases (happy path, sad path, boundary values)
2. Implement with the Red-Green-Refactor-Validation cycle
3. Ensure consistency with existing foundation code
4. Utilize TypeScript's type safety
```

#### Implementing the Read Feature

Implement **get all** and **get single** at the same time:

**Specification**:
```markdown
## Task Retrieval Feature

### getAllTasks(): Task[]
- Returns all tasks in an array
- An empty array if there are none
- Sorted in descending order of creation datetime

### getTaskById(id: string): Task
- Searches for a task by ID
- If not found: TaskNotFoundError
- Invalid ID format: InvalidIdError
```

### Step 4: Phase 3 Implementation (Extended CRUD)

#### Update Feature

**Support for partial updates**:

```typescript
interface TaskUpdateData {
  title?: string;
  description?: string;
  completed?: boolean;
}

updateTask(id: string, updateData: TaskUpdateData): Task
```

#### Delete Feature

Implementation including consideration of **logical delete vs. physical delete**:

```typescript
deleteTask(id: string): boolean  // Physical delete
// or
softDeleteTask(id: string): Task  // Logical delete
```

#### Conditional Search Feature

**Filtering feature**:

```typescript
interface TaskFilter {
  completed?: boolean;
  titleContains?: string;
  createdAfter?: Date;
}

searchTasks(filter: TaskFilter): Task[]
```

### Step 5: Integration Testing and Final Review

#### Integration Scenario Testing

Testing assuming actual use cases:

```typescript
describe('Task Management Integration Scenario', () => {
  test('A general task management flow', async () => {
    const manager = new TaskManager();

    // 1. Create a task
    const task1 = manager.createTask({
      title: 'Project Planning',
      description: 'Requirements definition and design'
    });

    // 2. Get and confirm the task
    const allTasks = manager.getAllTasks();
    expect(allTasks).toHaveLength(1);

    // 3. Update the task
    const updatedTask = manager.updateTask(task1.id, {
      completed: true
    });
    expect(updatedTask.completed).toBe(true);

    // 4. Search feature
    const completedTasks = manager.searchTasks({
      completed: true
    });
    expect(completedTasks).toHaveLength(1);

    // 5. Delete the task
    const deleted = manager.deleteTask(task1.id);
    expect(deleted).toBe(true);
    expect(manager.getAllTasks()).toHaveLength(0);
  });
});
```

#### Performance Testing

**Checking operation with a large amount of data**:

```typescript
describe('Performance Test', () => {
  test('1000 task operations', () => {
    const manager = new TaskManager();

    // Create 1000 items
    const startTime = Date.now();
    for (let i = 0; i < 1000; i++) {
      manager.createTask({
        title: `Task ${i}`,
        description: `Description ${i}`
      });
    }
    const createTime = Date.now() - startTime;

    // Search performance
    const searchStart = Date.now();
    const results = manager.searchTasks({
      titleContains: 'Task 1'
    });
    const searchTime = Date.now() - searchStart;

    expect(createTime).toBeLessThan(1000); // within 1 second
    expect(searchTime).toBeLessThan(100);  // within 100ms
  });
});
```

## Troubleshooting

### Common Problems and Countermeasures

#### Problem 1: Inconsistency in AI-generated code

**Symptom**:
- Unintentionally modifies existing code
- Inconsistency in interfaces
- Differences in naming conventions

**Countermeasure**:
```
Example of an improved prompt:
"Please add only the new method according to the following interface, without changing any of the existing code:
[Explicitly state the existing interface]"
```

#### Problem 2: Insufficient test quality

**Symptom**:
- Lack of sad path tests
- Missing boundary value tests
- No integration tests

**Countermeasure**:
```
Review checklist:
- [ ] Covers all happy path, sad path, and boundary values
- [ ] Confirmation of error messages
- [ ] Testing with actual use cases
```

#### Problem 3: Complexity during integration

**Symptom**:
- Breaks down when integrating 3 or more features
- Difficult to debug
- Tests do not pass

**Countermeasure**:
```
Phased integration approach:
1. Implement one feature completely at a time
2. Test the combination of two features
3. Proceed cautiously when adding the third feature
4. Decompose the feature if a problem occurs
```

## Best Practices for AI Prompts

### Effective Prompt Design

**1. Clarifying the Context**:
```
Good Example:
"In the CRUD operations of the task management system, please implement the createTask method according to the following specifications.
Implement it by adding to the existing Task interface and TaskManager class,
and use memory-based storage.

[Existing code]
[Detailed specifications]
[Expected output format]"
```

**2. Specifying Constraints**:
```
Example constraints:
- "Do not change the existing code"
- "Utilize TypeScript's type safety to the maximum extent"
- "Implement error handling appropriately"
- "Implement with a test-first approach"
```

**3. Specifying the Expected Quality**:
```
Example quality requirements:
- "Please implement with production-level quality"
- "Emphasize readability and maintainability"
- "Implement with performance in mind"
- "Please include appropriate comments"
```

### Prompt Template

A prompt template specialized for CRUD operations:

```
### CRUD Implementation Prompt Template

**Basic Information**:
- Feature: [Create/Read/Update/Delete] operation
- Target Entity: [Entity Name]
- Implementation Language: TypeScript
- Test Framework: Jest

**Existing Context**:
[Existing interface/class definitions]

**Implementation Requirements**:
[Specific specifications]

**Constraints**:
- Changing existing code is prohibited
- Maximize the use of type safety
- Error handling is mandatory

**Output Requirements**:
1. Test cases (happy path, sad path, boundary values)
2. Implementation code
3. Usage examples
4. Points to note/limitations
```

## Quality Control Points

### Code Review Checklist

**Functional Quality**:
- [ ] Meets all specification requirements
- [ ] Error handling is appropriate
- [ ] Behavior at boundary values is correct
- [ ] Performance is within an acceptable range

**Technical Quality**:
- [ ] TypeScript type safety is ensured
- [ ] Follows naming conventions
- [ ] Appropriate level of abstraction
- [ ] The DRY principle is followed

**Test Quality**:
- [ ] Sufficient test coverage
- [ ] Tests are easy to understand
- [ ] Use of mocks is appropriate
- [ ] Integration tests are comprehensive

**Maintainability**:
- [ ] The code is easy to read
- [ ] A structure that is easy to change
- [ ] Documentation is appropriate
- [ ] A design that considers extensibility

## Learning Effects from Practice

### Strengths of AITDD (What you can experience)

**Development Speed**:
- Traditional CRUD implementation: 1-2 days
- Using AITDD: less than 1 hour
- Experience an efficiency improvement of **20 to 48 times**

**Quality Stability**:
- Quality assurance through a test-first approach
- Optimization at the refactoring stage
- Overall quality check in the Validation step

**Learning Effect**:
- Collaborative development skills with AI
- Effective prompt design ability
- Improved sensitivity to quality control

### Clear Difference from Vibe Coding

**Ease of Integration**:
- Vibe Coding: Breaks down at the integration of 3 features
- AITDD: Stable with phased integration

**Debugging Efficiency**:
- Vibe Coding: Repetition of the same problem
- AITDD: Systematic problem solving

**Long-term Maintainability**:
- Vibe Coding: Requires later rework
- AITDD: Allows for continuous development

## Preparation for the Next Chapter

Through this CRUD implementation experience, you will acquire the following skills:

1.  **Managing the integration of multiple features**
2.  **Phased feature development**
3.  **Understanding the importance of quality control**
4.  **Practical ability in AI prompt design**

In the next chapter, we will use these skills to tackle a more practical development scenario: API development. You will learn how AITDD can handle new complexities such as external dependencies and asynchronous processing.

## Summary

Through the implementation of CRUD operations, we learned the following:

**The Importance of Process**:
- The value of a structured approach
- The effect of phased feature addition
- Automation of quality control

**Tips for Utilizing AI**:
- Providing clear context
- Specifying appropriate constraints
- Continuous improvement of prompts

**Practical Skills**:
- Techniques for integrating multiple features
- Test-driven design thinking
- Reviews and quality control

Having this foundation will enable you to effectively utilize AITDD in more complex real-world development projects.
