@echo off
setlocal enabledelayedexpansion

echo ================================================
echo Task Manager Application - Quick Start
echo ================================================
echo.

REM Check for Docker
where docker >nul 2>nul
if %errorlevel% neq 0 (
    echo X Docker is not installed. Please install Docker first.
    exit /b 1
)

where docker-compose >nul 2>nul
if %errorlevel% neq 0 (
    echo X Docker Compose is not installed. Please install Docker Compose first.
    exit /b 1
)

echo √ Docker and Docker Compose are installed
echo.

REM Check for .NET SDK
where dotnet >nul 2>nul
if %errorlevel% neq 0 (
    echo ! .NET SDK 8 is not installed. You'll need it for local development.
    echo   Download from: https://dotnet.microsoft.com/download/dotnet/8.0
) else (
    for /f "tokens=*" %%i in ('dotnet --version') do set dotnetversion=%%i
    echo √ .NET SDK is installed: !dotnetversion!
)

REM Check for Node.js
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo ! Node.js is not installed. You'll need it for local development.
    echo   Download from: https://nodejs.org/
) else (
    for /f "tokens=*" %%i in ('node --version') do set nodeversion=%%i
    echo √ Node.js is installed: !nodeversion!
)

echo.
echo ================================================
echo Choose an option:
echo ================================================
echo 1) Run with Docker Compose (Production)
echo 2) Run with Docker Compose (Development)
echo 3) Setup for local development
echo 4) Stop all containers
echo 5) Clean up (remove containers and volumes)
echo.
set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" (
    echo.
    echo Starting application in production mode...
    docker-compose up --build -d
    echo.
    echo √ Application started!
    echo   - Backend API: http://localhost:5000
    echo   - Swagger: http://localhost:5000/swagger
    echo   - Frontend: http://localhost:5173
    echo.
    echo To view logs: docker-compose logs -f
    echo To stop: docker-compose down
) else if "%choice%"=="2" (
    echo.
    echo Starting application in development mode...
    docker-compose -f docker-compose.dev.yml up --build
) else if "%choice%"=="3" (
    echo.
    echo Setting up local development environment...
    echo.
    
    echo Setting up backend...
    cd backend
    dotnet restore
    cd ..
    echo √ Backend dependencies restored
    
    echo.
    echo Setting up frontend...
    cd frontend
    call npm install
    cd ..
    echo √ Frontend dependencies installed
    
    echo.
    echo √ Local development environment is ready!
    echo.
    echo To run the backend:
    echo   cd backend\TaskManager.Api
    echo   dotnet run
    echo.
    echo To run the frontend:
    echo   cd frontend
    echo   npm run dev
) else if "%choice%"=="4" (
    echo.
    echo Stopping all containers...
    docker-compose down
    docker-compose -f docker-compose.dev.yml down
    echo √ All containers stopped
) else if "%choice%"=="5" (
    echo.
    echo Cleaning up containers and volumes...
    docker-compose down -v
    docker-compose -f docker-compose.dev.yml down -v
    echo √ Cleanup complete
) else (
    echo Invalid choice. Please run the script again.
    exit /b 1
)

pause
