@echo off
setlocal enabledelayedexpansion
title Fastboot Toolkit Teknisi Android

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

set "FASTBOOT=%~dp0platform-tools\fastboot.exe"

:MENU
cls
color 0E
echo ================================================================
echo             FASTBOOT TOOLKIT TEKNISI ANDROID
echo            (Mode Bootloader / Fastboot Flashing)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Mode Fastboot digunakan ketika HP dalam kondisi:
echo - Bootloop (mentok di logo merk).
echo - Tombol fisik ditekan: Power + Volume Bawah saat HP mati.
echo - Ingin melakukan Unlock Bootloader (UBL) atau Hard Reset.
echo.
echo PILIHAN TINDAKAN:
echo [1] Cek Perangkat Terhubung (fastboot devices)
echo [2] Baca Info Lengkap Hardware dan Kunci UBL (fastboot getvar all)
echo [3] Hard Reset / Hapus Seluruh Data Pengguna (fastboot -w)
echo [4] Unlock Bootloader (fastboot flashing unlock - Model Baru)
echo [5] Unlock Bootloader (fastboot oem unlock - Model Lama)
echo [6] Kunci Kembali Bootloader (fastboot flashing lock)
echo [7] Reboot Kembali ke Sistem Normal
echo [8] Reboot ke Mode Recovery
echo [9] Keluar
echo.
set /p "CHOICE=Masukkan nomor pilihan (1-9): "

if "%CHOICE%"=="1" goto CEK_DEVICES
if "%CHOICE%"=="2" goto GET_INFO
if "%CHOICE%"=="3" goto WIPE_DATA
if "%CHOICE%"=="4" goto UNLOCK_NEW
if "%CHOICE%"=="5" goto UNLOCK_OLD
if "%CHOICE%"=="6" goto LOCK_BL
if "%CHOICE%"=="7" goto REBOOT_SYS
if "%CHOICE%"=="8" goto REBOOT_REC
if "%CHOICE%"=="9" exit /b
goto MENU

:CEK_DEVICES
cls
echo Sedang mendeteksi perangkat dalam mode Fastboot...
echo.
"%FASTBOOT%" devices
echo.
echo Jika tidak muncul nomor serial di atas:
echo 1. Pastikan HP berada di layar "Fastboot Mode" / kelinci Xiaomi / robot Android.
echo 2. Pasang Driver Android Bootloader Interface via Device Manager.
echo.
pause
goto MENU

:GET_INFO
cls
echo Membaca seluruh variabel sistem perangkat...
echo.
"%FASTBOOT%" getvar all
echo.
pause
goto MENU

:WIPE_DATA
cls
color 0C
echo ================================================================
echo PERINGATAN KERAS: TINDAKAN INI AKAN MENGHAPUS SELURUH DATA HP!
echo (Foto, Kontak, Akun, dan Aplikasi akan hilang kembali ke setelan pabrik)
echo ================================================================
echo.
set /p "CONFIRM=Ketik YAKIN untuk melanjutkan proses format: "
if /i not "%CONFIRM%"=="YAKIN" (
    echo Pembatalan berhasil.
    pause
    goto MENU
)
echo.
echo Sedang menghapus userdata dan cache...
"%FASTBOOT%" erase userdata
"%FASTBOOT%" erase cache
color 0A
echo.
echo [SUKSES] Data pengguna berhasil diformat bersih!
echo.
pause
goto MENU

:UNLOCK_NEW
cls
echo Mengirim perintah Unlock Bootloader (Flashing Unlock)...
echo Periksa layar HP Anda, konfirmasi dengan tombol Volume Atas!
echo.
"%FASTBOOT%" flashing unlock
echo.
pause
goto MENU

:UNLOCK_OLD
cls
echo Mengirim perintah Unlock Bootloader (OEM Unlock)...
echo Periksa layar HP Anda, konfirmasi dengan tombol Volume Atas!
echo.
"%FASTBOOT%" oem unlock
echo.
pause
goto MENU

:LOCK_BL
cls
echo Mengirim perintah Kunci Kembali Bootloader (Relock)...
echo.
"%FASTBOOT%" flashing lock
echo.
pause
goto MENU

:REBOOT_SYS
cls
echo Mengirim sinyal restart ke sistem...
"%FASTBOOT%" reboot
echo.
pause
goto MENU

:REBOOT_REC
cls
echo Mengirim sinyal restart ke Recovery Mode...
"%FASTBOOT%" reboot recovery
echo.
pause
goto MENU
