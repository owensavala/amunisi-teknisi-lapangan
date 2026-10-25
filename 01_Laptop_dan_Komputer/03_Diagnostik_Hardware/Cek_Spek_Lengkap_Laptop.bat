@echo off
title Cek Spesifikasi Lengkap Laptop & Komputer (Teknisi Tool)
color 1F

echo ========================================================
echo        INFORMASI LENGKAP HARDWARE LAPTOP / KOMPUTER
echo ========================================================
echo (Mengambil data hardware langsung dari BIOS dan Motherboard...)
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$cs = Get-CimInstance Win32_ComputerSystem;" ^
    "$bios = Get-CimInstance Win32_BIOS;" ^
    "$cpu = Get-CimInstance Win32_Processor;" ^
    "$mem = Get-CimInstance Win32_PhysicalMemory;" ^
    "$disk = Get-PhysicalDisk -ErrorAction SilentlyContinue;" ^
    "$os = Get-CimInstance Win32_OperatingSystem;" ^
    "Write-Host '========================================================' -ForegroundColor Cyan;" ^
    "Write-Host 'MERK & MODEL   :' $cs.Manufacturer $cs.Model -ForegroundColor Yellow;" ^
    "Write-Host 'SERIAL NUMBER  :' $bios.SerialNumber -ForegroundColor Yellow;" ^
    "Write-Host 'VERSI BIOS     :' $bios.SMBIOSBIOSVersion 'Tanggal:' $bios.ReleaseDate.ToString('dd-MM-yyyy') -ForegroundColor White;" ^
    "Write-Host 'SISTEM OPERASI :' $os.Caption '(' $os.OSArchitecture ')' -ForegroundColor White;" ^
    "Write-Host '========================================================' -ForegroundColor Cyan;" ^
    "Write-Host 'PROSESOR (CPU) :' $cpu.Name -ForegroundColor Green;" ^
    "Write-Host 'JUMLAH CORE    :' $cpu.NumberOfCores 'Core /' $cpu.NumberOfLogicalProcessors 'Threads' -ForegroundColor Green;" ^
    "Write-Host '--------------------------------------------------------' -ForegroundColor Gray;" ^
    "$totalRAM = [math]::Round($cs.TotalPhysicalMemory / 1GB, 1);" ^
    "Write-Host 'TOTAL RAM      :' $totalRAM 'GB' -ForegroundColor Magenta;" ^
    "Write-Host 'SLOT RAM       :' $mem.Count 'Slot Keping Terpasang' -ForegroundColor Magenta;" ^
    "foreach ($m in $mem) { $gb = [math]::Round($m.Capacity / 1GB); Write-Host ('  * ' + $gb + ' GB ' + $m.PartNumber + ' @ ' + $m.Speed + ' MHz') -ForegroundColor Gray };" ^
    "Write-Host '--------------------------------------------------------' -ForegroundColor Gray;" ^
    "Write-Host 'PENYIMPANAN    :' -ForegroundColor Cyan;" ^
    "if ($disk) {" ^
    "    foreach ($d in $disk) { $dgb = [math]::Round($d.Size / 1GB); Write-Host ('  * ' + $d.FriendlyName + ' [' + $d.MediaType + '] : ' + $dgb + ' GB (Kondisi: ' + $d.HealthStatus + ')') -ForegroundColor White }" ^
    "} else {" ^
    "    Get-CimInstance Win32_DiskDrive | ForEach-Object { $dgb = [math]::Round($_.Size / 1GB); Write-Host ('  * ' + $_.Model + ' : ' + $dgb + ' GB') -ForegroundColor White }" ^
    "};" ^
    "Write-Host '========================================================' -ForegroundColor Cyan;"

echo.
pause
