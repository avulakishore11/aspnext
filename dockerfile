# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the solution file and project file to the container
COPY Aspnext.sln ./
COPY src/template/Aspnext.Template.csproj src/template/

# Restore dependencies
RUN dotnet restore Aspnext.sln

# Copy the remaining files and build the application
COPY . .
WORKDIR /app/src/template
RUN dotnet test
RUN dotnet publish -c Release -o /publish

# Stage 2: Create the runtime image
# FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
# WORKDIR /app
# COPY --from=build /publish .
# ENTRYPOINT ["dotnet", "Aspnext.Template.dll"]
