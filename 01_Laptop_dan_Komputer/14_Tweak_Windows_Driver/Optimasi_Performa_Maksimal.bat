@echo off
title Speed Booster & Optimasi Performa Maksimal Laptop
color 1F

echo ========================================================
echo       SPEED BOOSTER & OPTIMASI PERFORMA MAKSIMAL
echo ========================================================
echo (Mengaktifkan Ultimate Performance & meringankan Windows)
echo.

:: Cek Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Mohon jalankan dengan Klik Kanan -^> "Run as Administrator"
    pause
    exit /b
)

echo [1/4] Mengaktifkan Skema Daya "Ultimate Performance" (Performa Tertinggi)...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
echo       -^> Skema performa maksimal diaktifkan.

echo [2/4] Mematikan efek transparansi dan animasi berat Windows...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul 2>&1
echo       -^> Beban grafis dan delay animasi diminimalisir.

echo [3/4] Mematikan Windows Telemetry & Diagnostic tracking (hemat CPU/Disk)...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start=disabled >nul 2>&1
echo       -^> Pelacakan diagnostik latar belakang dinonaktifkan.

echo [4/4] Mengoptimalkan cache file dan paging system...
fsutil behavior set memoryusage 2 >nul 2>&1
echo       -^> Manajemen cache RAM dioptimasi.

echo.
echo ========================================================
echo        LAPTOP SUDAH DIOPTIMASI KE PERFORMA TERTINGGI!
echo ========================================================
echo.
pause
