@echo off
setlocal enabledelayedexpansion

rem Find the latest Discord app folder
set "discordDir=%localappdata%\Discord"
set "latestApp="
for /f "delims=" %%D in ('dir /b /ad "%discordDir%\app-*" 2^>nul') do (
    set "currentApp=%%D"
    if "!currentApp!" gtr "!latestApp!" set "latestApp=!currentApp!"
)

if not defined latestApp (
    echo Discord not found.
    pause
    exit /b 1
)

set "discordExe=%discordDir%\%latestApp%\Discord.exe"

rem Set the registry key
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%discordExe%" /d "~ DISABLEDXMAXIMIZEDWINDOWEDMODE" /f

rem Add to startup
set "startupDir=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "batchSelf=%~f0"
if /I not "%batchSelf%"=="%startupDir%\discordfsooff.bat" (
    copy "%batchSelf%" "%startupDir%\discordfsooff.bat" /Y >nul
)

echo Successfully patched, restart discord if open.

pause