# Helpful Commands Reference

Quick reference for common tasks and commands.

---

## 🚀 Starting the Application

### Using Scripts (Easiest)
```bash
# Linux/Mac
./start.sh

# Windows
start.bat
```

### Using Docker Compose
```bash
# Production mode
docker-compose up --build

# Development mode (with hot reload)
docker-compose -f docker-compose.dev.yml up

# Run in background
docker-compose up -d

# Stop services
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

### Local Development
```bash
# Backend
cd backend/TaskManager.Api
dotnet run

# Frontend (separate terminal)
cd frontend
npm run dev
```

---

## 🔧 Backend Commands

### Build & Run
```bash
# Restore dependencies
dotnet restore

# Build solution
dotnet build

# Run with hot reload
dotnet watch run

# Run specific project
cd TaskManager.Api
dotnet run

# Clean build artifacts
dotnet clean
```

### Database & Migrations
```bash
# Install EF Core tools (first time only)
dotnet tool install --global dotnet-ef

# Create migration
cd backend/TaskManager.Api
dotnet ef migrations add MigrationName --project ../TaskManager.Infrastructure

# Apply migrations
dotnet ef database update --project ../TaskManager.Infrastructure

# Remove last migration
dotnet ef migrations remove --project ../TaskManager.Infrastructure

# View migrations
dotnet ef migrations list --project ../TaskManager.Infrastructure

# Generate SQL script
dotnet ef migrations script --project ../TaskManager.Infrastructure
```

### Testing
```bash
# Run tests
dotnet test

# Run tests with coverage
dotnet test /p:CollectCoverage=true
```

### Publishing
```bash
# Publish for deployment
dotnet publish -c Release -o ./publish

# Publish for specific runtime
dotnet publish -c Release -r linux-x64 --self-contained
```

---

## 🎨 Frontend Commands

### Development
```bash
# Install dependencies
npm install

# Start dev server
npm run dev

# Start with host mode (for network access)
npm run dev -- --host

# Build for production
npm run build

# Preview production build
npm run preview
```

### Code Quality
```bash
# Run linter
npm run lint

# Fix linting issues
npm run lint -- --fix

# Type check
npx tsc --noEmit
```

### Package Management
```bash
# Install specific package
npm install package-name

# Install dev dependency
npm install -D package-name

# Update packages
npm update

# Check for outdated packages
npm outdated

# Clean install (remove node_modules first)
rm -rf node_modules package-lock.json
npm install
```

---

## 🐳 Docker Commands

### Building Images
```bash
# Build backend image
cd backend
docker build -t taskmanager-backend .

# Build frontend image
cd frontend
docker build -t taskmanager-frontend .

# Build with no cache
docker build --no-cache -t taskmanager-backend .
```

### Container Management
```bash
# List running containers
docker ps

# List all containers
docker ps -a

# View logs
docker logs <container-id>

# Follow logs
docker logs -f <container-id>

# Stop container
docker stop <container-id>

# Remove container
docker rm <container-id>

# Remove all stopped containers
docker container prune
```

### Image Management
```bash
# List images
docker images

# Remove image
docker rmi <image-id>

# Remove unused images
docker image prune

# Remove all unused images
docker image prune -a
```

### Docker Compose
```bash
# Start services
docker-compose up

# Start in background
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs

# Follow logs
docker-compose logs -f

# View logs for specific service
docker-compose logs backend

# Rebuild and start
docker-compose up --build

# Scale services
docker-compose up --scale backend=3

# Execute command in container
docker-compose exec backend bash
docker-compose exec frontend sh
```

---

## 🧪 Testing Commands

### API Testing with cURL

#### Authentication
```bash
# Register
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"Test123","firstName":"John","lastName":"Doe"}'

# Login
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"Test123"}'

# Save token
TOKEN="your_jwt_token_here"
```

#### Tasks
```bash
# Get all tasks
curl -X GET http://localhost:5000/api/tasks \
  -H "Authorization: Bearer $TOKEN"

# Get specific task
curl -X GET http://localhost:5000/api/tasks/1 \
  -H "Authorization: Bearer $TOKEN"

# Create task
curl -X POST http://localhost:5000/api/tasks \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"title":"Test Task","description":"Test Description"}'

# Update task
curl -X PUT http://localhost:5000/api/tasks/1 \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"title":"Updated","description":"Updated desc","isCompleted":true}'

# Delete task
curl -X DELETE http://localhost:5000/api/tasks/1 \
  -H "Authorization: Bearer $TOKEN"
```

---

## 🔍 Debugging Commands

### Check Ports
```bash
# Linux/Mac
lsof -i :5000
lsof -i :5173

# Windows
netstat -ano | findstr :5000
netstat -ano | findstr :5173
```

### Kill Process on Port
```bash
# Linux/Mac
lsof -ti:5000 | xargs kill -9
lsof -ti:5173 | xargs kill -9

