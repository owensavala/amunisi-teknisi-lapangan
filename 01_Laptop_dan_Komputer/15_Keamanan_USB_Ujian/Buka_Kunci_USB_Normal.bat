@echo off
title Buka Kembali Kunci Port USB Laptop
color 1F

echo ========================================================
echo       MEMBUKA KEMBALI KUNCI PORT USB KE NORMAL
echo ========================================================
echo.

:: Cek Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Mohon jalankan dengan Klik Kanan -^> "Run as Administrator"
    pause
    exit /b
)

:: Buka Write-Protect
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorageDevicePolicies" /v "WriteProtect" /t REG_DWORD /d 0 /f >nul 2>&1

:: Buka Blokir USBSTOR
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1

echo ========================================================
echo       SEMUA PORT USB SUDAH KEMBALI NORMAL!
echo ========================================================
echo Flashdisk sekarang sudah bisa dibaca dan ditulis normal seperti biasa.
echo.
pause
