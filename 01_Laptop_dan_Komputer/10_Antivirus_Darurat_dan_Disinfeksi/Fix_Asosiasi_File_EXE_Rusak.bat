@echo off
setlocal enabledelayedexpansion
title Perbaikan Asosiasi File EXE yang Rusak Akibat Virus

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0A
echo ================================================================
echo           PERBAIKAN ASOSIASI FILE EXE (TIDAK BISA BUKA APLIKASI)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Masalah yang diatasi:
echo - Semua file .exe tidak bisa dibuka setelah terinfeksi virus Expiro / Sality.
echo - Mengklik aplikasi malah memunculkan dialog "Open With..." atau Notepad.
echo - Muncul pesan "The application was unable to start correctly".
echo.
echo Menerapkan perbaikan asosiasi berkas eksekutabel...
echo.

assoc .exe=exefile >nul 2>&1
ftype exefile="%1" %* >nul 2>&1

reg import "%~dp0Fix_Asosiasi_File_EXE_Rusak.reg" >nul 2>&1

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.exe\UserChoice" /f >nul 2>&1

echo [SUKSES] Pengaturan asosiasi file .EXE telah dikembalikan ke standar Windows!
echo Sekarang coba klik 2x aplikasi apa pun.
echo.
pause
