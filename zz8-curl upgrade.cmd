@echo off

title Curl update

set URL=https://curl.se/windows/latest.cgi?p=win64-mingw.zip

cd /d %~dp0

cls

:test
ping -n 4 -l 64 -4 8.8.8.8

if ERRORLEVEL 1 cls & echo. & echo ping test failure. terminate update & echo. & pause & exit
if ERRORLEVEL 0 cls & goto start


:start

del /s /q curl-temp.zip
cls
echo.

echo Downloading latest curl version...
echo.
.\curl\curl.exe -fJL -# -o .\curl-temp.zip %URL%

echo.
echo Removing old files..
echo.
del /s /q ".\curl\**"

echo.
echo Copying new files...
.\7z\7z.exe e .\curl-temp.zip -ssp -ocurl-temp -y
echo.
xcopy .\curl-temp\curl.exe .\curl\ /V /Q /Y
xcopy .\curl-temp\curl-ca-bundle.crt .\curl\ /V
xcopy .\curl-temp\libcurl-x64.def .\curl\ /V
xcopy .\curl-temp\libcurl-x64.dll .\curl\ /V

del .\curl-temp.zip
rd /s /q .\curl-temp

echo.
echo Update successfully.
echo.
pause
