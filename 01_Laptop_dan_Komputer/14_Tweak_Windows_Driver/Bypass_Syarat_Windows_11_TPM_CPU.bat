@echo off
setlocal enabledelayedexpansion
title Bypass Batasan Hardware Windows 11 TPM dan CPU

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0B
echo ================================================================
echo       BYPASS BATASAN HARDWARE WINDOWS 11 (TPM, SECURE BOOT, CPU)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini memungkinkan Anda menginstall atau upgrade Windows 11 pada:
echo - Komputer tanpa chip TPM 2.0 (atau hanya TPM 1.2).
echo - Laptop dengan prosesor lama (Intel Gen 2 s/d Gen 7, AMD jadul).
echo - Komputer dengan RAM di bawah 4GB atau tanpa UEFI Secure Boot.
echo.
echo CARA PENGGUNAAN:
echo 1. Saat Install Ulang Windows 11 (Layar "This PC can't run Windows 11"):
echo    - Tekan Shift + F10 untuk membuka Command Prompt installer.
echo    - Colokkan flashdisk tools ini dan jalankan file bat ini.
echo 2. Saat Upgrade dari Windows 10 ke Windows 11 via file ISO/Setup:
echo    - Cukup jalankan script ini sekali sebelum mengklik setup.exe.
echo.
echo Tekan sembarang tombol untuk memasang bypass ke registry...
pause >nul

echo.
echo Memasang kunci LabConfig (Untuk installer baru)...
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassTPMCheck /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassSecureBootCheck /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassRAMCheck /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassStorageCheck /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassCPUCheck /t REG_DWORD /d 1 /f >nul 2>&1

echo Memasang kunci MoSetup (Untuk in-place upgrade ISO)...
reg add "HKLM\SYSTEM\Setup\MoSetup" /v AllowUpgradesWithUnsupportedTPMOrCPU /t REG_DWORD /d 1 /f >nul 2>&1

color 0A
echo.
echo ================================================================
echo [SUKSES] Batasan TPM 2.0, Secure Boot, dan CPU berhasil di-bypass!
echo Anda sekarang dapat melanjutkan instalasi Windows 11 tanpa hambatan.
echo ================================================================
echo.
pause
