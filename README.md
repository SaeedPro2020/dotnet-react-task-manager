# Task Manager - Full Stack Application

A full-stack task management application built with ASP.NET Core 8 (backend) and React TypeScript (frontend).

## Features

- ✅ User authentication with JWT tokens
- ✅ Secure password hashing with BCrypt
- ✅ CRUD operations for tasks
- ✅ User-specific task management
- ✅ Redux Toolkit for state management
- ✅ Docker support with docker-compose
- ✅ CI/CD with GitHub Actions
- ✅ SQLite database
- ✅ Swagger API documentation

## Tech Stack

### Backend
- ASP.NET Core 8 Web API
- Entity Framework Core 8
- SQLite Database
- JWT Authentication
- BCrypt for password hashing
- Swagger/OpenAPI

### Frontend
- React 18
- TypeScript
- Redux Toolkit
- React Router v6
- Axios
- Vite

## Project Structure

```
dotnet-react-task-manager/
├── backend/
│   ├── TaskManager.Api/          # Web API project
│   │   ├── Controllers/          # API controllers
│   │   ├── Services/             # Business logic services
│   │   ├── DTOs/                 # Data transfer objects
│   │   ├── Program.cs            # Application entry point
│   │   └── appsettings.json      # Configuration
│   ├── TaskManager.Domain/       # Domain models
│   │   └── Models/               # Entity models (User, TaskItem)
│   ├── TaskManager.Infrastructure/ # Data access layer
│   │   ├── Data/                 # DbContext
│   │   └── Repositories/         # Repository pattern
│   ├── Dockerfile                # Backend container
│   └── TaskManager.sln           # Solution file
├── frontend/
│   ├── src/
│   │   ├── api/                  # API client
│   │   ├── components/           # React components
│   │   ├── pages/                # Page components
│   │   ├── store/                # Redux store & slices
│   │   ├── types/                # TypeScript types
│   │   ├── App.tsx               # Root component
│   │   └── main.tsx              # Entry point
│   ├── Dockerfile                # Frontend container
│   ├── package.json              # Dependencies
│   └── vite.config.ts            # Vite configuration
├── docker-compose.yml            # Container orchestration
└── .github/workflows/build.yml   # CI/CD pipeline
```

## Prerequisites

To run this application, you need to install:

1. **.NET SDK 8.0** - [Download here](https://dotnet.microsoft.com/download/dotnet/8.0)
2. **Node.js 20+** - [Download here](https://nodejs.org/)
3. **Docker** (optional, for containerized deployment) - [Download here](https://www.docker.com/)

## Getting Started

### Option 1: Run Locally

#### Backend Setup

```bash
# Navigate to backend directory
cd backend

# Restore dependencies
dotnet restore

# Run the API
cd TaskManager.Api
dotnet run
```

The API will be available at `http://localhost:5000`
Swagger documentation: `http://localhost:5000/swagger`

#### Frontend Setup

```bash
# Navigate to frontend directory
cd frontend

# Install dependencies
npm install

# Run development server
npm run dev
```

The frontend will be available at `http://localhost:5173`

### Option 2: Run with Docker Compose

```bash
# Build and start all services
docker-compose up --build

# Or run in detached mode
docker-compose up -d --build
```

- Backend API: `http://localhost:5000`
- Frontend: `http://localhost:5173`
- Swagger: `http://localhost:5000/swagger`

To stop the services:
```bash
docker-compose down
```

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register a new user
- `POST /api/auth/login` - Login and receive JWT token

### Tasks (Requires Authentication)
- `GET /api/tasks` - Get all tasks for authenticated user
- `GET /api/tasks/{id}` - Get a specific task
- `POST /api/tasks` - Create a new task
- `PUT /api/tasks/{id}` - Update a task
- `DELETE /api/tasks/{id}` - Delete a task

## Environment Variables

### Backend (`backend/TaskManager.Api/appsettings.json`)
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Data Source=taskmanager.db"
  },
  "JwtSettings": {
    "SecretKey": "YourSuperSecretKeyThatIsAtLeast32CharactersLong!",
    "Issuer": "TaskManagerApi",
    "Audience": "TaskManagerClient",
    "ExpirationInMinutes": 60
  }
}
```

### Frontend (`frontend/.env`)
```
VITE_API_URL=http://localhost:5000/api
```

## Development

### Backend

```bash
# Build the solution
dotnet build

# Run tests (when available)
dotnet test

# Create a new migration
cd backend/TaskManager.Api
dotnet ef migrations add MigrationName --project ../TaskManager.Infrastructure

# Apply migrations
dotnet ef database update --project ../TaskManager.Infrastructure
```

### Frontend

```bash
# Install dependencies
npm install

# Run development server with hot reload
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Lint code
npm run lint
```

## Testing

### Using Swagger UI
1. Navigate to `http://localhost:5000/swagger`
2. Register a new user using `/api/auth/register`
3. Login using `/api/auth/login` to get a JWT token
4. Click "Authorize" button and enter: `Bearer YOUR_TOKEN`
5. Test the task endpoints

### Using the Frontend
1. Open `http://localhost:5173`
2. Register a new account
3. Login with your credentials
4. Create, edit, and manage your tasks

## CI/CD

GitHub Actions workflow (`.github/workflows/build.yml`) automatically:
- Builds the backend with .NET 8
- Builds the frontend with Node 20
- Runs tests
- Builds Docker images
- Validates docker-compose configuration

## Security Features

- JWT token-based authentication
- BCrypt password hashing
- User-specific data isolation
- CORS configuration
- Secure token storage in localStorage

## Future Enhancements

- [ ] Add unit and integration tests
- [ ] Implement refresh tokens
- [ ] Add task categories/tags
- [ ] Task sharing between users
- [ ] Email notifications
- [ ] Task filtering and sorting
- [ ] Dark mode
- [ ] Responsive design improvements
- [ ] PostgreSQL/MySQL support
- [ ] Task priority levels
- [ ] Task attachments

## License

MIT License

## Author

Created as a demonstration of a full-stack application with modern technologies.
