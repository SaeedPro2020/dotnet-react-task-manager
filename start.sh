#!/bin/bash

# Task Manager Quick Start Script

echo "================================================"
echo "Task Manager Application - Quick Start"
echo "================================================"
echo ""

# Check for Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

echo "✅ Docker and Docker Compose are installed"
echo ""

# Check for .NET SDK
if ! command -v dotnet &> /dev/null; then
    echo "⚠️  .NET SDK 8 is not installed. You'll need it for local development."
    echo "   Download from: https://dotnet.microsoft.com/download/dotnet/8.0"
else
    echo "✅ .NET SDK is installed: $(dotnet --version)"
fi

# Check for Node.js
if ! command -v node &> /dev/null; then
    echo "⚠️  Node.js is not installed. You'll need it for local development."
    echo "   Download from: https://nodejs.org/"
else
    echo "✅ Node.js is installed: $(node --version)"
fi

echo ""
echo "================================================"
echo "Choose an option:"
echo "================================================"
echo "1) Run with Docker Compose (Production)"
echo "2) Run with Docker Compose (Development)"
echo "3) Setup for local development"
echo "4) Stop all containers"
echo "5) Clean up (remove containers and volumes)"
echo ""
read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        echo ""
        echo "🚀 Starting application in production mode..."
        docker-compose up --build -d
        echo ""
        echo "✅ Application started!"
        echo "   - Backend API: http://localhost:5000"
        echo "   - Swagger: http://localhost:5000/swagger"
        echo "   - Frontend: http://localhost:5173"
        echo ""
        echo "To view logs: docker-compose logs -f"
        echo "To stop: docker-compose down"
        ;;
    2)
        echo ""
        echo "🚀 Starting application in development mode..."
        docker-compose -f docker-compose.dev.yml up --build
        ;;
    3)
        echo ""
        echo "📦 Setting up local development environment..."
        echo ""
        
        # Backend setup
        echo "Setting up backend..."
        cd backend
        dotnet restore
        cd ..
        echo "✅ Backend dependencies restored"
        
        # Frontend setup
        echo ""
        echo "Setting up frontend..."
        cd frontend
        npm install
        cd ..
        echo "✅ Frontend dependencies installed"
        
        echo ""
        echo "✅ Local development environment is ready!"
        echo ""
        echo "To run the backend:"
        echo "  cd backend/TaskManager.Api"
        echo "  dotnet run"
        echo ""
        echo "To run the frontend:"
        echo "  cd frontend"
        echo "  npm run dev"
        ;;
    4)
        echo ""
        echo "🛑 Stopping all containers..."
        docker-compose down
        docker-compose -f docker-compose.dev.yml down
        echo "✅ All containers stopped"
        ;;
    5)
        echo ""
        echo "🧹 Cleaning up containers and volumes..."
        docker-compose down -v
        docker-compose -f docker-compose.dev.yml down -v
        echo "✅ Cleanup complete"
        ;;
    *)
        echo "Invalid choice. Please run the script again."
        exit 1
        ;;
esac
