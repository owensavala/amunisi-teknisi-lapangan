@echo off
setlocal enabledelayedexpansion
title Pembersih Sampah dan File Sementara Windows

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0A
echo ================================================================
echo           PEMBERSIH SAMPAH MENDALAM (DEEP JUNK CLEANER)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini akan membersihkan:
echo 1. Folder Temp Pengguna (%%temp%%)
echo 2. Folder Temp Sistem Windows (C:\Windows\Temp)
echo 3. Windows Prefetch Cache
echo 4. Log Crash, Memory Dump, dan Windows Error Reporting
echo 5. Cache Delivery Optimization Windows Update
echo.
echo * Catatan: File pribadi di Dokumen, Unduhan, Desktop AMAN (tidak disentuh).
echo.
echo Tekan sembarang tombol untuk mulai membersihkan...
pause >nul

echo.
echo [1/5] Membersihkan Temp Pengguna...
del /s /f /q "%temp%\*.*" >nul 2>&1
for /d %%p in ("%temp%\*") do rmdir /s /q "%%p" >nul 2>&1

echo [2/5] Membersihkan Windows Temp Sistem...
del /s /f /q "%systemroot%\Temp\*.*" >nul 2>&1
for /d %%p in ("%systemroot%\Temp\*") do rmdir /s /q "%%p" >nul 2>&1

echo [3/5] Membersihkan Windows Prefetch...
del /s /f /q "%systemroot%\Prefetch\*.*" >nul 2>&1

echo [4/5] Membersihkan Crash Dump dan Error Reports...
del /s /f /q "%localappdata%\CrashDumps\*.*" >nul 2>&1
del /s /f /q "%systemroot%\Minidump\*.*" >nul 2>&1
if exist "%systemroot%\MEMORY.DMP" del /f /q "%systemroot%\MEMORY.DMP" >nul 2>&1

echo [5/5] Membersihkan Cache Delivery Optimization...
net stop dosvc >nul 2>&1
del /s /f /q "%systemroot%\SoftwareDistribution\DeliveryOptimization\*.*" >nul 2>&1
net start dosvc >nul 2>&1

echo.
echo ================================================================
echo [SUKSES] Seluruh file sampah dan cache berhasil dibersihkan!
echo Ruang penyimpanan drive sistem (C:) kini jauh lebih lega.
echo ================================================================
echo.
pause
