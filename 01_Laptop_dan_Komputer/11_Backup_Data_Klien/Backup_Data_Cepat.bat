@echo off
title Backup Cepat Data Klien Sebelum Instal Ulang
color 1F

echo ========================================================
echo       BACKUP CEPAT DATA KLIEN SEBELUM INSTAL ULANG
echo ========================================================
echo.
echo User yang sedang aktif: %USERNAME%
echo Lokasi folder user: %USERPROFILE%
echo.

echo Pilih tempat penyimpanan hasil backup:
echo 1. Simpan di Drive D:\ (Folder D:\Backup_%USERNAME%)
echo 2. Simpan di Flashdisk / Harddisk Eksternal
echo.
set /p PILIHAN="Pilih nomor (1 atau 2): "

set DEST=
if "%PILIHAN%"=="1" (
    if not exist D:\ (
        echo [ERROR] Drive D:\ tidak ditemukan di komputer ini!
        pause
        exit /b
    )
    set DEST=D:\Backup_%USERNAME%
)

if "%PILIHAN%"=="2" (
    set /p EXTDRV="Masukkan huruf drive Flashdisk (misal E atau F): "
    set EXTDRV=!EXTDRV::=!
    set DEST=!EXTDRV!:\Backup_%USERNAME%
)

if "%DEST%"=="" (
    echo [ERROR] Pilihan tidak valid!
    pause
    exit /b
)

echo.
echo ========================================================
echo Target folder backup: %DEST%
echo ========================================================
echo.

if not exist "%DEST%" mkdir "%DEST%"

echo [1/4] Menyalin isi Desktop...
robocopy "%USERPROFILE%\Desktop" "%DEST%\Desktop" /E /R:1 /W:1 /MT:8 /XD "node_modules" >nul 2>&1
echo       -^> Selesai.

echo [2/4] Menyalin isi Dokumen (Documents)...
robocopy "%USERPROFILE%\Documents" "%DEST%\Documents" /E /R:1 /W:1 /MT:8 /XD "node_modules" >nul 2>&1
echo       -^> Selesai.

echo [3/4] Menyalin isi Downloads...
robocopy "%USERPROFILE%\Downloads" "%DEST%\Downloads" /E /R:1 /W:1 /MT:8 >nul 2>&1
echo       -^> Selesai.

echo [4/4] Menyalin isi Gambar (Pictures)...
robocopy "%USERPROFILE%\Pictures" "%DEST%\Pictures" /E /R:1 /W:1 /MT:8 >nul 2>&1
echo       -^> Selesai.

echo.
echo ========================================================
echo             BACKUP DATA TELAH SELESAI!
echo ========================================================
echo Semua data Desktop, Dokumen, Download, dan Gambar sudah aman di:
echo %DEST%
echo.
pause
