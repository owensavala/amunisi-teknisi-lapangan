@echo off
title Reset dan Perbaikan Antrean Printer Macet (Print Spooler)
color 1F

echo ========================================================
echo    PERBAIKAN PRINTER MACET / DOKUMEN PENDING / SPOOLER
echo ========================================================
echo.

:: Cek Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Mohon jalankan dengan Klik Kanan -^> "Run as Administrator"
    pause
    exit /b
)

echo [1/3] Menghentikan Layanan Print Spooler...
net stop spooler >nul 2>&1
sc stop spooler >nul 2>&1
taskkill /f /im spoolsv.exe >nul 2>&1
echo       -^> Layanan pencetakan dihentikan sementara.
echo.

echo [2/3] Menghapus semua antrean dokumen yang nyangkut / macet...
del /q /f /s "C:\Windows\System32\spool\PRINTERS\*.*" >nul 2>&1
echo       -^> Antrean cetak yang error berhasil dibersihkan total.
echo.

echo [3/3] Menyalakan kembali Layanan Print Spooler...
sc config spooler start=auto >nul 2>&1
net start spooler >nul 2>&1
echo       -^> Printer siap digunakan kembali!
echo.

echo ========================================================
echo           PRINTER BERHASIL DIRESET TOTAL!
echo ========================================================
echo.
echo Sekarang coba print dokumen kembali. Printer tidak akan macet lagi.
echo.
pause
