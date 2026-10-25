@echo off
setlocal enabledelayedexpansion
title Reset Komponen Windows Update yang Macet

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0E
echo ================================================================
echo           RESET KOMPONEN WINDOWS UPDATE YANG MACET
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Masalah yang diatasi:
echo - Windows Update stuck / macet di 0%%, 99%%, atau download gagal.
echo - Muncul error update seperti 0x80070002, 0x80240034, 0x80070422.
echo - File installer update corrupt di dalam penyimpanan.
echo.
echo Peringatan: Proses ini akan mereset riwayat update dan membersihkan
echo folder SoftwareDistribution. File pribadi TIDAK akan terhapus.
echo.
echo Tekan sembarang tombol untuk memulai proses perbaikan...
pause >nul

echo.
echo [1/5] Menghentikan Service Windows Update dan BITS...
net stop wuauserv >nul 2>&1
net stop cryptSvc >nul 2>&1
net stop bits >nul 2>&1
net stop msiserver >nul 2>&1

echo [2/5] Menghapus folder unduhan update yang corrupt (SoftwareDistribution)...
if exist "%systemroot%\SoftwareDistribution.bak" (
    rmdir /s /q "%systemroot%\SoftwareDistribution.bak" >nul 2>&1
)
ren "%systemroot%\SoftwareDistribution" "SoftwareDistribution.bak" >nul 2>&1

if exist "%systemroot%\system32\catroot2.bak" (
    rmdir /s /q "%systemroot%\system32\catroot2.bak" >nul 2>&1
)
ren "%systemroot%\system32\catroot2" "catroot2.bak" >nul 2>&1

echo [3/5] Mereset konfigurasi Winsock dan antrian jaringan...
netsh winsock reset >nul 2>&1
netsh winhttp reset proxy >nul 2>&1

echo [4/5] Mendaftarkan ulang pustaka DLL Windows Update...
for %%s in (atl.dll urlmon.dll mshtml.dll shdocvw.dll browseui.dll jscript.dll vbscript.dll scrrun.dll msxml.dll msxml3.dll msxml6.dll actxprxy.dll softpub.dll wintrust.dll dssenh.dll rsaenh.dll gpkcsp.dll sccbase.dll slbcsp.dll cryptdlg.dll oleaut32.dll ole32.dll shell32.dll initpki.dll wuapi.dll wuaueng.dll wuaueng1.dll prxyprxy.dll wucltui.dll wups.dll wups2.dll wuweb.dll qmgr.dll qmgrprxy.dll wucltux.dll muweb.dll wuwebv.dll) do (
    regsvr32.exe /s %%s >nul 2>&1
)

echo [5/5] Menghidupkan kembali Service Windows Update...
net start msiserver >nul 2>&1
net start bits >nul 2>&1
net start cryptSvc >nul 2>&1
net start wuauserv >nul 2>&1

echo.
echo ================================================================
echo [SUKSES] Komponen Windows Update berhasil direset sepenuhnya!
echo Silakan buka Windows Update di Settings dan klik 'Check for updates'.
echo ================================================================
echo.
pause
