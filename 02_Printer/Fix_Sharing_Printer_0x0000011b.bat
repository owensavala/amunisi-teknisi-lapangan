@echo off
setlocal enabledelayedexpansion
title Solusi Error Sharing Printer 0x0000011b dan 0x00000709

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
echo       SOLUSI ERROR SHARING PRINTER 0x0000011b / 0x00000709
echo              (Perbaikan Koneksi Printer Jaringan Lab/Kantor)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Masalah yang diatasi:
echo - Laptop klien tidak bisa terhubung ke printer sharing di jaringan.
echo - Muncul kode error: 0x0000011b, 0x00000709, atau 0x0000007c.
echo - Masalah ini terjadi akibat update keamanan Windows (RPC Over Named Pipes).
echo.
echo PILIH PERAN KOMPUTER INI:
echo [1] PASANG PERBAIKAN PADA KOMPUTER SERVER (Komputer yang dicolok kabel USB printer)
echo [2] PASANG PERBAIKAN PADA LAPTOP / KOMPUTER KLIEN (Komputer yang numpang print)
echo [3] TERAPKAN PADA KEDUA MODE SEKALIGUS (Rekomendasi)
echo [4] Keluar
echo.
set /p "MODE=Masukkan pilihan (1-4): "

if "%MODE%"=="1" goto FIX_SERVER
if "%MODE%"=="2" goto FIX_CLIENT
if "%MODE%"=="3" goto FIX_BOTH
if "%MODE%"=="4" exit /b
goto MENU

:FIX_SERVER
echo.
echo [SERVER] Mengatur konfigurasi RpcAuthnLevelEx pada Print Server...
reg add "HKLM\System\CurrentControlSet\Control\Print" /v RpcAuthnLevelEx /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f >nul 2>&1
echo [SERVER] Merestart Print Spooler...
net stop spooler >nul 2>&1
net start spooler >nul 2>&1
color 0A
echo.
echo [SUKSES] Pengaturan Komputer Server berhasil diperbarui!
echo Silakan coba sambungkan kembali printer dari laptop klien.
echo.
pause
goto MENU

:FIX_CLIENT
echo.
echo [KLIEN] Membuka batasan instalasi driver printer Point and Print...
reg add "HKLM\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows NT\Printers" /v ForceKerberosForRpc /t REG_DWORD /d 0 /f >nul 2>&1
echo [KLIEN] Merestart Print Spooler...
net stop spooler >nul 2>&1
net start spooler >nul 2>&1
color 0A
echo.
echo [SUKSES] Pengaturan Laptop Klien berhasil diperbarui!
echo.
pause
goto MENU

:FIX_BOTH
echo.
echo Menerapkan perbaikan menyeluruh (Server + Klien)...
reg add "HKLM\System\CurrentControlSet\Control\Print" /v RpcAuthnLevelEx /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows NT\Printers" /v ForceKerberosForRpc /t REG_DWORD /d 0 /f >nul 2>&1
echo Merestart Print Spooler...
net stop spooler >nul 2>&1
net start spooler >nul 2>&1
color 0A
echo.
echo ================================================================
echo [SUKSES] Perbaikan Registry Sharing Printer selesai diterapkan!
echo Spooler telah direstart.
echo ================================================================
echo.
pause
goto MENU
