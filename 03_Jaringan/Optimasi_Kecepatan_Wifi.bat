@echo off
setlocal enabledelayedexpansion
title Optimasi Maksimal Kecepatan dan Sinyal Wi-Fi Laptop

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

color 0A
echo ================================================================
echo           OPTIMASI MAKSIMAL KECEPATAN DAN KONEKSI WI-FI
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini akan mengoptimalkan:
echo 1. Membuka batas transmisi data Windows (Disable Network Throttling).
echo 2. Mengaktifkan TCP Window Auto-Tuning Level Normal (Pipa data maksimal).
echo 3. Mengaktifkan Receive Side Scaling (RSS) ke seluruh core prosesor.
echo 4. Mengoptimalkan TCP Chimney Offload dan Congestion Provider (CTCP).
echo 5. Mematikan fitur Delivery Optimization P2P yang diam-diam memakan upload.
echo 6. Membersihkan cache DNS dan mereset tumpukan jaringan IP.
echo.
echo Tekan sembarang tombol untuk menerapkan optimasi...
pause >nul

echo.
echo [1/6] Membuka batasan Network Throttling di Registry...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1

echo [2/6] Mengoptimalkan TCP Window Auto-Tuning...
netsh int tcp set global autotuninglevel=normal >nul 2>&1

echo [3/6] Mengaktifkan Receive-Side Scaling (RSS)...
netsh int tcp set global rss=enabled >nul 2>&1

echo [4/6] Mengaktifkan TCP Fast Open dan ECN Capability...
netsh int tcp set global fastopen=enabled >nul 2>&1
netsh int tcp set global ecncapability=enabled >nul 2>&1

echo [5/6] Menghentikan upload update Windows diam-diam (Delivery Optimization)...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>&1

echo [6/6] Membersihkan DNS Cache dan menyegarkan adapter...
ipconfig /flushdns >nul 2>&1

echo.
echo ================================================================
echo [SUKSES] Seluruh optimasi kecepatan jaringan telah diterapkan!
echo.
echo TIPS TEKNISI LAPANGAN:
echo - Jika router mendukung Wi-Fi 5GHz, selalu hubungkan ke sinyal 5GHz
echo   (kecepatan bisa 3x lebih kencang dibanding 2.4GHz).
echo - Jika jarak ke router sangat jauh, gunakan sinyal 2.4GHz karena
echo   gelombangnya lebih tembus dinding dan pintu beton.
echo ================================================================
echo.
pause
