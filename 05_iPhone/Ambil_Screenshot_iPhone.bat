@echo off
setlocal enabledelayedexpansion
title Ambil Screenshot Layar iPhone ke Laptop

cd /d "%~dp0"

color 0A
echo ================================================================
echo           AMBIL SCREENSHOT LAYAR IPHONE KE LAPTOP
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini mengambil tangkapan layar iPhone langsung ke file PNG di PC
echo tanpa perlu menekan kombinasi tombol fisik di iPhone.
echo.

for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set "TGL=%%a-%%b-%%c"
set "SHOT_FILE=%USERPROFILE%\Desktop\Screenshot_iPhone_%TGL%_%random%.png"

echo Sedang mengambil gambar layar iPhone...
idevicescreenshot.exe "%SHOT_FILE%" >nul 2>&1

if exist "%SHOT_FILE%" (
    echo.
    echo ================================================================
    echo [BERHASIL] Gambar layar iPhone berhasil disimpan ke Desktop!
    echo File: %SHOT_FILE%
    echo ================================================================
    echo.
    start "" "%SHOT_FILE%"
) else (
    color 0C
    echo.
    echo [GAGAL] Tidak dapat mengambil screenshot.
    echo Pastikan iPhone dalam kondisi menyala (layar terbuka) dan kabel terhubung.
    echo.
)

pause
