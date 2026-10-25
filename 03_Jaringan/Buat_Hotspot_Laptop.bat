@echo off
setlocal enabledelayedexpansion
title Buat Hotspot Wi-Fi Virtual dari Laptop

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
echo           BUAT HOTSPOT WI-FI VIRTUAL DARI LAPTOP
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini memancarkan sinyal Wi-Fi langsung dari kartu wireless laptop
echo sehingga perangkat lain (HP, tablet, laptop siswa) bisa terhubung.
echo.
echo PILIHAN TINDAKAN:
echo [1] NYALAKAN Hotspot (Konfigurasi Nama Wi-Fi dan Sandi)
echo [2] MATIKAN Hotspot Wi-Fi
echo [3] CEK STATUS Hotspot dan Perangkat yang Terhubung
echo [4] Keluar
echo.
set /p "CHOICE=Masukkan pilihan (1-4): "

if "%CHOICE%"=="1" goto START_HOTSPOT
if "%CHOICE%"=="2" goto STOP_HOTSPOT
if "%CHOICE%"=="3" goto STATUS_HOTSPOT
if "%CHOICE%"=="4" exit /b
goto MENU

:START_HOTSPOT
echo.
set /p "SSID_NAME=Masukkan Nama Wi-Fi Hotspot (SSID): "
if "%SSID_NAME%"=="" set "SSID_NAME=Hotspot_Teknisi"

set /p "HOTSPOT_KEY=Masukkan Kata Sandi (Minimal 8 Karakter): "
if "%HOTSPOT_KEY%"=="" set "HOTSPOT_KEY=teknisi12345"

echo.
echo Mengatur konfigurasi Hotspot Virtual...
netsh wlan set hostednetwork mode=allow ssid="%SSID_NAME%" key="%HOTSPOT_KEY%" >nul 2>&1
echo Menyalakan pancaran Wi-Fi...
netsh wlan start hostednetwork >nul 2>&1

color 0A
echo.
echo ================================================================
echo [BERHASIL] Hotspot Wi-Fi Laptop Telah Aktif!
echo Nama Wi-Fi : %SSID_NAME%
echo Kata Sandi : %HOTSPOT_KEY%
echo.
echo * Catatan: Untuk berbagi internet dari kabel LAN, buka
echo   "Network Connections", klik kanan adapter LAN -> Properties ->
echo   tab Sharing -> Centang "Allow other network users to connect".
echo ================================================================
echo.
pause
goto MENU

:STOP_HOTSPOT
echo.
echo Mematikan Hotspot Virtual...
netsh wlan stop hostednetwork >nul 2>&1
color 0A
echo [SUKSES] Hotspot berhasil dimatikan.
echo.
pause
goto MENU

:STATUS_HOTSPOT
cls
echo ================================================================
echo STATUS HOTSPOT DAN PERANGKAT TERHUBUNG:
echo ================================================================
echo.
netsh wlan show hostednetwork
echo.
pause
goto MENU
