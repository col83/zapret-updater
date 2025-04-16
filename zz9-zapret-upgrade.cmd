@echo off

title zapret update

set URL=https://github.com/bol-van/zapret-win-bundle/archive/refs/heads/master.zip

cd /d %~dp0

cls

echo.
echo Terminate winws (zapret) process
echo.
TASKKILL /F /IM winws.exe /T

echo.

:test
ping -n 4 -l 64 -4 8.8.8.8

if ERRORLEVEL 1 cls & echo. & echo ping test failure. terminate update & echo. & pause & exit
if ERRORLEVEL 0 cls goto start


:start

del .\zapret-win.zip
cls

if exist ".\zapret-win" echo. & echo Deleting old version... & rd /s /q zapret-win

echo.
echo Downloading latest version...
echo.
.\curl\curl.exe -fJL -# -o .\zapret-win.zip %URL%

echo.
echo Extract archive...
.\7z\7z.exe x .\zapret-win.zip -ssp

rename zapret-win-bundle-master zapret-win

rd /s /q .\zapret-win\.github
rd /s /q .\zapret-win\arm64
rd /s /q .\zapret-win\win7
del .\zapret-win\.gitattributes
del .\zapret-win\readme.md

del .\zapret-win.zip


echo.
echo Update successfully.
echo.
pause