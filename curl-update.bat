@echo off

set URL=https://curl.se/windows/latest.cgi?p=win64-mingw.zip

cd /d %~dp0

cls
echo.

:test
echo test internet connection..
ping -n 4 -l 32 -w 10 -4 8.8.8.8 >/NUL
if not errorlevel 1 (
goto start
) else (
cls & echo. & echo test failded. check your interner & echo. & pause & exit 1
)


:start

cls
echo.
echo Downloading latest curl version...
echo.
.\curl.exe -fJL -# -o .\curl-temp.zip %URL%

.\7za.exe e .\curl-temp.zip -ssp -ocurl-temp -y
copy /V /Y .\curl-temp\curl.exe ".\"
copy /V /Y .\curl-temp\curl-ca-bundle.crt ".\"

:: install curl certificate
certutil -addstore -user -f .\curl-ca-bundle.crt

del /q .\curl-temp.zip
rd /s /q .\curl-temp

echo.
pause
