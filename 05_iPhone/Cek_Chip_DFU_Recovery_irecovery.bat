@echo off
setlocal enabledelayedexpansion
title Diagnostik Mode DFU dan Recovery iPhone (iRecovery)

cd /d "%~dp0"

color 0E
echo ================================================================
echo       DIAGNOSTIK MODE DFU DAN RECOVERY IPHONE (iRecovery)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini digunakan ketika iPhone TIDAK BISA MASUK MENU (Bootloop):
echo - Layar menampilkan logo komputer / kabel lightning (Recovery Mode).
echo - Layar hitam pekat tetapi terdeteksi di PC (DFU Mode).
echo - Ingin membaca nomor ECID, Model Board, dan Tipe Chip Processor.
echo.
echo Sedang mendeteksi chip BootROM iPhone...
echo.

irecovery.exe -q

echo.
echo ================================================================
echo TINDAKAN LANJUTAN:
echo - Jika ingin KELUAR DARI RECOVERY LOOP (Kembali ke mode normal):
echo   Jalankan menu "Keluar dari Recovery Mode" pada Menu Servis iPhone.
echo - Jika ingin Flash ulang Firmware IPSW:
echo   Gunakan file firmware resmi yang sesuai dengan Model Board di atas.
echo ================================================================
echo.
pause
