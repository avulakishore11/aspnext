
# setup base image for runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0-bullseye-slim AS base

# setup working directory
WORKDIR /app

#exposing port
EXPOSE 80
EXPOSE 443

# setup base image for SDK 
FROM mcr.microsoft.com/dotnet/sdk:8.0-bullseye-slim AS build
WORKDIR /src
COPY ["AspnextTemplate.csproj", "AspnextTemplate/"]
# run the dotnet restore

RUN dotnet restore "AspnextTemplate/AspnextTemplate.csproj"
COPY . ./AspnextTemplate
WORKDIR "/src/AspnextTemplate"
RUN dotnet build "AspnextTemplate.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "AspnextTemplate.csproj" -c Release -o /app/publish

