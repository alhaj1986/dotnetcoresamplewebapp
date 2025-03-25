FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /source

COPY . .
RUN dotnet restore dotnetKonf.Web/dotnetKonf.Web.csproj
RUN dotnet publish dotnetKonf.Web/dotnetKonf.Web.csproj --output /dotnetkonf/ --configuration release

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /dotnetkonf
COPY --from=builder /dotnetkonf .

ENTRYPOINT ["dotnet", "dotnetKonf.Web.dll"]
