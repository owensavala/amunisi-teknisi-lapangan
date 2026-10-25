@echo off
title Munculkan Ikon Desktop Standar (This PC, User, Control Panel)
color 1F

echo ========================================================
echo    MUNCULKAN IKON DESKTOP STANDAR (WINDOWS 10 & 11)
echo ========================================================
echo.

:: 1. This PC (Computer)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f >nul 2>&1

:: 2. User Files
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0 /f >nul 2>&1

:: 3. Control Panel
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{5399E694-D3C1-4D0E-B5CE-56E05B75066F}" /t REG_DWORD /d 0 /f >nul 2>&1

:: 4. Network
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /t REG_DWORD /d 0 /f >nul 2>&1

:: 5. Recycle Bin
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0 /f >nul 2>&1

echo Menyegarkan tampilan Windows Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo ========================================================
echo   IKON THIS PC, USER, DAN CONTROL PANEL TELAH MUNCUL!
echo ========================================================
echo.
pause
