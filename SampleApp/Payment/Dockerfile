FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build
WORKDIR /src

COPY ["SampleApp/Payment/Payment.csproj", "Payment/"]
RUN dotnet restore "Payment/Payment.csproj"

COPY ["SampleApp/Payment", "Payment/"]
WORKDIR "/src/Payment"

RUN dotnet publish "Payment.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Payment.dll"]