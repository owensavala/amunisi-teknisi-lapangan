@echo off
setlocal enabledelayedexpansion
title Reset Total Koneksi Internet dan TCP/IP Stack

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0B
echo ================================================================
echo           RESET TOTAL KONEKSI INTERNET DAN TCP/IP
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Masalah yang diatasi:
echo - Status "No Internet, Secured" padahal Wi-Fi / LAN normal.
echo - Muncul pesan "DNS Server isn't responding" atau web tidak bisa dibuka.
echo - Koneksi error setelah hapus antivirus atau terkena virus.
echo - IP Address bentrok (conflict) atau tidak mau dapat IP baru dari router.
echo.
echo Langkah perbaikan yang akan dieksekusi:
echo 1. Reset Winsock Catalog.
echo 2. Reset tumpukan protokol TCP/IP.
echo 3. Bersihkan DNS Cache (Flush DNS).
echo 4. Lepas dan minta kembali alamat IP baru (Release dan Renew IP).
echo 5. Restart service perutean jaringan lokal.
echo.
echo Tekan sembarang tombol untuk mulai...
pause >nul

echo.
echo [1/5] Mereset Winsock Catalog...
netsh winsock reset catalog >nul 2>&1

echo [2/5] Mereset tumpukan protokol TCP/IP...
netsh int ip reset >nul 2>&1
netsh int ipv6 reset >nul 2>&1

echo [3/5] Membersihkan DNS Cache...
ipconfig /flushdns >nul 2>&1

echo [4/5] Meminta penyegaran IP Address dari router...
ipconfig /release >nul 2>&1
timeout /t 2 /nobreak >nul
ipconfig /renew >nul 2>&1

echo [5/5] Mendaftarkan kembali konfigurasi DNS...
ipconfig /registerdns >nul 2>&1

echo.
echo ================================================================
echo [SUKSES] Seluruh tumpukan jaringan internet telah direset bersih!
echo.
echo CATATAN: Untuk efek perbaikan maksimal (terutama Winsock),
echo disarankan untuk me-RESTART laptop sekarang.
echo ================================================================
echo.
set /p "RESTART_NOW=Apakah ingin restart laptop sekarang? (Y/T): "
if /i "%RESTART_NOW%"=="Y" (
    echo Restart dalam 5 detik...
    shutdown /r /t 5
)
pause
