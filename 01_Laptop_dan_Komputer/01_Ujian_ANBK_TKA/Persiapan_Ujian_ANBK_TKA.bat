@echo off
title Persiapan dan Optimasi Lab Ujian (ANBK / TKA / CBT)
color 1F

echo ========================================================
echo     PERSIAPAN DAN OPTIMASI LAB UJIAN (ANBK / TKA / CBT)
echo ========================================================
echo.

:: ---------------------------------------------------------
:: 1. PEMBERSIHAN FILE SAMPAH DAN CACHE (BIAR ENTENG)
:: ---------------------------------------------------------
echo [1/7] Membersihkan file sampah (Temp dan Update Cache)...
del /q /f /s "%temp%\*.*" >nul 2>&1
del /q /f /s "C:\Windows\Temp\*.*" >nul 2>&1
net stop wuauserv >nul 2>&1
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*.*" >nul 2>&1
echo       -^> File sampah dan cache sisa update berhasil dibersihkan.
echo.

:: ---------------------------------------------------------
:: 2. MENCEGAH LAPTOP TIDUR / SLEEP SAAT UJIAN
:: ---------------------------------------------------------
echo [2/7] Mengatur daya agar laptop tidak mati atau sleep saat ujian...
powercfg /change standby-timeout-ac 0
powercfg /change monitor-timeout-ac 0
echo       -^> Pengaturan tidur dinonaktifkan (selama charger tercolok).
echo.

:: ---------------------------------------------------------
:: 3. SINKRONISASI JAM DAN WAKTU (MENCEGAH TOKEN GAGAL / ERROR SSL)
:: ---------------------------------------------------------
echo [3/7] Mengaktifkan sinkronisasi jam dan waktu internet...
sc config w32time start=auto >nul 2>&1
net start w32time >nul 2>&1
w32tm /resync /nowait >nul 2>&1
echo       -^> Layanan waktu Windows diaktifkan.
echo.

:: ---------------------------------------------------------
:: 4. MATIKAN TOTAL WINDOWS UPDATE (MENCEGAH EXAMBRO CLOSE)
:: ---------------------------------------------------------
echo [4/7] Mematikan dan mengunci Windows Update...
net stop wuauserv >nul 2>&1
sc config wuauserv start=disabled >nul 2>&1
net stop bits >nul 2>&1
sc config bits start=disabled >nul 2>&1
net stop dosvc >nul 2>&1
sc config dosvc start=disabled >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "SetDisableUXWUAccess" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /t REG_SZ /d "2099-12-31T23:59:59Z" /f >nul 2>&1
echo       -^> Windows Update berhasil dinonaktifkan dan dikunci.
echo.

:: ---------------------------------------------------------
:: 5. NONAKTIFKAN STARTUP TASK MANAGER & BACKGROUND APPS
:: ---------------------------------------------------------
echo [5/7] Menonaktifkan Startup Task Manager dan Background Apps...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "OneDrive" /t REG_BINARY /d 030000000000000000000000 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Teams" /t REG_BINARY /d 030000000000000000000000 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Spotify" /t REG_BINARY /d 030000000000000000000000 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Cortana" /t REG_BINARY /d 030000000000000000000000 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Skype" /t REG_BINARY /d 030000000000000000000000 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
echo       -^> Startup Task Manager dan Background Apps dinonaktifkan.
echo.

:: ---------------------------------------------------------
:: 6. PERBAIKAN DAN RESET WI-FI
:: ---------------------------------------------------------
echo [6/7] Memeriksa dan mereset tumpukan jaringan Wi-Fi...
sc config WlanSvc start=auto >nul 2>&1
net start WlanSvc >nul 2>&1
ipconfig /flushdns >nul 2>&1
netsh winsock reset >nul 2>&1
netsh int ip reset >nul 2>&1
echo       -^> Wi-Fi diaktifkan dan cache jaringan di-reset.
echo.

:: ---------------------------------------------------------
:: 7. PERBAIKAN DAN IZIN PRIVASI KAMERA
:: ---------------------------------------------------------
echo [7/7] Membuka izin Kamera dan mendeteksi ulang perangkat...
sc config FrameServer start=auto >nul 2>&1
net start FrameServer >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v "Value" /t REG_SZ /d "Allow" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v "Value" /t REG_SZ /d "Allow" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam\NonPackaged" /v "Value" /t REG_SZ /d "Allow" /f >nul 2>&1
pnputil /scan-devices >nul 2>&1
echo       -^> Izin kamera dibuka dan driver di-scan ulang.
echo.

echo ========================================================
echo        SEMUA PERSIAPAN UJIAN TELAH SELESAI!
echo ========================================================
echo.
echo Catatan untuk Proktor / Teknisi:
echo 1. Windows Defender dan Antivirus (Smadav) tidak bisa dimatikan via script karena proteksi Microsoft (Tamper Protection).
echo 2. Jika kamera belum tampil di laptop Dell, aktifkan di BIOS (tekan F2 saat nyala -^> Enable Camera).
echo 3. Charger laptop wajib terpasang selama pelaksanaan ujian.
echo.
pause
