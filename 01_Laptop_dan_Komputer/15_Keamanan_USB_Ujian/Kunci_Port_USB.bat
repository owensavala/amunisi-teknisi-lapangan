@echo off
title Kunci Port USB Laptop (Mencegah Kebocoran Soal Ujian)
color 1F

echo ========================================================
echo        KUNCI PORT USB (KHUSUS LAB UJIAN / ANBK / TKA)
echo ========================================================
echo.

:: Cek Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Mohon jalankan dengan Klik Kanan -^> "Run as Administrator"
    pause
    exit /b
)

echo Pilih mode penguncian USB:
echo 1. Kunci Write-Protect (Siswa bisa baca isi flashdisk, tapi TIDAK BISA copy soal ujian ke flashdisk)
echo 2. Blokir Total USB Storage (Flashdisk sama sekali tidak terbaca di laptop)
echo.
set /p PILIHAN="Pilih nomor (1 atau 2): "

if "%PILIHAN%"=="1" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorageDevicePolicies" /v "WriteProtect" /t REG_DWORD /d 1 /f >nul 2>&1
    echo.
    echo ========================================================
    echo      PORT USB BERHASIL DIKUNCI WRITE-PROTECT!
    echo ========================================================
    echo Siswa tidak bisa menyalin dokumen atau soal ujian ke flashdisk!
)

if "%PILIHAN%"=="2" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
    echo.
    echo ========================================================
    echo        SEMUA FLASHDISK / USB STORAGE DIBLOKIR TOTAL!
    echo ========================================================
    echo Flashdisk tidak akan terbaca di Windows Explorer.
)

echo.
pause
