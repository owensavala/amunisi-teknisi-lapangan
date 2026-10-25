@echo off
setlocal enabledelayedexpansion
title Pasang File APK ke HP Android

set "ADB=%~dp0platform-tools\adb.exe"

color 0B
echo ================================================================
echo             PASANG FILE APK OTOMATIS KE HP ANDROID
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini memasang file installer aplikasi (.apk) langsung ke HP
echo tanpa perlu copy file ke memori HP terlebih dahulu.
echo.
echo Silakan DRAG and DROP (Tarik dan Lepas) file APK ke jendela ini,
echo lalu tekan ENTER:
echo.
set /p "APK_PATH=File APK: "

set "APK_PATH=%APK_PATH:"=%"

if "%APK_PATH%"=="" (
    echo Tidak ada file yang dipilih!
    pause
    exit /b
)

if not exist "%APK_PATH%" (
    echo File APK "%APK_PATH%" tidak ditemukan!
    pause
    exit /b
)

echo.
echo Memeriksa sambungan HP...
"%ADB%" devices
echo.
echo Sedang menginstall file APK ke HP...
"%ADB%" install -r -d "%APK_PATH%"

if %errorlevel% equ 0 (
    color 0A
    echo.
    echo [BERHASIL] Aplikasi APK sukses terpasang di HP!
) else (
    color 0C
    echo.
    echo [GAGAL] Terjadi kesalahan saat instalasi APK.
    echo Pastikan opsi "Install via USB" diizinkan pada Opsi Pengembang HP.
)

echo.
pause
