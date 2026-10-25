@echo off
title Perbaikan Otomatis File Sistem Windows Rusak (DISM & SFC)
color 1F

echo ========================================================
echo     PERBAIKAN OTOMATIS SISTEM WINDOWS RUSAK / KORUP
echo ========================================================
echo (Mengatasi Windows sering hang, error blue screen, atau file hilang)
echo.

:: Cek Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Mohon jalankan dengan Klik Kanan -^> "Run as Administrator"
    pause
    exit /b
)

echo [1/3] Memeriksa kerusakan sistem file Windows (DISM CheckHealth)...
dism /online /cleanup-image /checkhealth
echo.

echo [2/3] Memperbaiki dan memulihkan file sistem yang rusak (DISM RestoreHealth)...
echo       (Proses ini memakan waktu beberapa menit, mohon tunggu...)
dism /online /cleanup-image /restorehealth
echo.

echo [3/3] Memindai dan mengganti file Windows yang korup (SFC Scannow)...
sfc /scannow
echo.

echo ========================================================
echo          PROSES PERBAIKAN SISTEM TELAH SELESAI!
echo ========================================================
echo Silakan restart laptop Anda agar perbaikan bekerja maksimal.
echo.
pause
