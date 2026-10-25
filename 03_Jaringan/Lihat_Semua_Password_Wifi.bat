@echo off
setlocal enabledelayedexpansion
title Cek Sandi Wi-Fi Tersimpan di Laptop
color 1F

echo ========================================================
echo       DAFTAR PASSWORD WI-FI YANG TERSIMPAN DI LAPTOP
echo ========================================================
echo.

for /f "tokens=2 delims=:" %%a in ('netsh wlan show profiles ^| findstr /C:"All User Profile"') do (
    set "SSID=%%a"
    set "SSID=!SSID:~1!"
    set "KEY="
    for /f "tokens=2 delims=:" %%b in ('netsh wlan show profile name^="!SSID!" key^=clear ^| findstr /C:"Key Content"') do (
        set "KEY=%%b"
        set "KEY=!KEY:~1!"
    )
    if defined KEY (
        echo  [Wi-Fi] : !SSID!
        echo   -^> Sandi : !KEY!
        echo  ----------------------------------------------------
    ) else (
        echo  [Wi-Fi] : !SSID!
        echo   -^> Sandi : (Tidak ada sandi / Hotspot Terbuka)
        echo  ----------------------------------------------------
    )
)

echo.
echo ========================================================
echo.
pause
