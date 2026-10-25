@echo off
title Perbaikan Suara / Audio Hilang Sekali Klik
color 1F

echo ========================================================
echo     PERBAIKAN SUARA / AUDIO LAPTOP HILANG (SILANG MERAH)
echo ========================================================
echo.

:: Cek Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Mohon jalankan dengan Klik Kanan -^> "Run as Administrator"
    pause
    exit /b
)

echo [1/3] Menghentikan Layanan Audio Windows...
net stop AudioEndpointBuilder >nul 2>&1
net stop Audiosrv >nul 2>&1

echo [2/3] Menyetel ulang dan menyalakan kembali Layanan Audio...
sc config Audiosrv start=auto >nul 2>&1
sc config AudioEndpointBuilder start=auto >nul 2>&1
net start AudioEndpointBuilder >nul 2>&1
net start Audiosrv >nul 2>&1
echo       -^> Layanan Audio Windows berhasil dihidupkan ulang.

echo [3/3] Melakukan scan ulang perangkat hardware speaker/headset...
pnputil /scan-devices >nul 2>&1
echo       -^> Hardware audio telah disegarkan.

echo.
echo ========================================================
echo          PERBAIKAN SUARA TELAH SELESAI!
echo ========================================================
echo Silakan coba putar musik atau video.
echo.
pause
