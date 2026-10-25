# ===============================================================================
# PENGUNDUH TOOLS PENDUKUNG RESMI - AMUNISI TEKNISI LAPANGAN
# Author: Muh. Sattar Barakati (Owen)
# ===============================================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "Pengunduh Otomatis Tools Pendukung Teknisi"

$BaseDir = $PSScriptRoot

function Write-Header {
    Clear-Host
    Write-Host "==================================================================" -ForegroundColor Cyan
    Write-Host "      PENGUNDUH OTOMATIS TOOLS PENDUKUNG RESMI TEKNISI LAPANGAN" -ForegroundColor Green
    Write-Host "             Repositori Aman & Bebas Lisensi Pihak Ketiga" -ForegroundColor Yellow
    Write-Host "==================================================================" -ForegroundColor Cyan
    Write-Host ""
}

function Download-And-Extract {
    param (
        [string]$Name,
        [string]$Url,
        [string]$TargetFolder,
        [string]$ZipName
    )
    Write-Host "[*] Mengunduh $Name dari sumber resmi..." -ForegroundColor Yellow
    Write-Host "    URL: $Url" -ForegroundColor DarkGray
    
    $TempZip = Join-Path $env:TEMP $ZipName
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri $Url -OutFile $TempZip -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" -UseBasicParsing
        
        if (!(Test-Path $TargetFolder)) {
            New-Item -ItemType Directory -Path $TargetFolder -Force | Out-Null
        }
        
        Write-Host "[*] Mengekstrak $Name ke: $TargetFolder..." -ForegroundColor Cyan
        Expand-Archive -Path $TempZip -DestinationPath $TargetFolder -Force
        
        # Jika hasil ekstraksi bersarang di subfolder dengan nama sama, pindahkan ke root target
        $SubDirs = Get-ChildItem -Path $TargetFolder -Directory
        if ($SubDirs.Count -eq 1) {
            $InnerDir = $SubDirs[0].FullName
            Get-ChildItem -Path $InnerDir | Move-Item -Destination $TargetFolder -Force
            Remove-Item -Path $InnerDir -Recurse -Force -ErrorAction SilentlyContinue
        }

        Remove-Item $TempZip -Force -ErrorAction SilentlyContinue
        Write-Host "[SUKSES] $Name berhasil dipasang!" -ForegroundColor Green
    }
    catch {
        Write-Host "[GAGAL] Tidak dapat mengunduh $Name. Pesan: $_" -ForegroundColor Red
        Write-Host "Silakan unduh manual melalui browser Anda." -ForegroundColor Yellow
    }
}

function Download-AdwCleaner {
    $TargetFolder = Join-Path $BaseDir "01_Laptop_dan_Komputer\10_Antivirus_Darurat_dan_Disinfeksi"
    $TargetExe = Join-Path $TargetFolder "AdwCleaner.exe"
    Write-Host "[*] Mengunduh Malwarebytes AdwCleaner resmi..." -ForegroundColor Yellow
    $Url = "https://downloads.malwarebytes.com/file/adwcleaner"
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri $Url -OutFile $TargetExe -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" -UseBasicParsing
        Write-Host "[SUKSES] AdwCleaner.exe berhasil dipasang di $TargetExe!" -ForegroundColor Green
    }
    catch {
        Write-Host "[GAGAL] Tidak dapat mengunduh AdwCleaner: $_" -ForegroundColor Red
    }
}

