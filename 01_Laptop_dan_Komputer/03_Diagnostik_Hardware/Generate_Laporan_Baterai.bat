@echo off
setlocal enabledelayedexpansion
title Laporan Kesehatan Baterai Laptop

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0A
echo ================================================================
echo           PEMBUAT LAPORAN KESEHATAN BATERAI LAPTOP
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Sedang menganalisis riwayat penggunaan dan kapasitas baterai...
echo Mohon tunggu beberapa detik...
echo.

set "REPORT_PATH=%USERPROFILE%\Desktop\Laporan_Baterai_Laptop.html"

:: Jalankan powercfg batteryreport
powercfg /batteryreport /output "%REPORT_PATH%" >nul 2>&1

if exist "%REPORT_PATH%" (
    echo [SUKSES] Laporan baterai berhasil dibuat di Desktop!
    echo File: %REPORT_PATH%
    echo.
    echo ----------------------------------------------------------------
    echo CARA MEMBACA LAPORAN:
    echo 1. DESIGN CAPACITY  : Kapasitas asli baterai saat baru dari pabrik.
    echo 2. FULL CHARGE CAP. : Kapasitas maksimal baterai saat ini.
    echo    * Jika Full Charge jauh lebih kecil dari Design (misal drop 50%%),
    echo      berarti baterai sudah bocor / aus.
    echo 3. CYCLE COUNT      : Jumlah siklus pengisian daya.
    echo ----------------------------------------------------------------
    echo.
    echo Membuka laporan di browser...
    start "" "%REPORT_PATH%"
) else (
    color 0C
    echo [PERINGATAN] Gagal membuat laporan baterai!
    echo Kemungkinan penyebab:
    echo 1. Perangkat ini adalah PC Desktop (tanpa baterai).
    echo 2. Baterai laptop tidak terdeteksi oleh BIOS / Windows.
    echo.
)

echo.
pause
