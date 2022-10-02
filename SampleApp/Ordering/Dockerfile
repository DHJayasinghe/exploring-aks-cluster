FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build
WORKDIR /src

COPY ["SampleApp/Ordering/Ordering.csproj", "Ordering/"]
RUN dotnet restore "Ordering/Ordering.csproj"

COPY ["SampleApp/Ordering", "Ordering/"]
WORKDIR "/src/Ordering"

RUN dotnet publish "Ordering.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Ordering.dll"]