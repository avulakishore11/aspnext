# Use the official .NET SDK image as the build environment
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory
WORKDIR /source

# Copy the solution file 
COPY Aspnext.sln ./

# Copy the project file
COPY src/template/Aspnext.Template.csproj ./

# Copy the project file and restore dependencies
# COPY src/template/Aspnext.Template.csproj src/template/

# Restore the dependencies for the specific project
RUN dotnet restore src/template/Aspnext.Template.csproj

# Copy the entire source code
COPY . .

# Restore the dependencies using the solution file
RUN dotnet restore Aspnext.sln

# Build the solution using MSBuild
# RUN msbuild /p:Configuration=Release Aspnext.sln

# Publish the application(s) within the solution
# RUN dotnet publish Aspnext.sln -c Release -o /app/published --no-build

# Publish the application(s) within the solution
RUN dotnet publish Aspnext.sln -c Release -o /app/published

