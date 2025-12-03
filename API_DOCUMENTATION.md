# API Documentation

## Authentication Endpoints

### Register New User
```http
POST /api/auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "SecurePassword123",
  "firstName": "John",
  "lastName": "Doe"
}
```

**Response:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "userId": 1,
  "email": "user@example.com",
  "firstName": "John",
  "lastName": "Doe"
}
```

### Login
```http
POST /api/auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "SecurePassword123"
}
```

**Response:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "userId": 1,
  "email": "user@example.com",
  "firstName": "John",
  "lastName": "Doe"
}
```

## Task Endpoints

All task endpoints require authentication. Include the JWT token in the Authorization header:
```
Authorization: Bearer YOUR_JWT_TOKEN
```

### Get All Tasks
```http
GET /api/tasks
Authorization: Bearer YOUR_JWT_TOKEN
```

**Response:**
```json
[
  {
    "id": 1,
    "title": "Complete project documentation",
    "description": "Write comprehensive API documentation",
    "isCompleted": false,
    "createdAt": "2025-12-03T10:00:00Z",
    "dueDate": "2025-12-10T00:00:00Z",
    "userId": 1
  }
]
```

### Get Single Task
```http
GET /api/tasks/1
Authorization: Bearer YOUR_JWT_TOKEN
```

**Response:**
```json
{
  "id": 1,
  "title": "Complete project documentation",
  "description": "Write comprehensive API documentation",
  "isCompleted": false,
  "createdAt": "2025-12-03T10:00:00Z",
  "dueDate": "2025-12-10T00:00:00Z",
  "userId": 1
}
```

### Create Task
```http
POST /api/tasks
Authorization: Bearer YOUR_JWT_TOKEN
Content-Type: application/json

{
  "title": "New Task",
  "description": "Task description",
  "dueDate": "2025-12-15T00:00:00Z"
}
```

**Response:**
```json
{
  "id": 2,
  "title": "New Task",
  "description": "Task description",
  "isCompleted": false,
  "createdAt": "2025-12-03T10:30:00Z",
  "dueDate": "2025-12-15T00:00:00Z",
  "userId": 1
}
```

### Update Task
```http
PUT /api/tasks/1
Authorization: Bearer YOUR_JWT_TOKEN
Content-Type: application/json

{
  "title": "Updated Task",
  "description": "Updated description",
  "isCompleted": true,
  "dueDate": "2025-12-15T00:00:00Z"
}
```

**Response:**
```json
{
  "id": 1,
  "title": "Updated Task",
  "description": "Updated description",
  "isCompleted": true,
  "createdAt": "2025-12-03T10:00:00Z",
  "dueDate": "2025-12-15T00:00:00Z",
  "userId": 1
}
```

### Delete Task
```http
DELETE /api/tasks/1
Authorization: Bearer YOUR_JWT_TOKEN
```

**Response:**
```
204 No Content
```

## Error Responses

### 400 Bad Request
```json
{
  "message": "Validation error message"
}
```

### 401 Unauthorized
```json
{
  "message": "Invalid email or password"
}
```

### 404 Not Found
```json
{
  "message": "Task not found"
}
```

## Testing with cURL

### Register
```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "Test123456",
    "firstName": "Test",
    "lastName": "User"
  }'
```

### Login
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "Test123456"
  }'
```

### Get Tasks
```bash
curl -X GET http://localhost:5000/api/tasks \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

### Create Task
```bash
curl -X POST http://localhost:5000/api/tasks \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "My First Task",
    "description": "This is a test task",
    "dueDate": "2025-12-15T00:00:00Z"
  }'
```

## Rate Limiting

Currently, there are no rate limits implemented. This should be added for production use.

## CORS Configuration

The API allows requests from:
- `http://localhost:5173` (Frontend development server)

For production, update the CORS policy in `Program.cs` to match your frontend domain.
