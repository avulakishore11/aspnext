
# setup base image for runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base

# setup working directory
WORKDIR /app

#exposing port
EXPOSE 80
EXPOSE 443

# setup base image for SDK 
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY src/template/Aspnext.Template.csproj .
# run the dotnet restore

RUN dotnet restore src/template/Aspnext.Template.csproj
COPY . .
WORKDIR "/src/AspnextTemplate"
RUN dotnet build "src/template/Aspnext.Template.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "src/template/Aspnext.Template.csproj" -c Release -o /app/publish

