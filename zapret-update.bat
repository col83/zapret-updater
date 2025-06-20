@echo off

set URL=https://github.com/bol-van/zapret-win-bundle/archive/refs/heads/master.zip

cd /d %~dp0

cls

TASKLIST /FI "STATUS eq RUNNING" | find "winws.exe" >/NUL
if not errorlevel 1 (
taskkill /F /IM winws.exe >/NUL
)

:test
echo.
echo test internet connection
ping -n 4 -l 32 -w 10 -4 8.8.8.8 >/NUL
if not errorlevel 1 (
goto start
) else (
cls & echo. & echo test failded. check your interner & echo. & pause & exit 1
)


:start

cls

if exist ".\zapret-win" (
sc delete windivert >/NUL
sc stop windivert >/NUL
rd /s /q ".\zapret-win"
)

echo.
echo Downloading latest zapret version...
echo.
.\curl.exe -fJL -# -o .\zapret-win.zip %URL%

echo.
echo Extract archive...
.\7za.exe x .\zapret-win.zip -ssp

rename zapret-win-bundle-master zapret-win

rd /s /q .\zapret-win\.github
rd /s /q .\zapret-win\arm64
rd /s /q .\zapret-win\win7
del /q .\zapret-win\.gitattributes
del /q .\zapret-win\readme.md

del /q .\zapret-win.zip
