@echo off
title Backup Semua Driver Laptop Sebelum Instal Ulang
color 1F

echo ========================================================
echo       BACKUP SEMUA DRIVER LAPTOP KE FLASHDISK / D:\
echo ========================================================
echo.

:: Cek Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Mohon jalankan dengan Klik Kanan -^> "Run as Administrator"
    pause
    exit /b
)

echo Pilih tempat penyimpanan hasil backup driver:
echo 1. Simpan di Drive D:\Backup_Drivers
echo 2. Simpan di Flashdisk / Harddisk Eksternal
echo.
set /p PILIHAN="Pilih nomor (1 atau 2): "

set DEST=
if "%PILIHAN%"=="1" (
    if not exist D:\ (
        echo [ERROR] Drive D:\ tidak ditemukan!
        pause
        exit /b
    )
    set DEST=D:\Backup_Drivers
)

if "%PILIHAN%"=="2" (
    set /p EXTDRV="Masukkan huruf Flashdisk (misal E atau F): "
    set EXTDRV=%EXTDRV::=%
    set DEST=%EXTDRV%:\Backup_Drivers
)

if "%DEST%"=="" (
    echo [ERROR] Pilihan tidak valid!
    pause
    exit /b
)

if not exist "%DEST%" mkdir "%DEST%"

echo.
echo ========================================================
echo Menyedot seluruh driver asli laptop ini ke:
echo %DEST%
echo (Driver Wi-Fi, VGA, Audio, Chipset, Bluetooth, Touchpad)
echo Mohon tunggu 1-2 menit...
echo ========================================================
echo.

dism /online /export-driver /destination:"%DEST%"

echo.
echo ========================================================
echo            SEMUA DRIVER BERHASIL DI-BACKUP!
echo ========================================================
echo Nanti setelah instal ulang Windows baru, Anda tinggal
echo jalankan file "Restore_Driver_Laptop.bat" untuk memasang
echo semua driver ini kembali secara otomatis tanpa internet!
echo.
pause
