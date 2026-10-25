@echo off
title Penyelamat Flashdisk Virus Shortcut & File Hilang
color 1F

echo ========================================================
echo    PENYELAMAT FLASHDISK DARI VIRUS SHORTCUT & HIDDEN
echo ========================================================
echo.

:: Hentikan proses virus berbasis script yang sedang aktif
taskkill /f /im wscript.exe >nul 2>&1
taskkill /f /im cscript.exe >nul 2>&1

echo Masukkan Huruf Drive Flashdisk yang bermasalah.
echo (Contoh: ketik E lalu tekan Enter)
echo.
set /p USBDRV="Huruf Flashdisk (misal E atau F): "

:: Hilangkan tanda titik dua jika user mengetik E:
set USBDRV=%USBDRV::=%

if "%USBDRV%"=="" (
    echo [ERROR] Huruf drive tidak boleh kosong!
    pause
    exit /b
)

if /i "%USBDRV%"=="C" (
    echo [BAHAYA] Tidak boleh memilih drive C (Drive Sistem)!
    pause
    exit /b
)

if not exist %USBDRV%:\ (
    echo [ERROR] Drive %USBDRV%:\ tidak ditemukan! Pastikan flashdisk sudah tercolok.
    pause
    exit /b
)

echo.
echo [1/3] Menghapus virus shortcut (.lnk) dan file berbahaya di root flashdisk...
del /q /f "%USBDRV%:\*.lnk" >nul 2>&1
del /q /f "%USBDRV%:\autorun.inf" >nul 2>&1
del /q /f "%USBDRV%:\*.vbs" >nul 2>&1

echo [2/3] Membuka kembali semua file dan folder yang disembunyikan virus...
echo       (Proses ini memakan waktu beberapa detik tergantung isi flashdisk...)
attrib -h -r -s /s /d %USBDRV%:\*.*

echo [3/3] Selesai membersihkan!
echo.
echo ========================================================
echo       SEMUA FILE DAN FOLDER ASLI TELAH MUNCUL KEMBALI!
echo ========================================================
echo.
echo Catatan: Buka flashdisk %USBDRV%:\. Jika file Anda sebelumnya berada
echo di dalam folder tanpa nama / folder tersembunyi, sekarang sudah
echo bisa dibuka dan dipindahkan ke luar.
echo.
pause