function Download-PlatformTools {
    $Target = Join-Path $BaseDir "04_Android\platform-tools"
    Download-And-Extract -Name "Google Android Platform-Tools (ADB & Fastboot)" `
        -Url "https://dl.google.com/android/repository/platform-tools-latest-windows.zip" `
        -TargetFolder $Target `
        -ZipName "platform-tools.zip"
}

function Download-Scrcpy {
    $Target = Join-Path $BaseDir "04_Android\scrcpy\scrcpy-win64-v5.0.1"
    # Query latest GitHub release for scrcpy win64 zip
    Write-Host "[*] Mencari versi rilis terbaru Scrcpy di GitHub..." -ForegroundColor Cyan
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13
        $ApiUrl = "https://api.github.com/repos/Genymobile/scrcpy/releases/latest"
        $Release = Invoke-RestMethod -Uri $ApiUrl -Headers @{ "User-Agent" = "PowerShell-Installer" }
        $Asset = $Release.assets | Where-Object { $_.name -match "scrcpy-win64.*\.zip" } | Select-Object -First 1
        if ($Asset) {
            Download-And-Extract -Name "Scrcpy ($($Release.tag_name))" `
                -Url $Asset.browser_download_url `
                -TargetFolder $Target `
                -ZipName "scrcpy.zip"
            return
        }
    }
    catch {
        Write-Host "[INFO] GitHub API limit, menggunakan URL unduhan fallback..." -ForegroundColor DarkYellow
    }
    
    # Fallback direct download
    Download-And-Extract -Name "Scrcpy (Win64)" `
        -Url "https://github.com/Genymobile/scrcpy/releases/download/v3.1/scrcpy-win64-v3.1.zip" `
        -TargetFolder $Target `
        -ZipName "scrcpy.zip"
}

function Download-CrystalDiskInfo {
    $Target = Join-Path $BaseDir "01_Laptop_dan_Komputer\03_Diagnostik_Hardware\CrystalDiskInfo"
    Download-And-Extract -Name "CrystalDiskInfo Portable" `
        -Url "https://sourceforge.net/projects/crystaldiskinfo/files/latest/download" `
        -TargetFolder $Target `
        -ZipName "CrystalDiskInfo.zip"
}

do {
    Write-Header
    Write-Host "Pilih nomor tool yang ingin diunduh secara otomatis:" -ForegroundColor White
    Write-Host " [1] Unduh SEMUA Tools Lengkap (Scrcpy + ADB + CrystalDiskInfo + AdwCleaner)" -ForegroundColor Green
    Write-Host " [2] Unduh Scrcpy Portable (Screen Mirroring Android Layar Pecah)" -ForegroundColor Cyan
    Write-Host " [3] Unduh Google Android Platform-Tools (ADB & Fastboot)" -ForegroundColor Cyan
    Write-Host " [4] Unduh CrystalDiskInfo Portable (Cek Kesehatan SSD / HDD)" -ForegroundColor Cyan
    Write-Host " [5] Unduh Malwarebytes AdwCleaner Resmi (Pembersih Adware/Virus)" -ForegroundColor Cyan
    Write-Host " [6] Buka Tautan Resmi Ventoy Multiboot (Browser)" -ForegroundColor Yellow
    Write-Host " [7] Buka Tautan Resmi libimobiledevice iOS Diagnostics (Browser)" -ForegroundColor Yellow
    Write-Host " [0] Keluar" -ForegroundColor Gray
    Write-Host ""
    $Choice = Read-Host "Masukkan pilihan (0-7)"

    switch ($Choice) {
        "1" {
            Write-Host "`n=== MEMULAI PENGUNDUHAN SEMUA TOOLS ===" -ForegroundColor Magenta
            Download-PlatformTools
            Download-Scrcpy
            Download-CrystalDiskInfo
            Download-AdwCleaner
            Write-Host "`nSemua tools pendukung berhasil diproses!" -ForegroundColor Green
            Pause
        }
        "2" {
            Download-Scrcpy
            Pause
        }
        "3" {
            Download-PlatformTools
            Pause
        }
        "4" {
            Download-CrystalDiskInfo
            Pause
        }
        "5" {
            Download-AdwCleaner
            Pause
        }
        "6" {
            Start-Process "https://www.ventoy.net/en/download.html"
            Write-Host "[INFO] Membuka halaman unduh Ventoy di browser..." -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        "7" {
            Start-Process "https://github.com/libimobiledevice/libimobiledevice"
            Write-Host "[INFO] Membuka repositori resmi libimobiledevice di browser..." -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        "0" {
            Write-Host "Keluar dari installer." -ForegroundColor Gray
            break
        }
    }
} while ($Choice -ne "0")
