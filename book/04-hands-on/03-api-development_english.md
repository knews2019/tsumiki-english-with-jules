# 4.3 Practical API Development

## Learning Objectives

In this chapter, you will learn how to apply AITDD to actual web application development by developing a RESTful API:

- Utilizing AITDD in implementations that include external dependencies
- Implementing asynchronous processing and error handling
- Designing HTTP status codes and responses
- Automatically generating API documentation
- Experiencing development close to a real production environment

## Project Overview: Task Management API

Based on the task management system developed in the previous chapter, we will build a RESTful API using Express.js.

### API Specification Overview

```http
GET    /api/tasks       # Get all tasks
GET    /api/tasks/:id   # Get a specific task
POST   /api/tasks       # Create a new task
PUT    /api/tasks/:id   # Update a task
DELETE /api/tasks/:id   # Delete a task
```

### Technology Stack

- **Web Framework**: Express.js
- **Language**: TypeScript
- **Testing**: Jest + Supertest
- **Validation**: express-validator
- **Documentation**: OpenAPI (Swagger)

## New Technical Complexities

In API development, the following elements are added in addition to the CRUD operations from the previous chapter:

**HTTP-related**:
- Request/response processing
- Status code management
- Header processing
- Routing design

**Asynchronous Processing**:
- Promise/async-await
- Error handling
- Timeout processing

**Validation**:
- Request data validation
- Unifying response formats
- Standardizing error responses

## Practical Hands-On

### Step 1: TODO Creation and API Design

In API development with AITDD, the **integration limit of about three features** applies similarly. Therefore, we will divide the endpoints appropriately.

```markdown
# TODO: Implement Task Management API

## Phase 1: Foundation Building
- [ ] Express.js project setup
- [ ] TypeScript configuration
- [ ] Basic middleware configuration
- [ ] Error handling middleware

## Phase 2: Basic API (3 endpoints)
- [ ] GET /api/tasks - Get all tasks
- [ ] GET /api/tasks/:id - Get a single task
- [ ] POST /api/tasks - Create a task

## Phase 3: Extended API (remaining endpoints)
- [ ] PUT /api/tasks/:id - Update a task
- [ ] DELETE /api/tasks/:id - Delete a task
- [ ] GET /api/tasks?search=xxx - Conditional search

## Phase 4: Quality Improvement
- [ ] Generate OpenAPI specification
- [ ] Strengthen input validation
- [ ] Add security headers
- [ ] Optimize performance
```

### Step 2: Phase 1 - Foundation Building

#### Specification Creation

**Prompt for AI**:
```
Please create the specifications for the foundation setup of an API project using Express.js and TypeScript.

Requirements:
- Express.js setup in a TypeScript environment
- Basic middleware (CORS, JSON parsing, etc.)
- Structured error handling
- Separation of development and production environment settings
- Test environment setup

Please refer to the following TODOs:
[Paste the TODOs for Phase 1]
```

**Example of Generated Specifications**:
````markdown
# Task Management API Foundation Specification

## Project Structure
```
src/
├── app.ts              # Express application configuration
├── server.ts           # Server startup entry point
├── routes/             # Route definitions
├── controllers/        # Business logic
├── middleware/         # Custom middleware
├── types/              # TypeScript type definitions
└── tests/              # Test files
```

## Express Configuration
- CORS support
- JSON/URL-encoded parsing
- Request logging
- Security headers
- Error handling middleware

## Error Handling Standardization
```typescript
interface APIError {
  message: string;
  code: string;
  statusCode: number;
  details?: any;
}
```

