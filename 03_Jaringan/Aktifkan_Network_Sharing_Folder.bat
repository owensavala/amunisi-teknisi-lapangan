@echo off
setlocal enabledelayedexpansion
title Aktifkan Network Discovery dan File Sharing Jaringan

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0A
echo ================================================================
echo           AKTIFKAN NETWORK DISCOVERY DAN FILE SHARING
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Masalah yang diatasi:
echo - Komputer tidak muncul di folder "Network" di Windows Explorer.
echo - Folder sharing atau printer sharing tidak bisa diakses komputer lain.
echo - Muncul pesan error "Network path was not found" (0x80070035).
echo.
echo Langkah perbaikan yang akan dieksekusi:
echo 1. Mengubah profil jaringan aktif dari Public ke Private.
echo 2. Membuka Port Firewall untuk "File and Printer Sharing".
echo 3. Membuka Port Firewall untuk "Network Discovery".
echo 4. Mengaktifkan Service penemuan perangkat (FDResPub, fdPHost, SSDPSRV).
echo 5. Mengaktifkan izin akses SMB Guest Auth untuk sharing tanpa password.
echo.
echo Tekan sembarang tombol untuk memulai proses...
pause >nul

echo.
echo [1/5] Mengatur profil semua jaringan aktif ke PRIVATE...
powershell -NoProfile -Command "Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private -ErrorAction SilentlyContinue" >nul 2>&1

echo [2/5] Membuka izin Firewall untuk File and Printer Sharing...
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes >nul 2>&1

echo [3/5] Membuka izin Firewall untuk Network Discovery...
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes >nul 2>&1

echo [4/5] Mengaktifkan dan memulai service penemuan jaringan...
sc config FDResPub start= delayed-auto >nul 2>&1
net start FDResPub >nul 2>&1
sc config fdPHost start= delayed-auto >nul 2>&1
net start fdPHost >nul 2>&1
sc config SSDPSRV start= demand >nul 2>&1
net start SSDPSRV >nul 2>&1
sc config upnphost start= demand >nul 2>&1
net start upnphost >nul 2>&1

echo [5/5] Mengaktifkan SMB Insecure Guest Auth (Akses sharing tanpa sandi)...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v AllowInsecureGuestAuth /t REG_DWORD /d 1 /f >nul 2>&1

echo.
echo ================================================================
echo [SUKSES] Fitur Network Discovery dan Sharing Folder telah AKTIF!
echo Sekarang komputer ini dapat dilihat dan melihat komputer lain
echo di jaringan lokal lab atau kantor.
echo ================================================================
echo.
pause
