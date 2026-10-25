@echo off
setlocal enabledelayedexpansion
title Cek Serial Key Lisensi Bawaan Laptop dari BIOS

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0A
echo ================================================================
echo        CEK SERIAL KEY LISENSI BAWAAN LAPTOP DARI BIOS (OEM)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Sedang membaca chip BIOS motherboard laptop...
echo.

powershell -NoProfile -Command ^
    "$oemKey = (Get-CimInstance -ClassName SoftwareLicensingService).OA3xOriginalProductKey; " ^
    "if ($oemKey) { " ^
    "    Write-Host '==================================================' -ForegroundColor Green; " ^
    "    Write-Host ' [DITEMUKAN] SERIAL KEY ASLI BAWAAN PABRIK (BIOS):' -ForegroundColor Yellow; " ^
    "    Write-Host \" $oemKey\" -ForegroundColor Green; " ^
    "    Write-Host '==================================================' -ForegroundColor Green; " ^
    "    Write-Host 'Gunakan key di atas saat menginstall ulang Windows!' -ForegroundColor Cyan; " ^
    "} else { " ^
    "    Write-Host '[INFO] Tidak ditemukan Product Key tertanam di BIOS (MSDM).' -ForegroundColor Red; " ^
    "    Write-Host 'Kemungkinan perangkat ini adalah PC rakitan atau laptop DOS/tanpa OS bawaan pabrik.' -ForegroundColor Gray; " ^
    "}"

echo.
echo ----------------------------------------------------------------
echo Status Lisensi Windows yang Sedang Aktif Saat Ini:
echo ----------------------------------------------------------------
slmgr.vbs /dli
echo.
echo Masa Aktif Lisensi:
slmgr.vbs /xpr
echo.
pause
