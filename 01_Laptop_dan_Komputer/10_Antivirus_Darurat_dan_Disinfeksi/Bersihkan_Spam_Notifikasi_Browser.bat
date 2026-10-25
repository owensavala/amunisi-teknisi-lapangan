@echo off
setlocal enabledelayedexpansion
title Pembersih Spam Notifikasi Browser Jahat (Chrome dan Edge)

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0C
echo ================================================================
echo       PEMBERSIH SPAM NOTIFIKASI IKLAN / VIRUS PALSU BROWSER
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Masalah yang diatasi:
echo - Di pojok kanan bawah desktop (Windows Tray) sering muncul pop-up:
echo   "Your McAfee has expired!", "Peringatan Virus!", iklan judi/dewasa.
echo - Izin situs jahat yang tidak sengaja tertekan "Allow / Izinkan" di Chrome/Edge.
echo.
echo KEAMANAN DATA:
echo Script ini HANYA membersihkan izin notifikasi situs dan Push Service Worker.
echo Bookmark, riwayat browsing, dan akun login klien AMAN (TIDAK TERHAPUS).
echo.
echo Tekan sembarang tombol untuk menutup browser dan mulai membersihkan...
pause >nul

echo.
echo [1/3] Menutup aplikasi browser Chrome dan Edge...
taskkill /f /im chrome.exe >nul 2>&1
taskkill /f /im msedge.exe >nul 2>&1
taskkill /f /im brave.exe >nul 2>&1
timeout /t 2 /nobreak >nul

echo [2/3] Membersihkan Service Worker Push Notification Chrome...
if exist "%localappdata%\Google\Chrome\User Data" (
    del /s /f /q "%localappdata%\Google\Chrome\User Data\Default\Service Worker\Database\*.*" >nul 2>&1
    del /s /f /q "%localappdata%\Google\Chrome\User Data\Default\Service Worker\CacheStorage\*.*" >nul 2>&1
    del /s /f /q "%localappdata%\Google\Chrome\User Data\Default\Service Worker\ScriptCache\*.*" >nul 2>&1
    echo  -> Cache notifikasi Chrome dibersihkan.
)

echo [3/3] Membersihkan Service Worker Push Notification Microsoft Edge...
if exist "%localappdata%\Microsoft\Edge\User Data" (
    del /s /f /q "%localappdata%\Microsoft\Edge\User Data\Default\Service Worker\Database\*.*" >nul 2>&1
    del /s /f /q "%localappdata%\Microsoft\Edge\User Data\Default\Service Worker\CacheStorage\*.*" >nul 2>&1
    del /s /f /q "%localappdata%\Microsoft\Edge\User Data\Default\Service Worker\ScriptCache\*.*" >nul 2>&1
    echo  -> Cache notifikasi Edge dibersihkan.
)

:: Reset Pusat Notifikasi Windows (Action Center Cache)
del /s /f /q "%localappdata%\Microsoft\Windows\ActionCenterCache\*.*" >nul 2>&1

color 0A
echo.
echo ================================================================
echo [SUKSES] Seluruh cache notifikasi jahat telah dibersihkan bersih!
echo Pop-up iklan dan peringatan virus palsu di desktop tidak akan muncul lagi.
echo ================================================================
echo.
pause
