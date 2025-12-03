# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj files and restore dependencies
COPY TaskManager.Api/TaskManager.Api.csproj TaskManager.Api/
COPY TaskManager.Domain/TaskManager.Domain.csproj TaskManager.Domain/
COPY TaskManager.Infrastructure/TaskManager.Infrastructure.csproj TaskManager.Infrastructure/

RUN dotnet restore TaskManager.Api/TaskManager.Api.csproj

# Copy everything else and build
COPY . .
WORKDIR /src/TaskManager.Api
RUN dotnet build TaskManager.Api.csproj -c Release -o /app/build

# Publish stage
FROM build AS publish
RUN dotnet publish TaskManager.Api.csproj -c Release -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
EXPOSE 5000

COPY --from=publish /app/publish .

# Set environment variables
ENV ASPNETCORE_URLS=http://+:5000
ENV ASPNETCORE_ENVIRONMENT=Production

ENTRYPOINT ["dotnet", "TaskManager.Api.dll"]
