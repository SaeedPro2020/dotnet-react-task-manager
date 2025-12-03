# Quick Start Guide

## Prerequisites Installation

### Required Software

#### 1. .NET 8 SDK
**Purpose:** Backend API development and runtime

**Installation:**
- **Windows:** Download from https://dotnet.microsoft.com/download/dotnet/8.0
- **macOS:** 
  ```bash
  brew install dotnet@8
  ```
- **Linux (Ubuntu):**
  ```bash
  wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  sudo apt-get update
  sudo apt-get install -y dotnet-sdk-8.0
  ```

**Verify Installation:**
```bash
dotnet --version
# Should output: 8.0.x
```

#### 2. Node.js 20+
**Purpose:** Frontend development and build tools

**Installation:**
- **Windows/macOS:** Download from https://nodejs.org/
- **Using nvm (recommended):**
  ```bash
  # Install nvm first, then:
  nvm install 20
  nvm use 20
  ```
- **macOS (Homebrew):**
  ```bash
  brew install node@20
  ```
- **Linux:**
  ```bash
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt-get install -y nodejs
  ```

**Verify Installation:**
```bash
node --version  # Should output: v20.x.x
npm --version   # Should output: 10.x.x
```

#### 3. Docker & Docker Compose (Optional but Recommended)
**Purpose:** Containerized deployment

**Installation:**
- **Windows/macOS:** Download Docker Desktop from https://www.docker.com/products/docker-desktop
- **Linux:**
  ```bash
  # Docker
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  
  # Docker Compose
  sudo apt-get install docker-compose-plugin
  ```

**Verify Installation:**
```bash
docker --version
docker-compose --version
```

---

## Installation Steps

### Method 1: Docker Compose (Recommended for Quick Start)

```bash
# 1. Clone or navigate to the project
cd /path/to/dotnet-react-task-manager

# 2. Start the application
docker-compose up --build -d

# 3. Wait for services to start (about 2-3 minutes)

# 4. Open your browser
# Frontend: http://localhost:5173
# Backend: http://localhost:5000
# Swagger: http://localhost:5000/swagger
```

**Stop the application:**
```bash
docker-compose down
```

**View logs:**
```bash
docker-compose logs -f
```

---

### Method 2: Local Development Setup

#### Step 1: Backend Setup

```bash
# Navigate to backend
cd backend

# Restore NuGet packages
dotnet restore

# Build the solution
dotnet build

# Navigate to API project
cd TaskManager.Api

# Run the API
dotnet run

# API should start at: http://localhost:5000
# Swagger UI: http://localhost:5000/swagger
```

**Alternative: Use Visual Studio or VS Code**
- Open `backend/TaskManager.sln` in Visual Studio
- Or open the `backend` folder in VS Code
- Press F5 to run

#### Step 2: Frontend Setup

```bash
# Open a new terminal
# Navigate to frontend
cd frontend

# Install npm packages
npm install

# Start development server
npm run dev

# Frontend should start at: http://localhost:5173
```

---

## First Time Setup Checklist

- [ ] **.NET 8 SDK installed** (`dotnet --version`)
- [ ] **Node.js 20+ installed** (`node --version`)
- [ ] **Docker installed** (optional) (`docker --version`)
- [ ] **Project downloaded/cloned**
- [ ] **Backend dependencies restored** (`dotnet restore`)
- [ ] **Frontend dependencies installed** (`npm install`)
- [ ] **Backend running** (port 5000)
- [ ] **Frontend running** (port 5173)
- [ ] **Opened browser to http://localhost:5173**

---

## Testing the Application

### 1. Register a New User
1. Open http://localhost:5173
2. Click "Register" link
3. Fill in the form:
   - First Name: John
   - Last Name: Doe
   - Email: john@example.com
   - Password: Test123456
4. Click "Register"
5. You should be redirected to the Dashboard

### 2. Create Your First Task
1. Click "Create New Task" button
2. Fill in the form:
   - Title: My First Task
   - Description: This is a test task
   - Due Date: (select a future date)
