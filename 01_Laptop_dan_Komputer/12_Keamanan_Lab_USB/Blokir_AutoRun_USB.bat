@echo off
title Kunci dan Matikan AutoRun USB (Pencegah Virus Lab)
color 1F

echo ========================================================
echo     MATIKAN AUTORUN & AUTOPLAY USB (ANTI VIRUS LAB)
echo ========================================================
echo.

:: Cek Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Mohon jalankan dengan Klik Kanan -^> "Run as Administrator"
    pause
    exit /b
)

echo [1/3] Mematikan AutoRun di Registry Sistem (HKLM)...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HonorAutorunSetting" /t REG_DWORD /d 1 /f >nul 2>&1

echo [2/3] Mematikan AutoRun di Registry User (HKCU)...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f >nul 2>&1

echo [3/3] Mematikan fitur Shell Hardware Detection AutoPlay...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v "DisableAutoplay" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v "DisableAutoplay" /t REG_DWORD /d 1 /f >nul 2>&1

echo.
echo ========================================================
echo       AUTORUN TELAH DIMATIKAN 100%% DI LAPTOP INI!
echo ========================================================
echo.
echo Efeknya: Ketika flashdisk siswa dicolok ke laptop lab,
echo virus TIDAK BISA berjalan otomatis membobol Windows.
echo Laptop lab akan jauh lebih awet dan bebas virus.
echo.
pause
