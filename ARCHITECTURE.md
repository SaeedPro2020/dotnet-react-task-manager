# Architecture Overview

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         Client Browser                          │
│                                                                 │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │              React Frontend (Port 5173)                   │ │
│  │                                                           │ │
│  │  ├── Pages (Login, Register, Dashboard)                  │ │
│  │  ├── Redux Store (Auth & Tasks)                          │ │
│  │  ├── API Client (Axios + JWT Interceptor)                │ │
│  │  └── Components (TaskModal, ProtectedRoute)              │ │
│  └───────────────────────────────────────────────────────────┘ │
│                            │                                    │
│                            │ HTTP/HTTPS                         │
│                            ▼                                    │
└─────────────────────────────────────────────────────────────────┘
                             │
                             │ REST API Calls
                             │ Authorization: Bearer <token>
                             │
┌─────────────────────────────▼───────────────────────────────────┐
│                  ASP.NET Core API (Port 5000)                   │
│                                                                 │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │                    API Layer                              │ │
│  │  ├── AuthController (/api/auth/*)                        │ │
│  │  │   ├── POST /register                                  │ │
│  │  │   └── POST /login                                     │ │
│  │  │                                                        │ │
│  │  └── TasksController (/api/tasks/*)  [Authorize]        │ │
│  │      ├── GET    /                                        │ │
│  │      ├── GET    /{id}                                    │ │
│  │      ├── POST   /                                        │ │
│  │      ├── PUT    /{id}                                    │ │
│  │      └── DELETE /{id}                                    │ │
│  └───────────────────────────────────────────────────────────┘ │
│                            │                                    │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │                  Service Layer                            │ │
│  │  ├── AuthService                                          │ │
│  │  │   ├── RegisterAsync()                                 │ │
│  │  │   ├── LoginAsync()                                    │ │
│  │  │   └── GenerateJwtToken()                              │ │
│  │  │                                                        │ │
│  │  └── TaskService                                          │ │
│  │      ├── GetUserTasksAsync()                             │ │
│  │      ├── CreateTaskAsync()                               │ │
│  │      ├── UpdateTaskAsync()                               │ │
│  │      └── DeleteTaskAsync()                               │ │
│  └───────────────────────────────────────────────────────────┘ │
│                            │                                    │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │               Infrastructure Layer                         │ │
│  │  └── AppDbContext (Entity Framework Core)                │ │
│  │      ├── DbSet<User>                                      │ │
│  │      └── DbSet<TaskItem>                                  │ │
│  └───────────────────────────────────────────────────────────┘ │
│                            │                                    │
└─────────────────────────────┼───────────────────────────────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │  SQLite Database │
                    │  taskmanager.db  │
                    │                  │
                    │  Tables:         │
                    │  - Users         │
                    │  - Tasks         │
                    └─────────────────┘
```

## Data Flow

### Authentication Flow

```
┌──────┐     1. Register/Login      ┌─────────────┐
│Client├──────────────────────────>│AuthController│
└──────┘                             └──────┬──────┘
   ▲                                        │
   │                                        │ 2. Validate
   │                                        ▼
   │                                  ┌────────────┐
   │                                  │AuthService │
   │                                  └──────┬─────┘
   │                                         │
   │                                         │ 3. Hash/Verify Password
   │                                         │    (BCrypt)
   │                                         ▼
   │                                  ┌─────────────┐
   │                                  │ AppDbContext│
   │                                  └──────┬──────┘
   │                                         │
   │                                         │ 4. Query/Save User
   │                                         ▼
   │                                   ┌──────────┐
   │                                   │  Database│
   │                                   └──────────┘
   │
   │ 5. Return JWT Token
   └──────────────────────────────────────┘
```

### Task Operations Flow

```
┌──────┐  1. Request + JWT Token   ┌──────────────┐
│Client├──────────────────────────>│TasksController│
└──────┘                            └───────┬──────┘
   ▲                                        │
   │                                        │ 2. Validate JWT
   │                                        │    Extract UserId
   │                                        ▼
   │                                  ┌───────────┐
   │                                  │TaskService│
   │                                  └─────┬─────┘
   │                                        │
   │                                        │ 3. Business Logic
   │                                        │    Filter by UserId
   │                                        ▼
   │                                  ┌─────────────┐
   │                                  │AppDbContext │
   │                                  └──────┬──────┘
   │                                         │
   │                                         │ 4. CRUD Operations
   │                                         ▼
   │                                   ┌──────────┐
   │                                   │ Database │
   │                                   └──────────┘
   │
   │ 5. Return Task Data
   └──────────────────────────────────────┘
```

## Technology Stack Layers

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                   │
│  React 18 + TypeScript + Redux Toolkit + React Router  │
└─────────────────────────────────────────────────────────┘
                           │
                           │ HTTPS/HTTP
                           ▼
┌─────────────────────────────────────────────────────────┐
│                     API Layer                           │
│     ASP.NET Core 8 Web API + JWT Authentication        │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                   Business Logic Layer                  │
│          Services + DTOs + Validation                   │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                   Data Access Layer                     │
│        Entity Framework Core + Repository Pattern       │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                      Data Layer                         │
│                    SQLite Database                      │
└─────────────────────────────────────────────────────────┘
```

## Deployment Architecture

```
┌─────────────────────────────────────────────────────────┐
│                     Docker Host                         │
│                                                         │
│  ┌──────────────────────────────────────────────────┐  │
│  │          taskmanager-network (bridge)            │  │
│  │                                                  │  │
│  │  ┌────────────────────┐  ┌──────────────────┐  │  │
│  │  │  Frontend Container│  │ Backend Container│  │  │
│  │  │                    │  │                  │  │  │
│  │  │  Nginx + React App │  │ .NET 8 API       │  │  │
│  │  │  Port: 5173        │  │ Port: 5000       │  │  │
│  │  └────────────────────┘  └────────┬─────────┘  │  │
│  │                                    │            │  │
│  └────────────────────────────────────┼────────────┘  │
│                                       │               │
│                                       ▼               │
│                              ┌──────────────────┐    │
│                              │  Volume          │    │
│                              │  backend-data    │    │
│                              │  (SQLite DB)     │    │
│                              └──────────────────┘    │
└─────────────────────────────────────────────────────────┘
        │                           │
        │ Port 5173                 │ Port 5000
        ▼                           ▼
   ┌─────────┐               ┌──────────┐
   │ Browser │               │API Client│
   └─────────┘               └──────────┘
```

## Security Architecture

```
┌──────────────────────────────────────────────────────────┐
│                     Security Layers                      │
│                                                          │
│  1. Frontend Layer                                       │
│     ├── ProtectedRoute Component                         │
│     ├── JWT Token in localStorage                        │
│     └── Automatic token injection in API calls           │
│                                                          │
│  2. Network Layer                                        │
│     ├── CORS Configuration                               │
│     └── HTTPS (in production)                            │
│                                                          │
│  3. API Layer                                            │
│     ├── JWT Validation Middleware                        │
│     ├── [Authorize] Attributes                           │
│     └── User Context Extraction                          │
│                                                          │
│  4. Business Logic Layer                                 │
│     ├── User-specific data filtering                     │
│     ├── Input validation (DTOs)                          │
│     └── Authorization checks                             │
│                                                          │
│  5. Data Layer                                           │
│     ├── BCrypt password hashing                          │
│     ├── Parameterized queries (EF Core)                  │
│     └── Foreign key constraints                          │
└──────────────────────────────────────────────────────────┘
```

## CI/CD Pipeline

```
┌───────────┐
│   Git Push│
└─────┬─────┘
      │
      ▼
┌─────────────────┐
│ GitHub Actions  │
└────┬────────────┘
     │
     ├─────────────────────────────┐
     │                             │
     ▼                             ▼
┌──────────┐                ┌────────────┐
│ Backend  │                │  Frontend  │
│ Build    │                │  Build     │
│          │                │            │
│ .NET 8   │                │  Node 20   │
│ Restore  │                │  npm ci    │
│ Build    │                │  Build     │
│ Test     │                │  Lint      │
└────┬─────┘                └─────┬──────┘
     │                            │
     └──────────┬─────────────────┘
                │
                ▼
         ┌──────────────┐
         │ Docker Build │
         │              │
         │ Build Images │
         │ Test Compose │
         └──────────────┘
```

## Component Interaction

```
Frontend Components:
┌────────────┐     ┌──────────────┐     ┌────────────┐
│   Login    │────>│ AuthService  │────>│ Redux Store│
└────────────┘     └──────────────┘     └────────────┘
                                               │
┌────────────┐     ┌──────────────┐           │
│  Register  │────>│ AuthService  │───────────┤
└────────────┘     └──────────────┘           │
                                               ▼
┌────────────┐     ┌──────────────┐     ┌──────────┐
│ Dashboard  │────>│ TaskService  │────>│ API Call │
└────────────┘     └──────────────┘     └────┬─────┘
      │                                       │
      ▼                                       ▼
┌────────────┐                         ┌───────────┐
│ TaskModal  │                         │  Backend  │
└────────────┘                         │    API    │
                                       └───────────┘
```

This architecture provides:
- Clean separation of concerns
- Scalability
- Security
- Maintainability
- Testability