3. Click "Create"
4. Task should appear in the list

### 3. Manage Tasks
- **Complete:** Click "Complete" button to mark as done
- **Edit:** Click "Edit" to modify the task
- **Delete:** Click "Delete" to remove the task

### 4. Test API with Swagger
1. Open http://localhost:5000/swagger
2. Try `/api/auth/register` endpoint
3. Try `/api/auth/login` endpoint
4. Copy the token from login response
5. Click "Authorize" button
6. Enter: `Bearer YOUR_TOKEN_HERE`
7. Try the `/api/tasks` endpoints

---

## Troubleshooting

### Backend Issues

**Problem: Port 5000 already in use**
```bash
# Windows
netstat -ano | findstr :5000
taskkill /PID <PID> /F

# macOS/Linux
lsof -ti:5000 | xargs kill -9
```

**Problem: Database errors**
```bash
# Delete the database and restart
cd backend/TaskManager.Api
rm taskmanager.db
dotnet run
```

**Problem: NuGet restore fails**
```bash
# Clear NuGet cache
dotnet nuget locals all --clear
dotnet restore
```

### Frontend Issues

**Problem: Port 5173 already in use**
```bash
# Kill the process using the port
# macOS/Linux
lsof -ti:5173 | xargs kill -9

# Or change port in vite.config.ts
```

**Problem: npm install fails**
```bash
# Clear npm cache
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

**Problem: TypeScript errors**
```bash
# These are expected if packages aren't installed
npm install
```

### Docker Issues

**Problem: Containers won't start**
```bash
# Check logs
docker-compose logs

# Rebuild from scratch
docker-compose down -v
docker-compose up --build
```

**Problem: Port conflicts**
```bash
# Stop all containers
docker-compose down

# Change ports in docker-compose.yml if needed
```

---

## Development Workflow

### Daily Development

1. **Start Backend:**
   ```bash
   cd backend/TaskManager.Api
   dotnet watch run
   ```

2. **Start Frontend:**
   ```bash
   cd frontend
   npm run dev
   ```

3. **Make changes** - Both will hot-reload automatically

4. **Test your changes**

5. **Commit your code:**
   ```bash
   git add .
   git commit -m "Your message"
   git push
   ```

### Adding New Features

1. **Backend:**
   - Add models in `TaskManager.Domain/Models`
   - Update `AppDbContext`
   - Add DTOs in `TaskManager.Api/DTOs`
   - Add services in `TaskManager.Api/Services`
   - Add controllers in `TaskManager.Api/Controllers`

2. **Frontend:**
   - Add types in `src/types`
   - Add API calls in `src/api`
   - Add Redux slice in `src/store`
   - Add components in `src/components`
   - Add pages in `src/pages`

---

## Useful Commands

### Backend
```bash
# Build
dotnet build

# Run with hot reload
dotnet watch run

# Clean
dotnet clean

# Create migration
dotnet ef migrations add MigrationName

# Update database
dotnet ef database update
```

### Frontend
```bash
# Install dependencies
npm install

# Run dev server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Lint code
npm run lint
```

### Docker
```bash
# Build and start
docker-compose up --build

# Start in background
docker-compose up -d

# View logs
docker-compose logs -f

# Stop
docker-compose down

# Remove everything
docker-compose down -v
```

---

## Next Steps

1. ✅ Install prerequisites
2. ✅ Choose installation method (Docker or Local)
3. ✅ Follow installation steps
4. ✅ Test the application
5. ✅ Start developing!

For more information:
- See `README.md` for detailed documentation
- See `API_DOCUMENTATION.md` for API endpoints
- See `ARCHITECTURE.md` for system architecture
- See `PROJECT_SUMMARY.md` for complete file structure

---

## Support

If you encounter issues:
1. Check the Troubleshooting section above
2. Check the logs (application or Docker)
3. Verify all prerequisites are installed correctly
4. Try the alternative installation method

Happy coding! 🚀
