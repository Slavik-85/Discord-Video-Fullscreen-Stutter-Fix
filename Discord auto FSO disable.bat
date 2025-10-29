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

rem Use VBScript as a wrapper to run PowerShell hidden (no console window)
echo Set objShell = CreateObject("Wscript.Shell") > "%temp%\runfso.vbs"
echo objShell.Run "powershell -NoProfile -ExecutionPolicy Bypass -File ""%ps1file%""", 0, False >> "%temp%\runfso.vbs"
cscript //B "%temp%\runfso.vbs"
del "%temp%\runfso.vbs"

timeout /t 2 >nul
del "%ps1file%" >nul 2>&1
