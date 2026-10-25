@echo off
title Restore / Pasang Kembali Semua Driver Hasil Backup
color 1F

echo ========================================================
echo       PASANG OTOMATIS SEMUA DRIVER HASIL BACKUP
echo ========================================================
echo.

:: Cek Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Mohon jalankan dengan Klik Kanan -^> "Run as Administrator"
    pause
    exit /b
)

echo Masukkan lokasi folder hasil backup driver.
echo Contoh: ketik D:\Backup_Drivers atau E:\Backup_Drivers
echo.
set /p DRVPATH="Lokasi folder driver: "

if "%DRVPATH%"=="" (
    echo [ERROR] Lokasi folder tidak boleh kosong!
    pause
    exit /b
)

if not exist "%DRVPATH%" (
    echo [ERROR] Folder "%DRVPATH%" tidak ditemukan!
    pause
    exit /b
)

echo.
echo ========================================================
echo Memasang semua driver dari: %DRVPATH%
echo Mohon tunggu sebentar sampai proses instalasi selesai...
echo ========================================================
echo.

pnputil /add-driver "%DRVPATH%\*.inf" /subdirs /install

echo.
echo ========================================================
echo         SEMUA DRIVER TELAH SELESAI DIPASANG!
echo ========================================================
echo Silakan restart laptop jika diminta oleh sistem.
echo.
pause