# Windows
# Find PID first with netstat, then:
taskkill /PID <PID> /F
```

### View Running Processes
```bash
# Linux/Mac
ps aux | grep dotnet
ps aux | grep node

# Windows
tasklist | findstr dotnet
tasklist | findstr node
```

---

## 📦 Database Commands

### SQLite
```bash
# Install SQLite (if needed)
# Mac: brew install sqlite
# Ubuntu: sudo apt-get install sqlite3

# Open database
sqlite3 backend/TaskManager.Api/taskmanager.db

# Inside SQLite shell:
.tables                    # List tables
.schema Users             # Show table schema
SELECT * FROM Users;      # Query users
SELECT * FROM Tasks;      # Query tasks
.exit                     # Exit
```

### Quick Database Reset
```bash
# Delete database file
rm backend/TaskManager.Api/taskmanager.db
rm backend/TaskManager.Api/taskmanager.db-shm
rm backend/TaskManager.Api/taskmanager.db-wal

# Restart backend to recreate
cd backend/TaskManager.Api
dotnet run
```

---

## 🔄 Git Commands

### Basic Operations
```bash
# Check status
git status

# Add files
git add .
git add specific-file.txt

# Commit
git commit -m "Your commit message"

# Push
git push origin main

# Pull
git pull origin main
```

### Branch Operations
```bash
# Create branch
git checkout -b feature-name

# Switch branch
git checkout main

# List branches
git branch

# Delete branch
git branch -d feature-name

# Merge branch
git checkout main
git merge feature-name
```

### Useful Git Commands
```bash
# View commit history
git log --oneline

# View changes
git diff

# Undo last commit (keep changes)
git reset --soft HEAD~1

# Discard local changes
git checkout -- .

# View remote URL
git remote -v
```

---

## 🧹 Cleanup Commands

### Clean Backend
```bash
cd backend
dotnet clean
rm -rf */bin */obj
rm -rf TaskManager.Api/*.db*
```

### Clean Frontend
```bash
cd frontend
rm -rf node_modules
rm -rf dist
rm package-lock.json
```

### Clean Docker
```bash
# Remove all containers
docker rm $(docker ps -aq)

# Remove all images
docker rmi $(docker images -q)

# Remove all volumes
docker volume rm $(docker volume ls -q)

# Clean everything
docker system prune -a --volumes
```

### Complete Project Reset
```bash
# Backend
cd backend
dotnet clean
rm -rf */bin */obj
rm TaskManager.Api/*.db*

# Frontend
cd frontend
rm -rf node_modules dist
rm package-lock.json

# Docker
docker-compose down -v
docker system prune -a

# Reinstall
cd backend && dotnet restore
cd frontend && npm install
```

---

## 📊 Monitoring Commands

### View Logs
```bash
# Backend logs
cd backend/TaskManager.Api
dotnet run --verbosity detailed

# Docker logs
docker-compose logs -f

# Specific service logs
docker-compose logs -f backend
docker-compose logs -f frontend
```

### Health Checks
```bash
# Check backend
curl http://localhost:5000/swagger

# Check frontend
curl http://localhost:5173

# Check if services are up
docker-compose ps
```

---

## 🚀 Deployment Commands

### Build for Production
```bash
# Backend
cd backend
dotnet publish -c Release -o ./publish

# Frontend
cd frontend
npm run build
```

### Docker Production Build
```bash
# Build images
docker-compose -f docker-compose.yml build

# Start production
docker-compose -f docker-compose.yml up -d

# Check logs
docker-compose -f docker-compose.yml logs -f
```

---

## 💡 Quick Tips

### One-Liner Restarts
```bash
# Restart everything with Docker
docker-compose down && docker-compose up --build -d

# Restart backend only
docker-compose restart backend

# Restart with clean volumes
docker-compose down -v && docker-compose up --build
```

### Watch for Changes
```bash
# Backend hot reload
cd backend/TaskManager.Api && dotnet watch run

# Frontend hot reload (automatic with vite)
cd frontend && npm run dev
```

### Quick Database View
```bash
# View all users
sqlite3 backend/TaskManager.Api/taskmanager.db "SELECT * FROM Users;"

# View all tasks
sqlite3 backend/TaskManager.Api/taskmanager.db "SELECT * FROM Tasks;"

# Count records
sqlite3 backend/TaskManager.Api/taskmanager.db "SELECT COUNT(*) FROM Tasks;"
```

---

## 🆘 Emergency Commands

### When Everything Breaks
```bash
# 1. Stop everything
docker-compose down -v
pkill -f dotnet
pkill -f node

# 2. Clean everything
cd backend && dotnet clean && rm -rf */bin */obj
cd frontend && rm -rf node_modules dist

# 3. Reinstall
cd backend && dotnet restore
cd frontend && npm install

# 4. Restart
docker-compose up --build
```

### Can't Access Ports
```bash
# Kill processes on ports
lsof -ti:5000 | xargs kill -9
lsof -ti:5173 | xargs kill -9

# Or change ports in config files
```

---

Save this file for quick reference during development! 🚀
