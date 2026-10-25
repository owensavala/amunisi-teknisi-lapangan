@echo off
setlocal enabledelayedexpansion
title Pengatur Cepat IP Address Static dan DHCP

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

:MENU
cls
color 0B
echo ================================================================
echo           PENGATUR CEPAT IP ADDRESS (STATIC / DHCP)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini sangat berguna untuk:
echo - Setting cepat IP Static puluhan komputer lab ANBK / TKA / Ujian.
echo - Mengembalikan komputer ke mode DHCP Otomatis dalam 1 detik.
echo.
echo DAFTAR KARTU JARINGAN (ADAPTER) AKTIF:
echo ----------------------------------------------------------------

powershell -NoProfile -Command ^
    "Get-NetAdapter | Where-Object {$_.Status -eq 'Up'} | Select-Object Name, InterfaceDescription, LinkSpeed, Status | Format-Table -AutoSize"

echo ----------------------------------------------------------------
echo PILIHAN TINDAKAN:
echo [1] KEMBALIKAN KE OTOMATIS (DHCP) - Bawaan Pabrik / Wi-Fi Biasa
echo [2] SETTING CEPAT KLIEN UJIAN ANBK / CBT (Subnet 192.168.0.x)
echo [3] SETTING CEPAT SERVER VHD UJIAN ANBK (192.168.0.200)
echo [4] SETTING MANUAL CUSTOM (Ketik IP, Subnet, Gateway Sendiri)
echo [5] Keluar
echo.
set /p "CHOICE=Masukkan pilihan (1-5): "

if "%CHOICE%"=="1" goto SET_DHCP
if "%CHOICE%"=="2" goto SET_ANBK_CLIENT
if "%CHOICE%"=="3" goto SET_ANBK_SERVER
if "%CHOICE%"=="4" goto SET_CUSTOM
if "%CHOICE%"=="5" exit /b
goto MENU

:GET_ADAPTER
echo.
echo Masukkan NAMA ADAPTER yang ingin diatur (Contoh: Ethernet atau Wi-Fi):
set /p "ADAPTER_NAME=Nama Adapter: "
if "%ADAPTER_NAME%"=="" goto MENU
goto :eof

:SET_DHCP
call :GET_ADAPTER
echo.
echo Mengembalikan %ADAPTER_NAME% ke DHCP Otomatis...
netsh interface ipv4 set address name="%ADAPTER_NAME%" source=dhcp >nul 2>&1
netsh interface ipv4 set dnsservers name="%ADAPTER_NAME%" source=dhcp >nul 2>&1
color 0A
echo [BERHASIL] Adapter %ADAPTER_NAME% sekarang kembali ke mode DHCP Otomatis!
echo.
pause
goto MENU

:SET_ANBK_CLIENT
call :GET_ADAPTER
echo.
echo Masukkan nomor urut komputer klien ini (Contoh: 2 s/d 199):
set /p "CLIENT_NUM=Nomor Klien: "
if "%CLIENT_NUM%"=="" set "CLIENT_NUM=10"
set "IP=192.168.0.%CLIENT_NUM%"
set "MASK=255.255.255.0"
set "GATEWAY=192.168.0.200"

echo.
echo Menerapkan IP Klien Ujian:
echo IP Address : %IP%
echo Subnet Mask: %MASK%
echo Gateway    : %GATEWAY%
netsh interface ipv4 set address name="%ADAPTER_NAME%" static %IP% %MASK% %GATEWAY% 1 >nul 2>&1
netsh interface ipv4 set dnsservers name="%ADAPTER_NAME%" static 192.168.0.200 primary >nul 2>&1
color 0A
echo [BERHASIL] IP Klien Ujian berhasil diatur!
echo.
pause
goto MENU

:SET_ANBK_SERVER
call :GET_ADAPTER
echo.
echo Menerapkan IP Server VHD Ujian Resmi:
echo IP Address : 192.168.0.200
echo Subnet Mask: 255.255.255.0
echo Gateway    : Kosong (Mode Standalone Lab)
netsh interface ipv4 set address name="%ADAPTER_NAME%" static 192.168.0.200 255.255.255.0 none >nul 2>&1
netsh interface ipv4 set dnsservers name="%ADAPTER_NAME%" static none >nul 2>&1
color 0A
echo [BERHASIL] IP Server VHD 192.168.0.200 berhasil diatur!
echo.
pause
goto MENU

:SET_CUSTOM
call :GET_ADAPTER
echo.
set /p "CUSTOM_IP=Masukkan IP Address   (contoh: 192.168.1.50): "
set /p "CUSTOM_MASK=Masukkan Subnet Mask (contoh: 255.255.255.0): "
set /p "CUSTOM_GW=Masukkan Gateway     (contoh: 192.168.1.1 atau kosong): "
set /p "CUSTOM_DNS=Masukkan DNS Server  (contoh: 8.8.8.8 atau kosong): "

if "%CUSTOM_GW%"=="" (
    netsh interface ipv4 set address name="%ADAPTER_NAME%" static %CUSTOM_IP% %CUSTOM_MASK% none >nul 2>&1
) else (
    netsh interface ipv4 set address name="%ADAPTER_NAME%" static %CUSTOM_IP% %CUSTOM_MASK% %CUSTOM_GW% 1 >nul 2>&1
)

if not "%CUSTOM_DNS%"=="" (
    netsh interface ipv4 set dnsservers name="%ADAPTER_NAME%" static %CUSTOM_DNS% primary >nul 2>&1
)
color 0A
echo.
echo [BERHASIL] Konfigurasi IP Manual berhasil diterapkan!
echo.
pause
goto MENU
