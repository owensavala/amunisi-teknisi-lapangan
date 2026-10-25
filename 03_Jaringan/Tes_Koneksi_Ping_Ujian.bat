@echo off
title Tes Kestabilan Koneksi & Ping Lab Ujian
color 1F

echo ========================================================
echo       MONITORING KESTABILAN KONEKSI JARINGAN LAB
echo ========================================================
echo.

echo Pilih target pengujian:
echo 1. Tes Ping ke Internet (Google 8.8.8.8)
echo 2. Tes Ping ke Gateway Router Lab
echo 3. Tes Ping ke IP Server Lokal (Misal VHD ANBK / TKA)
echo.
set /p PILIHAN="Pilih nomor (1, 2, atau 3): "

set TARGET=8.8.8.8
if "%PILIHAN%"=="1" set TARGET=8.8.8.8

if "%PILIHAN%"=="2" (
    for /f "tokens=3" %%i in ('route print ^| findstr "\<0.0.0.0\>"') do (
        set TARGET=%%i
        goto :startping
    )
)

if "%PILIHAN%"=="3" (
    set /p TARGET="Masukkan IP Server Ujian (misal 192.168.0.200): "
)

:startping
echo.
echo ========================================================
echo Memulai tes ping kontinu ke: %TARGET%
echo (Tekan Ctrl + C di keyboard jika ingin menghentikan tes)
echo.
echo Panduan Teknisi:
echo - Waktu < 20ms : Sangat Bagus untuk Ujian!
echo - Waktu 50-100ms : Cukup Stabil
echo - Request timed out (RTO) : Jaringan Terputus / Kabel Bermasalah!
echo ========================================================
echo.

ping %TARGET% -t
