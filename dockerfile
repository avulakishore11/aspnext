

# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the project file to the respective folder and restore dependencies
COPY src/template/Aspnext.Template.csproj src/template/
RUN dotnet restore src/template/Aspnext.Template.csproj

# Copy the remaining files and build the application
WORKDIR /app/src/template
COPY . .


# Publish the application
RUN dotnet publish Aspnext.Template.csproj -c Release -o /publish

# Stage 2: Create the runtime image
#FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
#WORKDIR /app
#COPY --from=build /publish .
#ENTRYPOINT ["dotnet", "Aspnext.Template.dll"]

