@echo off
setlocal enabledelayedexpansion
title Buka Blokir Task Manager, Regedit, dan CMD

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0E
echo ================================================================
echo       BUKA BLOKIR TASK MANAGER, REGEDIT, DAN COMMAND PROMPT
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Masalah yang diatasi:
echo - "Task Manager has been disabled by your administrator"
echo - "Registry editing has been disabled by your administrator"
echo - "The command prompt has been disabled by your administrator"
echo - Folder Options (Show Hidden Files) disembunyikan oleh virus.
echo.
echo Sedang menghapus seluruh pembatasan kebijakan virus...
echo.

:: Hapus pembatasan Task Manager
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f >nul 2>&1

:: Hapus pembatasan Regedit
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableRegistryTools /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableRegistryTools /f >nul 2>&1

:: Hapus pembatasan Command Prompt
reg delete "HKCU\Software\Policies\Microsoft\Windows\System" /v DisableCMD /f >nul 2>&1
reg delete "HKLM\Software\Policies\Microsoft\Windows\System" /v DisableCMD /f >nul 2>&1

:: Pulihkan Folder Options (Tampilkan File Tersembunyi)
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoFolderOptions /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoFolderOptions /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 1 /f >nul 2>&1

color 0A
echo.
echo ================================================================
echo [SUKSES] Task Manager, Registry Editor, dan CMD telah DIBUKA KEMBALI!
echo Anda sekarang dapat menekan Ctrl+Shift+Esc untuk membuka Task Manager.
echo ================================================================
echo.
pause
