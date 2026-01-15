FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 8081
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 as build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["FormulaOne.Api/FormulaOne.Api.csproj", "FormulaOne.Api/"]
COPY ["FormulaOne.DataService/FormulaOne.DataService.csproj", "FormulaOne.DataService/"]
COPY ["FormulaOne.Entities/FormulaOne.Entities.csproj", "FormulaOne.Entities/"]
RUN dotnet restore "FormulaOne.Api/FormulaOne.Api.csproj"
COPY . .
WORKDIR "/src/FormulaOne.Api"
RUN dotnet build "FormulaOne.Api.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "FormulaOne.Api.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT [ "dotnet", "FormulaOne.Api.dll" ]