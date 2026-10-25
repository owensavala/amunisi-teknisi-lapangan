@echo off
setlocal enabledelayedexpansion
title Diagnostik dan Cek Status Semua Printer

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0B
echo ================================================================
echo           DIAGNOSTIK DAN STATUS SEMUA PRINTER
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Sedang membaca status seluruh printer terinstal pada Windows...
echo.

powershell -NoProfile -Command ^
    "$printers = Get-CimInstance -ClassName Win32_Printer; " ^
    "if ($printers) { " ^
    "    $printers | Select-Object @{Name='Nama Printer';Expression={$_.Name}}, @{Name='Default';Expression={$_.Default}}, @{Name='Port';Expression={$_.PortName}}, @{Name='Driver';Expression={$_.DriverName}}, @{Name='Status';Expression={$_.PrinterStatus}}, @{Name='Antrian Dokumen';Expression={$_.JobCountSinceLastReset}} | Format-Table -AutoSize; " ^
    "} else { " ^
    "    Write-Host 'Tidak ada printer yang terinstal pada sistem ini!' -ForegroundColor Red; " ^
    "}"

echo.
echo ================================================================
echo KETERANGAN PORT PRINTER:
echo - USB001 / USB002 : Printer terhubung langsung lewat kabel USB.
echo - WSD-...         : Printer jaringan nirkabel/Wi-Fi (Web Services for Devices).
echo - IP_...          : Printer jaringan dengan IP Static / Standard TCP/IP.
echo ================================================================
echo.
pause
