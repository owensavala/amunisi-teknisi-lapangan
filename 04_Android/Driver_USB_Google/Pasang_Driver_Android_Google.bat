@echo off
setlocal enabledelayedexpansion
title Pasang Driver Android ADB dan Fastboot Google

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0A
echo ================================================================
echo       PEMASANG DRIVER RESMI GOOGLE ADB DAN FASTBOOT
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini mendaftarkan file android_winusb.inf resmi ke Windows Driver Store.
echo Mengatasi masalah HP Android bertanda seru kuning di Device Manager:
echo - Android Bootloader Interface
echo - Android Composite ADB Interface
echo.
echo Sedang memasang driver ke sistem Windows...
echo.

pnputil /add-driver "%~dp0usb_driver\android_winusb.inf" /install

echo.
echo ================================================================
echo [SUKSES] Driver Google ADB dan Fastboot telah terpasang di sistem!
echo Colokkan kembali HP Android Anda untuk menikmati deteksi otomatis.
echo ================================================================
echo.
pause
