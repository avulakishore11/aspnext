

# setup base image for SDK 
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY src/template/Aspnext.Template.csproj . 

RUN dotnet restore 
COPY src/template/Aspnext.Template.csproj .
RUN dotnet test 

FROM build AS publish
RUN dotnet publish -c Release -o /publish

# stage 2
# setup base image for runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base

#WORKDIR /app

#COPY --from=build /app/publish 

