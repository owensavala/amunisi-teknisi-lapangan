@echo off
setlocal enabledelayedexpansion
title Pengecek Port Jaringan dan Server Terbuka

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0B
echo ================================================================
echo           PENGECEK PORT JARINGAN DAN SERVER TERBUKA
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini menguji apakah port tertentu pada Server / Router / CBT
echo dalam kondisi TERBUKA (Listening) atau TERTUTUP (Blocked/Offline).
echo.
echo Masukkan ALAMAT IP TARGET yang ingin dicek:
echo (Contoh: 192.168.0.200 untuk Server ANBK, 192.168.1.1 untuk Router)
set /p "TARGET_HOST=IP Target: "

if "%TARGET_HOST%"=="" set "TARGET_HOST=192.168.0.200"

echo.
echo Masukkan NOMOR PORT yang ingin dicek:
echo [Umum: 80 (HTTP), 443 (HTTPS), 8088/8888 (Server Ujian), 3389 (RDP), 445 (Sharing)]
echo (Biarkan KOSONG untuk mengecek seluruh port penting di atas)
set /p "TARGET_PORT=Nomor Port: "

echo.
echo Sedang menguji koneksi ke %TARGET_HOST%...
echo.

if "%TARGET_PORT%"=="" (
    powershell -NoProfile -Command ^
        "$ports = @(80, 443, 8088, 8888, 3389, 445, 53, 8080); " ^
        "foreach ($p in $ports) { " ^
        "    $tcp = New-Object System.Net.Sockets.TcpClient; " ^
        "    $ar = $tcp.BeginConnect('$TARGET_HOST', $p, $null, $null); " ^
        "    $wait = $ar.AsyncWaitHandle.WaitOne(1000, $false); " ^
        "    if ($wait -and $tcp.Connected) { " ^
        "        $tcp.EndConnect($ar); " ^
        "        Write-Host \"[TERBUKA / OPEN] Port $p pada $TARGET_HOST AKTIF!\" -ForegroundColor Green; " ^
        "    } else { " ^
        "        Write-Host \"[TERTUTUP / CLOSED] Port $p pada $TARGET_HOST Tidak Merespon\" -ForegroundColor Gray; " ^
        "    } " ^
        "    $tcp.Close(); " ^
        "}"
) else (
    powershell -NoProfile -Command ^
        "$tcp = New-Object System.Net.Sockets.TcpClient; " ^
        "$ar = $tcp.BeginConnect('$TARGET_HOST', [int]$TARGET_PORT, $null, $null); " ^
        "$wait = $ar.AsyncWaitHandle.WaitOne(2000, $false); " ^
        "if ($wait -and $tcp.Connected) { " ^
        "    $tcp.EndConnect($ar); " ^
        "    Write-Host \"==================================================\" -ForegroundColor Green; " ^
        "    Write-Host \" [SUKSES] Port $TARGET_PORT pada $TARGET_HOST TERBUKA!\" -ForegroundColor Green; " ^
        "    Write-Host \" Layanan / aplikasi server siap diakses oleh klien.\" -ForegroundColor Yellow; " ^
        "    Write-Host \"==================================================\" -ForegroundColor Green; " ^
        "} else { " ^
        "    Write-Host \"==================================================\" -ForegroundColor Red; " ^
        "    Write-Host \" [GAGAL] Port $TARGET_PORT pada $TARGET_HOST TERTUTUP!\" -ForegroundColor Red; " ^
        "    Write-Host \" Kemungkinan: Server mati, Firewall memblokir, atau aplikasi server belum dijalankan.\" -ForegroundColor Gray; " ^
        "    Write-Host \"==================================================\" -ForegroundColor Red; " ^
        "} " ^
        "$tcp.Close();"
)

echo.
pause
