@echo off
setlocal enabledelayedexpansion
title Backup Kilat Foto dan WhatsApp HP Android

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

set "ADB=%~dp0platform-tools\adb.exe"

color 0A
echo ================================================================
echo           BACKUP KILAT FOTO DAN WHATSAPP HP ANDROID
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini menyalin (pull) data penting dari HP klien ke laptop:
echo 1. Seluruh Galeri Foto dan Video Kamera (/sdcard/DCIM)
echo 2. Data Media WhatsApp (/sdcard/Android/media/com.whatsapp)
echo 3. Folder Dokumen dan Download
echo.
echo Syarat: HP harus terhubung dengan USB Debugging aktif.
echo.

echo Memeriksa sambungan HP...
"%ADB%" devices
echo.

for /f "tokens=*" %%a in ('"%ADB%" shell getprop ro.product.model 2^>nul') do set "MODEL=%%a"
set "MODEL=%MODEL: =_%"
set "MODEL=%MODEL:~0,15%"
if "%MODEL%"=="" set "MODEL=Android"

for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set "TGL=%%a-%%b-%%c"
set "TARGET_DIR=%USERPROFILE%\Desktop\BACKUP_HP_%MODEL%_%TGL%"

echo Folder penyimpanan di Laptop:
echo %TARGET_DIR%
echo.
set /p "START_NOW=Ketik Y untuk mulai menyalin data sekarang (Y/T): "
if /i not "%START_NOW%"=="Y" exit /b

mkdir "%TARGET_DIR%\Foto_Kamera_DCIM" >nul 2>&1
mkdir "%TARGET_DIR%\WhatsApp" >nul 2>&1
mkdir "%TARGET_DIR%\Download" >nul 2>&1

echo.
echo [1/3] Menyalin Galeri Foto dan Video Kamera (DCIM)...
"%ADB%" pull /sdcard/DCIM/ "%TARGET_DIR%\Foto_Kamera_DCIM\"

echo [2/3] Menyalin Media WhatsApp...
"%ADB%" pull /sdcard/Android/media/com.whatsapp/ "%TARGET_DIR%\WhatsApp\" >nul 2>&1
"%ADB%" pull /sdcard/WhatsApp/ "%TARGET_DIR%\WhatsApp\" >nul 2>&1

echo [3/3] Menyalin Folder Download...
"%ADB%" pull /sdcard/Download/ "%TARGET_DIR%\Download\" >nul 2>&1

color 0A
echo.
echo ================================================================
echo [SUKSES] Seluruh data berhasil diselamatkan ke Desktop!
echo Silakan periksa folder: %TARGET_DIR%
echo ================================================================
echo.
start "" "%TARGET_DIR%"
pause
