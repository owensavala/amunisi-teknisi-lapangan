@echo off
title Masuk ke Windows Safe Mode Sekali Klik
color 1F

echo ========================================================
echo        MASUK KE WINDOWS SAFE MODE (MODE AMAN)
echo ========================================================
echo (Berguna untuk menghapus virus bandel atau driver bermasalah)
echo.

:: Cek Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Mohon jalankan dengan Klik Kanan -^> "Run as Administrator"
    pause
    exit /b
)

bcdedit /set {current} safeboot minimal

echo ========================================================
echo Laptop telah disetel untuk BOOTING KE SAFE MODE!
echo ========================================================
echo.
echo Begitu laptop di-restart, Windows otomatis masuk Safe Mode.
echo (Nanti setelah selesai, jalankan file 'Keluar_Safe_Mode.bat')
echo.
set /p REB="Apakah ingin restart laptop sekarang? (Y/T): "
if /i "%REB%"=="Y" shutdown /r /t 0
pause
