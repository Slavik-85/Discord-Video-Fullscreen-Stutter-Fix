@echo off
:: Check admin (net session fails if not admin)
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

rem --- Variables ---
set "ps1file=%~dp0discordfsooff.ps1"
set "ps1url=https://raw.githubusercontent.com/Slavik-85/Discord-Video-Fullscreen-Stutter-Fix/refs/heads/main/discordfsooff.ps1"
set "batfile=%~f0"
set "runkey=HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
set "valuename=DiscordFSOAutopatch"

powershell -Command "Invoke-WebRequest -Uri '%ps1url%' -OutFile '%ps1file%'"
reg add "%runkey%" /v "%valuename%" /d "\"%batfile%\"" /f >nul
powershell -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -WindowStyle Hidden powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%ps1file%\"'"
timeout /t 2 >nul
del "%ps1file%" >nul 2>&1
