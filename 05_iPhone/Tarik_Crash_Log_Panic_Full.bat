@echo off
setlocal enabledelayedexpansion
title Tarik Log Kerusakan iPhone dan Analisis Panic Full

cd /d "%~dp0"

color 0C
echo ================================================================
echo       PENARIK LOG KERUSAKAN IPHONE DAN ANALISIS PANIC FULL
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini digunakan untuk mendiagnosa iPhone yang sering:
echo - Restart sendiri setiap 3 menit atau 5 menit sekali.
echo - Tiba-tiba mati (black screen) lalu nyala kembali ke logo Apple.
echo - Mengalami crash aplikasi sistem (SpringBoard / Kernel Panic).
echo.
echo Syarat: iPhone harus terhubung dan telah di-Trust (Percayai Komputer Ini).
echo.

for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set "TGL=%%a-%%b-%%c"
set "LOG_DIR=%USERPROFILE%\Desktop\Crash_Log_iPhone_%TGL%"

echo Folder penyimpanan hasil analisa:
echo %LOG_DIR%
echo.
echo Sedang menarik seluruh file log dari memori iPhone...
echo.

idevicecrashreport.exe -e "%LOG_DIR%"

if exist "%LOG_DIR%" (
    color 0A
    echo.
    echo ================================================================
    echo [SUKSES] Seluruh log sistem berhasil ditarik ke Desktop!
    echo Folder: %LOG_DIR%
    echo.
    echo PANDUAN TEKNISI MEMBACA FILE "panic-full":
    echo 1. Buka folder di atas dan cari file berawalan "panic-full-....ips".
    echo 2. Buka file tersebut dengan Notepad, lalu cari kata "missing sensor":
    echo    * prs0       : Fleksibel Konektor Charger / Lubang Cas rusak.
    echo    * mic1       : Fleksibel Tombol Power / Lampu Flash rusak.
    echo    * tg0b / tg0v: Konektor baterai kendor atau baterai rusak.
    echo    * AOP PANIC  : Fleksibel Speaker Atas / Proximity / Face ID terkena air.
    echo 3. Ganti sparepart fleksibel sesuai sensor yang hilang tersebut!
    echo ================================================================
    echo.
    start "" "%LOG_DIR%"
) else (
    color 0C
    echo [INFO] Tidak ada file crash baru yang tercatat, atau iPhone belum terhubung.
    echo.
)

pause
