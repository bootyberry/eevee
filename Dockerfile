# escape=`
FROM golang:windowsservercore-ltsc2022 AS build
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]
COPY . C:/src/
WORKDIR C:/src
RUN go build

FROM mcr.microsoft.com/windows/nanoserver:ltsc2022 AS final
COPY --from=build C:\src\eevee.exe C:\app\eevee.exe
COPY --from=build C:\src\config.ini C:\app\config.ini

WORKDIR C:\app
CMD [ "eevee.exe" ]