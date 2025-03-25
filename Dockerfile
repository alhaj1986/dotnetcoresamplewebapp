# Use the official .NET SDK image as a build environment
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /source

COPY . .
RUN dotnet restore test/dotnetKonf.Web.Test/dotnetKonf.Web.Test.csproj
RUN dotnet publish test/dotnetKonf.Web.Test/dotnetKonf.Web.Test.csproj --output /dotnetkonf/ --configuration release

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /dotnetkonf
COPY --from=build-env /dotnetkonf .

ENTRYPOINT ["dotnet", "dotnetKonf.Web.Test.dll"]
