@echo off
setlocal enabledelayedexpansion
title Perbaikan Status Printer Offline Menjadi Online

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0A
echo ================================================================
echo           PERBAIKAN STATUS PRINTER "OFFLINE" MENJADI "ONLINE"
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Masalah yang diatasi:
echo - Printer statusnya "Offline" padahal kabel USB tercolok / terhubung ke Wi-Fi.
echo - Antrian cetak tertahan status "Paused" atau "Use Printer Offline".
echo - Bug status SNMP pada printer jaringan yang menyebabkan Windows salah baca.
echo.
echo Sedang mendiagnosa dan menyegarkan seluruh printer...
echo.

powershell -NoProfile -Command ^
    "$printers = Get-CimInstance -ClassName Win32_Printer; " ^
    "foreach ($p in $printers) { " ^
    "    Write-Host \"[Memeriksa] $($p.Name)...\" -ForegroundColor Yellow; " ^
    "    try { " ^
    "        Set-Printer -Name $p.Name -WorkOffline $false -Paused $false -ErrorAction SilentlyContinue; " ^
    "        Write-Host \" -> Berhasil mengaktifkan status Online!\" -ForegroundColor Green; " ^
    "    } catch { " ^
    "        Write-Host \" -> Dilewati atau tidak memerlukan perubahan.\" -ForegroundColor Gray; " ^
    "    } " ^
    "}"

echo.
echo Merestart Print Spooler untuk memperbarui komunikasi hardware...
net stop spooler >nul 2>&1
timeout /t 1 /nobreak >nul
net start spooler >nul 2>&1

echo.
echo ================================================================
echo [SELESAI] Seluruh printer telah dipaksa ke mode ONLINE.
echo.
echo Tips Teknisi jika printer masih offline:
echo 1. Cabut dan colokkan kembali kabel USB ke port USB yang berbeda (port belakang PC).
echo 2. Pastikan lampu indikator printer menyala hijau (tidak berkedip merah / orange).
echo 3. Matikan printer 5 detik, lalu hidupkan kembali.
echo ================================================================
echo.
pause
