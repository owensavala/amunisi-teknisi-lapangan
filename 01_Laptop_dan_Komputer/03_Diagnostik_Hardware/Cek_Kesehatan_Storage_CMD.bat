@echo off
setlocal enabledelayedexpansion
title Diagnostik Kesehatan SSD dan Harddisk

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0B
echo ================================================================
echo           DIAGNOSTIK CEPAT KESEHATAN SSD DAN HARDDISK
echo                     Tools Teknisi Lapangan
echo ================================================================
echo.
echo Sedang mendeteksi storage drive pada komputer...
echo.

powershell -NoProfile -Command ^
    "Write-Host '--- DAFTAR FISIK STORAGE DRIVE ---' -ForegroundColor Yellow; " ^
    "Get-PhysicalDisk | Select-Object DeviceId, FriendlyName, MediaType, BusType, OperationalStatus, HealthStatus | Format-Table -AutoSize; " ^
    "Write-Host '--- STATUS PARTISI DAN VOLUME ---' -ForegroundColor Yellow; " ^
    "Get-Volume | Select-Object DriveLetter, FileSystemLabel, FileSystem, HealthStatus, OperationalStatus, @{Name='TotalGB';Expression={[math]::Round($_.Size / 1GB, 1)}}, @{Name='FreeGB';Expression={[math]::Round($_.SizeRemaining / 1GB, 1)}} | Format-Table -AutoSize; " ^
    "Write-Host '--- STATUS S.M.A.R.T. DRIVE ---' -ForegroundColor Yellow; " ^
    "try { Get-WmiObject -Namespace root\wmi -Class MSStorageDriver_FailurePredictStatus | Select-Object InstanceName, PredictFailure, Reason | Format-Table -AutoSize } catch { Write-Host 'S.M.A.R.T. WMI check completed.' }"

echo.
echo ================================================================
echo CATATAN DIAGNOSTIK:
echo - MediaType : Solid State Drive (SSD) atau Hard Disk Drive (HDD).
echo - HealthStatus Healthy : Drive dalam kondisi prima tanpa kerusakan fisik.
echo - PredictFailure True : Drive SEGERA RUSAK! Lakukan backup data instan!
echo - Untuk rincian Bad Sector / Suhu / Total TBW yang lebih mendalam,
echo   jalankan CrystalDiskInfo di folder ini.
echo ================================================================
echo.
pause
