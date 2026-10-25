@echo off
setlocal enabledelayedexpansion
title Perbaikan Ikon Desktop Blank dan Rusak

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0A
echo ================================================================
echo           PERBAIKAN IKON DESKTOP BLANK DAN RUSAK
echo           (Rebuild Icon Cache dan Thumbnail Cache)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Masalah yang diatasi:
echo - Ikon aplikasi berubah jadi lembaran kertas putih polos.
echo - Ikon di taskbar / desktop hilang atau gambar tidak sesuai.
echo - Thumbnail preview gambar dan video tidak muncul.
echo.
echo Langkah perbaikan:
echo 1. Menghentikan proses Windows Explorer sementara.
echo 2. Menghapus database IconCache dan ThumbCache yang corrupt.
echo 3. Menghidupkan kembali Windows Explorer secara bersih.
echo.
echo Tekan sembarang tombol untuk memulai proses...
pause >nul

echo.
echo [1/4] Menghentikan Windows Explorer...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul

echo [2/4] Menghapus cache ikon lama...
attrib -h -r -s "%localappdata%\IconCache.db" >nul 2>&1
del /f /q "%localappdata%\IconCache.db" >nul 2>&1

attrib -h -r -s "%localappdata%\Microsoft\Windows\Explorer\iconcache*" >nul 2>&1
del /f /q "%localappdata%\Microsoft\Windows\Explorer\iconcache*" >nul 2>&1

attrib -h -r -s "%localappdata%\Microsoft\Windows\Explorer\thumbcache*" >nul 2>&1
del /f /q "%localappdata%\Microsoft\Windows\Explorer\thumbcache*" >nul 2>&1

echo [3/4] Membersihkan registry thumbnail cache...
reg delete "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v IconStreams /f >nul 2>&1
reg delete "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v PastIconsStream /f >nul 2>&1

echo [4/4] Menjalankan kembali Windows Explorer...
start explorer.exe

echo.
echo ================================================================
echo [SUKSES] Cache ikon berhasil diperbarui sepenuhnya!
echo Semua ikon desktop dan taskbar telah disegarkan kembali.
echo ================================================================
echo.
pause
