@echo off
title Restart Windows Explorer Desktop

color 0E
echo Sedang merestart Windows Explorer dan Taskbar...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 1 /nobreak >nul
start explorer.exe
echo Selesai!