## Response Format Unification
```typescript
interface APIResponse<T> {
  success: boolean;
  data?: T;
  error?: APIError;
  meta?: {
    timestamp: string;
    requestId: string;
  };
}
```
```

#### Test Case Creation and Red-Green-Refactor-Validation

**Testing the API Foundation**:
```typescript
describe('API Foundation Test', () => {
  test('Server startup confirmation', async () => {
    const response = await request(app).get('/health');
    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
  });

  test('CORS settings confirmation', async () => {
    const response = await request(app)
      .options('/api/tasks')
      .set('Origin', 'http://localhost:3000')
      .set('Access-Control-Request-Method', 'GET');

    expect(response.headers['access-control-allow-origin']).toBeDefined();
  });

  test('JSON parsing confirmation', async () => {
    const response = await request(app)
      .post('/api/test')
      .send({ test: 'data' })
      .set('Content-Type', 'application/json');

    expect(response.status).not.toBe(400); // Not a JSON parsing error
  });

  test('Error handling confirmation', async () => {
    const response = await request(app).get('/api/nonexistent');
    expect(response.status).toBe(404);
    expect(response.body.success).toBe(false);
    expect(response.body.error).toBeDefined();
  });
});
````

### Step 3: Phase 2 - Basic API Implementation

#### Implementing GET /api/tasks

**Specification**:
```markdown
## Get All Tasks API

### Endpoint
GET /api/tasks

### Response (on success)
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "title": "Task Title",
      "description": "Task Description",
      "completed": false,
      "createdAt": "2025-06-21T10:00:00Z",
      "updatedAt": "2025-06-21T10:00:00Z"
    }
  ],
  "meta": {
    "timestamp": "2025-06-21T10:00:00Z",
    "requestId": "req-123"
  }
}
```

### Status Codes
- 200: Successfully retrieved (including an empty array)
- 500: Server error


**Example AI Prompt**:
```
Please implement the GET /api/tasks endpoint based on the following specifications:

[Paste the specifications]

Requirements:
1. Use an Express.js router
2. Utilize the TaskManager class created in the previous chapter
3. Implement error handling appropriately
4. Ensure TypeScript type safety
5. Create integration tests using Supertest

Existing Code:
[Paste the TaskManager class code]
[Paste the API foundation code]
```

**Expected Implementation**:
```typescript
// routes/tasks.ts
import { Router } from 'express';
import { TaskController } from '../controllers/TaskController';

const router = Router();
const taskController = new TaskController();

router.get('/', taskController.getAllTasks);

export default router;

// controllers/TaskController.ts
import { Request, Response, NextFunction } from 'express';
import { TaskManager } from '../services/TaskManager';
import { APIResponse } from '../types/api';

export class TaskController {
  private taskManager = new TaskManager();

  getAllTasks = async (req: Request, res: Response, next: NextFunction) => {
    try {
      const tasks = this.taskManager.getAllTasks();

      const response: APIResponse<typeof tasks> = {
        success: true,
        data: tasks,
        meta: {
          timestamp: new Date().toISOString(),
          requestId: req.headers['x-request-id'] as string || 'unknown'
        }
      };

      res.status(200).json(response);
    } catch (error) {
      next(error);
    }
  };
}
```

#### Implementing GET /api/tasks/:id

**Additional Specification**:
```markdown
## Get Single Task API

### Endpoint
GET /api/tasks/:id

### Parameters
- id: Task ID (UUID format)

### Status Codes
- 200: Successfully retrieved
- 400: Invalid ID format
- 404: Task not found
- 500: Server error
```

#### Implementing POST /api/tasks

**Additional Specification**:
````markdown
## Create Task API

### Endpoint
POST /api/tasks

### Request Body
```json
{
  "title": "Task Title",
  "description": "Task Description"
}
```

### Validation
- title: required, 1-100 characters
- description: optional, 0-500 characters

### Status Codes
- 201: Successfully created
- 400: Validation error
- 500: Server error
````

### Step 4: Phase 3 - Extended API Implementation

#### Strengthening Input Validation

**Utilizing express-validator**:

```typescript
// middleware/validation.ts
import { body, param, validationResult } from 'express-validator';
import { Request, Response, NextFunction } from 'express';

export const createTaskValidation = [
  body('title')
    .notEmpty()
    .withMessage('Title is required')
    .isLength({ min: 1, max: 100 })
    .withMessage('Title must be between 1 and 100 characters'),

  body('description')
    .optional()
    .isLength({ max: 500 })
    .withMessage('Description must be 500 characters or less'),
];

export const taskIdValidation = [
  param('id')
    .isUUID()
    .withMessage('Please specify a valid UUID format ID'),
];

export const handleValidationErrors = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({
      success: false,
      error: {
        message: 'Validation error',
        code: 'VALIDATION_ERROR',
        statusCode: 400,
        details: errors.array()
      }
    });
  }
  next();
};
```

