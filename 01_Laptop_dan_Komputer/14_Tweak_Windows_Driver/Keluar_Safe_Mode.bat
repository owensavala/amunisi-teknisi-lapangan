@echo off
title Keluar dari Safe Mode (Kembali ke Windows Normal)
color 1F

echo ========================================================
echo        KELUAR DARI SAFE MODE KE WINDOWS NORMAL
echo ========================================================
echo.

:: Cek Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Mohon jalankan dengan Klik Kanan -^> "Run as Administrator"
    pause
    exit /b
)

bcdedit /deletevalue {current} safeboot >nul 2>&1

echo ========================================================
echo Setelan Safe Mode telah DIHAPUS.
echo ========================================================
echo.
echo Laptop sekarang akan booting normal seperti biasa.
echo.
set /p REB="Apakah ingin restart laptop sekarang? (Y/T): "
if /i "%REB%"=="Y" shutdown /r /t 0
pause
