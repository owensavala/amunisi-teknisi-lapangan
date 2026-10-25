@echo off
setlocal enabledelayedexpansion
title Paksa Hapus File atau Folder Bandel Terkunci

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0C
echo ================================================================
echo           PAKSA HAPUS FILE ATAU FOLDER BANDEL / TERKUNCI
echo                 (Take Ownership and Force Delete)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini digunakan untuk menghapus file atau folder yang:
echo - Menolak dihapus ("Access Denied" / "Butuh Izin dari SYSTEM").
echo - Sisa uninstall aplikasi atau file virus yang membandel.
echo - File dengan atribut tersembunyi/sistem yang terkunci.
echo.
echo PENTING: Jangan gunakan untuk menghapus folder inti Windows
echo          seperti C:\Windows atau C:\Program Files sistem!
echo.
echo Silakan DRAG and DROP (Tarik dan Lepas) file atau folder yang ingin
echo dihapus ke dalam jendela ini, lalu tekan ENTER:
echo.
set /p "TARGET_PATH=Target: "

:: Hapus tanda petik jika ada
set "TARGET_PATH=%TARGET_PATH:"=%"

if "%TARGET_PATH%"=="" (
    echo.
    echo Tidak ada jalur yang dimasukkan! Pembatalan.
    pause
    exit /b
)

if not exist "%TARGET_PATH%" (
    echo.
    echo Target "%TARGET_PATH%" tidak ditemukan!
    pause
    exit /b
)

echo.
echo Menyiapkan proses penghapusan untuk:
echo %TARGET_PATH%
echo.
echo Mengambil alih hak kepemilikan (Take Ownership)...
if exist "%TARGET_PATH%\*" (
    :: Folder
    takeown /f "%TARGET_PATH%" /r /d y >nul 2>&1
    icacls "%TARGET_PATH%" /grant administrators:F /t /c >nul 2>&1
    attrib -r -s -h "%TARGET_PATH%\*.*" /s /d >nul 2>&1
    echo Menghapus seluruh isi folder...
    rmdir /s /q "%TARGET_PATH%" >nul 2>&1
) else (
    :: File
    takeown /f "%TARGET_PATH%" >nul 2>&1
    icacls "%TARGET_PATH%" /grant administrators:F >nul 2>&1
    attrib -r -s -h "%TARGET_PATH%" >nul 2>&1
    echo Menghapus file...
    del /f /q /a "%TARGET_PATH%" >nul 2>&1
)

if not exist "%TARGET_PATH%" (
    color 0A
    echo.
    echo ================================================================
    echo [BERHASIL] File/Folder bandel berhasil dihapus secara permanen!
    echo ================================================================
) else (
    echo.
    echo ================================================================
    echo [PERINGATAN] File/Folder masih ada. Kemungkinan file tersebut sedang
    echo aktif dipakai oleh proses aplikasi atau Service latar belakang.
    echo Solusi: Jalankan via Safe Mode atau tutup aplikasi yang memakainya.
    echo ================================================================
)

echo.
pause