#### Implementing PUT /api/tasks/:id

**Support for partial updates**:
```typescript
export const updateTaskValidation = [
  ...taskIdValidation,
  body('title')
    .optional()
    .isLength({ min: 1, max: 100 })
    .withMessage('Title must be between 1 and 100 characters'),

  body('description')
    .optional()
    .isLength({ max: 500 })
    .withMessage('Description must be 500 characters or less'),

  body('completed')
    .optional()
    .isBoolean()
    .withMessage('completed must be a boolean value'),
];
```

#### Implementing DELETE /api/tasks/:id

**Considering soft delete**:
```typescript
deleteTask = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const deleted = this.taskManager.deleteTask(id);

    if (!deleted) {
      return res.status(404).json({
        success: false,
        error: {
          message: 'Task not found',
          code: 'TASK_NOT_FOUND',
          statusCode: 404
        }
      });
    }

    res.status(204).send(); // No Content
  } catch (error) {
    next(error);
  }
};
```

### Step 5: Phase 4 - Quality Improvement

#### Generating the OpenAPI Specification

**Example AI Prompt**:
```
Please generate an OpenAPI 3.0 specification from the following API endpoints:

[List of implemented endpoints]
[Definition of response formats]
[Definition of error responses]

Requirements:
1. A format that can be displayed with Swagger UI
2. Detailed documentation for all endpoints
3. Include examples for requests/responses
4. Include descriptions for error codes
```

**Example of Generated OpenAPI Specification**:
```yaml
openapi: 3.0.0
info:
  title: Task Management API
  version: 1.0.0
  description: A RESTful API for a simple task management system

paths:
  /api/tasks:
    get:
      summary: Get all tasks
      responses:
        '200':
          description: Success
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/TaskListResponse'

    post:
      summary: Create a task
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateTaskRequest'
      responses:
        '201':
          description: Successfully created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/TaskResponse'
        '400':
          description: Validation error
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

components:
  schemas:
    Task:
      type: object
      properties:
        id:
          type: string
          format: uuid
        title:
          type: string
          minLength: 1
          maxLength: 100
        description:
          type: string
          maxLength: 500
        completed:
          type: boolean
        createdAt:
          type: string
          format: date-time
        updatedAt:
          type: string
          format: date-time
```

## How to Deal with Complex Problems

### Deciding When to Switch to Manual Implementation

In API development, consider manual implementation in the following cases:

**When you can't imagine the implementation method**:
- "Complex authentication logic for custom middleware"
- "Integration processing with WebSockets"
- "Complex database optimization"

**When performance tuning is required**:
- "Optimizing the processing of a large number of requests"
- "Optimizing memory usage"
- "Reducing response time"

### Utilizing AI During Manual Implementation

Instead of fully manual, utilize AI in the following ways:
```typescript
// Request the AI for parts where you can imagine the implementation
const generateResponseHelper = (data: any, meta: any) => {
  // This part can be generated by AI
  return {
    success: true,
    data,
    meta: {
      timestamp: new Date().toISOString(),
      ...meta
    }
  };
};

// Manually implement complex logic
const complexAuthMiddleware = (req, res, next) => {
  // Manually implement complex authentication logic
  // However, utilize AI for partial completion
};
```

## API Development-Specific Test Strategies

### Integration Test Patterns

