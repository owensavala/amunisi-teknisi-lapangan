@echo off
setlocal enabledelayedexpansion
title Manajemen dan Pembersihan Driver Printer Corrupt

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0E
echo ================================================================
echo           PEMBERSIH DRIVER PRINTER CORRUPT / BEKAS
echo                 (Print Server Properties - Drivers)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Masalah yang diatasi:
echo - Driver printer lama menolak dihapus ("Driver is currently in use").
echo - Spooler sering crash / mati sendiri akibat driver printer rusak.
echo - Konflik driver printer lama saat memasang printer merk baru.
echo.
echo Langkah yang akan dilakukan:
echo 1. Merestart Print Spooler untuk melepaskan file lock.
echo 2. Membuka jendela khusus "Print Server Properties" tab Driver.
echo.
echo Tekan sembarang tombol untuk membuka manajemen driver...
pause >nul

echo.
echo Merestart spooler...
net stop spooler >nul 2>&1
timeout /t 1 /nobreak >nul
net start spooler >nul 2>&1

echo Membuka antarmuka manajemen driver printer...
start "" rundll32.exe printui.dll,PrintUIEntry /s /t2

echo.
echo ================================================================
echo PETUNJUK TEKNISI:
echo 1. Pada jendela yang terbuka, cari nama driver printer yang bermasalah.
echo 2. Klik nama driver, lalu klik tombol "Remove..." (Hapus).
echo 3. Pilih "Remove driver and driver package" (Rekomendasi) agar
echo    seluruh file driver tercabut bersih dari sistem Windows.
echo ================================================================
echo.
pause
