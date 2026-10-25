@echo off
setlocal enabledelayedexpansion
title Kontrol Status Windows Update

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
echo           KONTROL ON / OFF WINDOWS UPDATE (PERMANEN)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini sangat berguna untuk:
echo - Mencegah laptop lab/sekolah menghabiskan kuota internet secara diam-diam.
echo - Mencegah Windows tiba-tiba restart sendiri saat siswa sedang ujian.
echo - Mengaktifkan kembali Windows Update kapan pun dibutuhkan.
echo.
echo PILIHAN TINDAKAN:
echo [1] MATIKAN Windows Update (Blokir Service dan Policy)
echo [2] NYALAKAN KEMBALI Windows Update (Kondisi Normal Pabrik)
echo [3] CEK STATUS Service Windows Update Saat Ini
echo [4] Keluar
echo.
set /p "CHOICE=Masukkan nomor pilihan (1-4): "

if "%CHOICE%"=="1" goto MATIKAN
if "%CHOICE%"=="2" goto NYALAKAN
if "%CHOICE%"=="3" goto CEK_STATUS
if "%CHOICE%"=="4" exit /b
goto MENU

:MATIKAN
cls
echo ================================================================
echo Sedang mematikan dan memblokir Windows Update...
echo ================================================================
echo.
echo 1. Menghentikan service Windows Update...
net stop wuauserv >nul 2>&1
sc config wuauserv start= disabled >nul 2>&1

echo 2. Menghentikan Update Orchestrator Service...
net stop UsoSvc >nul 2>&1
sc config UsoSvc start= disabled >nul 2>&1

echo 3. Menghentikan Windows Update Medic Service...
net stop WaaSMedicSvc >nul 2>&1
sc config WaaSMedicSvc start= disabled >nul 2>&1

echo 4. Memasang Registry Policy Anti-Update Otomatis...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul 2>&1

color 0A
echo.
echo [SUKSES] Windows Update telah dinonaktifkan secara total!
echo Komputer tidak akan lagi mengunduh pembaruan di latar belakang.
echo.
pause
goto MENU

:NYALAKAN
cls
echo ================================================================
echo Sedang mengembalikan Windows Update ke mode normal...
echo ================================================================
echo.
echo 1. Mengaktifkan konfigurasi service...
sc config wuauserv start= demand >nul 2>&1
sc config UsoSvc start= delayed-auto >nul 2>&1
sc config WaaSMedicSvc start= demand >nul 2>&1

echo 2. Menghapus batasan Registry Policy...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /f >nul 2>&1

echo 3. Memulai kembali service...
net start wuauserv >nul 2>&1
net start UsoSvc >nul 2>&1

color 0A
echo.
echo [SUKSES] Windows Update telah diaktifkan kembali ke pengaturan normal!
echo.
pause
goto MENU

:CEK_STATUS
cls
echo ================================================================
echo STATUS SERVICE WINDOWS UPDATE:
echo ================================================================
echo.
sc query wuauserv | findstr /i "STATE START_TYPE"
echo.
echo Keterangan:
echo - STOPPED / DISABLED : Update sedang mati.
echo - RUNNING / DEMAND   : Update aktif normal.
echo.
pause
goto MENU
