@echo off
setlocal enabledelayedexpansion
title Izinkan Ping Masuk Windows Firewall (ICMP Echo)

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
echo           IZINKAN PING MASUK PADA FIREWALL (ICMP ECHO)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Masalah yang diatasi:
echo - Komputer ini di-ping dari komputer lain hasilnya selalu "Request timed out".
echo - Server lab tidak bisa memantau apakah komputer klien masih hidup/mati.
echo.
echo PILIHAN TINDAKAN:
echo [1] IZINKAN PING (Buka aturan ICMPv4 dan ICMPv6 di Windows Firewall)
echo [2] BLOKIR KEMBALI PING (Mode Default Windows)
echo [3] Keluar
echo.
set /p "CHOICE=Masukkan nomor pilihan (1-3): "

if "%CHOICE%"=="1" goto ENABLE_PING
if "%CHOICE%"=="2" goto DISABLE_PING
if "%CHOICE%"=="3" exit /b
goto MENU

:ENABLE_PING
echo.
echo Membuka aturan inbound ICMP (Ping) di Windows Firewall...
netsh advfirewall firewall add rule name="Izinkan_ICMPv4_Ping_In" protocol=icmpv4:8,any dir=in action=allow >nul 2>&1
netsh advfirewall firewall add rule name="Izinkan_ICMPv6_Ping_In" protocol=icmpv6:128,any dir=in action=allow >nul 2>&1
color 0A
echo.
echo [SUKSES] Komputer ini sekarang dapat di-ping dari server atau perangkat lain!
echo.
pause
goto MENU

:DISABLE_PING
echo.
echo Menghapus aturan ICMP Ping...
netsh advfirewall firewall delete rule name="Izinkan_ICMPv4_Ping_In" >nul 2>&1
netsh advfirewall firewall delete rule name="Izinkan_ICMPv6_Ping_In" >nul 2>&1
color 0A
echo.
echo [SUKSES] Respon Ping telah dinonaktifkan kembali.
echo.
pause
goto MENU
