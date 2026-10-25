@echo off
setlocal enabledelayedexpansion
title Kirim Perintah Cetak Halaman Uji Windows (Test Page)

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0A
echo ================================================================
echo           KIRIM HALAMAN TES CETAK (PRINT TEST PAGE)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini mengirim perintah halaman uji resmi Windows langsung ke printer
echo untuk membuktikan apakah komunikasi komputer ke printer sudah normal.
echo.
echo DAFTAR PRINTER YANG TERPASANG:
echo ----------------------------------------------------------------

powershell -NoProfile -Command ^
    "$printers = Get-CimInstance -ClassName Win32_Printer | Sort-Object Name; " ^
    "$i = 1; " ^
    "foreach ($p in $printers) { " ^
    "    $def = if ($p.Default) { ' [DEFAULT]' } else { '' }; " ^
    "    Write-Host \"[$i] $($p.Name)$def\" -ForegroundColor Cyan; " ^
    "    $i++; " ^
    "}"

echo ----------------------------------------------------------------
echo.
echo Ketik NAMA PRINTER persis seperti daftar di atas (atau salin namanya),
echo lalu tekan ENTER untuk mencetak:
echo (Kosongkan dan tekan ENTER untuk membatalkan)
echo.
set /p "TARGET_PRINTER=Nama Printer: "

if "%TARGET_PRINTER%"=="" (
    echo Dibatalkan.
    pause
    exit /b
)

echo.
echo Mengirim sinyal cetak halaman uji ke: "%TARGET_PRINTER%"...

powershell -NoProfile -Command ^
    "try { " ^
    "    $p = Get-WmiObject -Class Win32_Printer -Filter \"Name='$env:TARGET_PRINTER'\"; " ^
    "    if ($p) { " ^
    "        $result = $p.PrintTestPage(); " ^
    "        if ($result.ReturnValue -eq 0) { " ^
    "            Write-Host '[BERHASIL] Perintah Halaman Uji terkirim ke printer!' -ForegroundColor Green; " ^
    "            Write-Host 'Periksa kertas yang keluar dari printer.' -ForegroundColor Yellow; " ^
    "        } else { " ^
    "            Write-Host \"[GAGAL] Kode error: $($result.ReturnValue)\" -ForegroundColor Red; " ^
    "        } " ^
    "    } else { " ^
    "        Write-Host '[ERROR] Nama printer tidak cocok dengan sistem!' -ForegroundColor Red; " ^
    "    } " ^
    "} catch { " ^
    "    Write-Host \"[ERROR] Terjadi kendala: $_\" -ForegroundColor Red; " ^
    "}"

echo.
pause
