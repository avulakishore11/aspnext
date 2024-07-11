# STEP 1: Setup the base image for SDK to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Setup working directory
WORKDIR /source

# Copy the .csproj and .sln files to restore dependencies
COPY src/template/Aspnext.Template.csproj ./
COPY Aspnext.sln ./

# Restore the dependencies
RUN dotnet restore

# Copy the rest of the application code
COPY . .

# Run the test cases
RUN dotnet test

# Build the application using dotnet publish
RUN dotnet publish -c Release -o /app/published






# Use the official .NET SDK image as the build environment
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory
WORKDIR /source

# Copy the solution file 
COPY Aspnext.sln ./
# Copy the project file
COPY src/template/Aspnext.Template.csproj ./

# Copy the project file and restore dependencies
#COPY src/template/Aspnext.Template.csproj src/template/

# Restore the dependencies for the specific project
RUN dotnet restore src/template/Aspnext.Template.csproj

# Copy the entire source code
COPY . .

# Restore the dependencies using the solution file
RUN dotnet restore Aspnext.sln

# Build the solution using MSBuild
RUN msbuild /p:Configuration=Release Aspnext.sln

# Publish the application(s) within the solution
RUN dotnet publish Aspnext.sln -c Release -o /app/published --no-build

# Use the official .NET runtime image as the runtime environment
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Set the working directory
WORKDIR /app

# Copy the build output from the build stage
COPY --from=build /app/published .

# Set the entry point for the application
ENTRYPOINT ["dotnet", "Aspnext.Template.dll"]
