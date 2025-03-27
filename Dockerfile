# Use the official .NET SDK image as a build environment
FROM mcr.microsoft.com/dotnet/sdk:2.1 AS build-env
WORKDIR /source

COPY . .
RUN dotnet restore src/dotnetKonf.Web/dotnetKonf.Web.csproj
RUN dotnet publish src/dotnetKonf.Web/dotnetKonf.Web.csproj --output /dotnetkonf/ --configuration release

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:2.1
WORKDIR /dotnetkonf
COPY --from=build-env /dotnetkonf .

ENTRYPOINT ["dotnet", "dotnetKonf.Web.dll"]
