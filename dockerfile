# Stage 1: Build the application using SDK image 
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the solution file and restore dependencies
COPY Aspnext.sln ./
COPY src/template/Aspnext.Template.csproj ./
RUN dotnet restore "Aspnext.sln" 

# Copy the remaining files and build the application
COPY . .
WORKDIR /app
RUN dotnet test
RUN dotnet build "Aspnext.sln" -c Release 
RUN dotnet publish "Aspnext.sln" -c Release -o /app/publish

# Stage 2: Create the runtime image
# FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
# WORKDIR /app
# COPY --from=build /publish .
# ENTRYPOINT ["dotnet", "Aspnext.Template.dll"]