**End-to-end Test**:
```typescript
describe('API Integration Test', () => {
  test('Task management flow', async () => {
    // 1. Create a task
    const createResponse = await request(app)
      .post('/api/tasks')
      .send({
        title: 'Test Task',
        description: 'A task for testing'
      });

    expect(createResponse.status).toBe(201);
    const taskId = createResponse.body.data.id;

    // 2. Confirm task retrieval
    const getResponse = await request(app)
      .get(`/api/tasks/${taskId}`);

    expect(getResponse.status).toBe(200);
    expect(getResponse.body.data.title).toBe('Test Task');

    // 3. Update the task
    const updateResponse = await request(app)
      .put(`/api/tasks/${taskId}`)
      .send({
        completed: true
      });

    expect(updateResponse.status).toBe(200);
    expect(updateResponse.body.data.completed).toBe(true);

    // 4. Delete the task
    const deleteResponse = await request(app)
      .delete(`/api/tasks/${taskId}`);

    expect(deleteResponse.status).toBe(204);

    // 5. Confirm deletion
    const getAfterDeleteResponse = await request(app)
      .get(`/api/tasks/${taskId}`);

    expect(getAfterDeleteResponse.status).toBe(404);
  });
});
```

### Performance Testing

**Load Test**:
```typescript
describe('Performance Test', () => {
  test('Concurrent request processing', async () => {
    const requests = Array.from({ length: 100 }, (_, i) =>
      request(app)
        .post('/api/tasks')
        .send({
          title: `Concurrent Task ${i}`,
          description: 'Concurrent processing test'
        })
    );

    const startTime = Date.now();
    const responses = await Promise.all(requests);
    const endTime = Date.now();

    responses.forEach(response => {
      expect(response.status).toBe(201);
    });

    expect(endTime - startTime).toBeLessThan(5000); // within 5 seconds
  });
});
```

## Best Practices for Error Handling

### Comprehensive Error Handling

```typescript
// middleware/errorHandler.ts
export const errorHandler = (
  error: any,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  // Log output
  console.error('API Error:', {
    error: error.message,
    stack: error.stack,
    method: req.method,
    url: req.url,
    body: req.body,
    timestamp: new Date().toISOString()
  });

  // Processing for each error type
  if (error.name === 'TaskNotFoundError') {
    return res.status(404).json({
      success: false,
      error: {
        message: 'Task not found',
        code: 'TASK_NOT_FOUND',
        statusCode: 404
      }
    });
  }

  if (error.name === 'ValidationError') {
    return res.status(400).json({
      success: false,
      error: {
        message: 'Validation error',
        code: 'VALIDATION_ERROR',
        statusCode: 400,
        details: error.details
      }
    });
  }

  // Unknown error
  res.status(500).json({
    success: false,
    error: {
      message: 'An internal server error occurred',
      code: 'INTERNAL_SERVER_ERROR',
      statusCode: 500
    }
  });
};
```

## Learning Effects from Practice

### The Effect of AITDD in API Development

**Realizing Development Speed**:
- Traditional API development: several days to a week
- Using AITDD: a few hours
- Realize a **significant efficiency improvement**

**Quality Stability**:
- Quality assurance through comprehensive testing
- Standardization of error handling
- Automatic generation of API documentation

**Acquisition of Practical Skills**:
- Effective AI utilization in web development
- Handling complex integration processing
- Implementation of production quality

### Difference from Traditional Development

**Design Phase**:
- Traditional: Spend time on detailed design
- AITDD: Design in phases in collaboration with AI

**Implementation Phase**:
- Traditional: Manual detailed implementation
- AITDD: Quality control of AI-generated code

**Test Phase**:
- Traditional: Creating tests after implementation
- AITDD: Test-first approach

## Preparation for the Next Chapter

Through this API development experience, you will acquire the following:

1.  **AI utilization techniques in web development**
2.  **Methods for managing complex integration processing**
3.  **Implementation techniques for production quality**
4.  **Error handling and debugging techniques**

In the next chapter, we will learn specific countermeasures for errors and troubles that occur during this implementation process.

## Summary

Through API development, we have learned the following:

**Technical Growth**:
- Practice of RESTful API design
- Asynchronous processing and error handling
- Type-safe implementation with TypeScript
- Comprehensive testing strategies

**AITDD Utilization Techniques**:
- AI collaboration in complex implementations
- Management of phased feature addition
- Automation of quality control
- Utilization of documentation generation

**Practical Development Ability**:
- Implementation of production quality
- Design that considers performance
- Implementation of security measures
- Design that considers operation

With these experiences, the foundation is in place to effectively utilize AITDD in actual product development projects.
