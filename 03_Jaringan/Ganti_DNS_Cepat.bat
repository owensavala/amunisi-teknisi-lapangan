@echo off
title Ganti DNS Cepat (Google / Cloudflare / Normal)
color 1F

echo ========================================================
echo         GANTI DNS ADAPTER JARINGAN SEKALIK KLIK
echo ========================================================
echo (Solusi saat web sekolah/ujian diblokir atau DNS lemot)
echo.

:: Cek Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Mohon jalankan dengan Klik Kanan -^> "Run as Administrator"
    pause
    exit /b
)

echo Pilih DNS yang ingin digunakan:
echo 1. Google DNS (8.8.8.8 dan 8.8.4.4) - Paling Stabil
echo 2. Cloudflare DNS (1.1.1.1 dan 1.0.0.1) - Paling Cepat & Anti Blokir
echo 3. Kembalikan ke Otomatis (DHCP Bawaan Router / Wi-Fi)
echo.
set /p PIL="Pilih nomor (1, 2, atau 3): "

if "%PIL%"=="1" (
    powershell -NoProfile -Command "Get-NetAdapter | Where-Object { $_.Status -eq 'Up' } | ForEach-Object { Set-DnsClientServerAddress -InterfaceIndex $_.ifIndex -ServerAddresses ('8.8.8.8','8.8.4.4') }" >nul 2>&1
    ipconfig /flushdns >nul 2>&1
    echo.
    echo ========================================================
    echo      DNS BERHASIL DIUBAH KE GOOGLE DNS (8.8.8.8)!
    echo ========================================================
)

if "%PIL%"=="2" (
    powershell -NoProfile -Command "Get-NetAdapter | Where-Object { $_.Status -eq 'Up' } | ForEach-Object { Set-DnsClientServerAddress -InterfaceIndex $_.ifIndex -ServerAddresses ('1.1.1.1','1.0.0.1') }" >nul 2>&1
    ipconfig /flushdns >nul 2>&1
    echo.
    echo ========================================================
    echo    DNS BERHASIL DIUBAH KE CLOUDFLARE DNS (1.1.1.1)!
    echo ========================================================
)

if "%PIL%"=="3" (
    powershell -NoProfile -Command "Get-NetAdapter | Where-Object { $_.Status -eq 'Up' } | ForEach-Object { Set-DnsClientServerAddress -InterfaceIndex $_.ifIndex -ResetServerAddresses }" >nul 2>&1
    ipconfig /flushdns >nul 2>&1
    echo.
    echo ========================================================
    echo      DNS DIKEMBALIKAN KE OTOMATIS (DEFAULT DHCP)!
    echo ========================================================
)

echo.
pause
