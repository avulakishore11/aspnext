# Use the official .NET SDK image as the build environment
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory
WORKDIR /source

# Copy the solution file 
COPY src/template/Template/src/AspnextTemplate.Api/AspnextTemplate.Api.csproj .





# Restore the dependencies for the specific project
RUN dotnet restore 
COPY . .

RUN dotnet test


# Build the solution using MSBuild
# RUN msbuild /p:Configuration=Release Aspnext.sln

# Publish the application(s) within the solution
# RUN dotnet publish Aspnext.sln -c Release -o /app/published --no-build

# Publish the application(s) within the solution
RUN dotnet publish 'src/template/Template/src/AspnextTemplate.Api/AspnextTemplate.Api.csproj"  -c Release -o /app/published

