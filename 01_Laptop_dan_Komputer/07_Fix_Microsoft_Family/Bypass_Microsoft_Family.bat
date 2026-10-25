@echo off
title Buka Kunci Microsoft Family / Parental Controls
color 1F

echo ========================================================
echo    MEMBUKA KUNCI MICROSOFT FAMILY / PARENTAL CONTROLS
echo ========================================================
echo.

:: ---------------------------------------------------------
:: 1. HENTIKAN DAN MATIKAN SERVICE PARENTAL CONTROLS
:: ---------------------------------------------------------
echo [1/4] Mematikan Service Parental Controls (WpcMonSvc)...
net stop WpcMonSvc >nul 2>&1
sc config WpcMonSvc start=disabled >nul 2>&1
taskkill /f /im wpcmon.exe >nul 2>&1
taskkill /f /im wpc.exe >nul 2>&1
echo       -^> Layanan pembatasan Family Safety dinonaktifkan.
echo.

:: ---------------------------------------------------------
:: 2. HAPUS CACHE & PENGATURAN BLOKIR FAMILY SAFETY
:: ---------------------------------------------------------
echo [2/4] Menghapus file cache dan setelan blokir...
del /q /f /s "C:\ProgramData\Microsoft\Windows\Parental Controls\*.*" >nul 2>&1
echo       -^> Cache pembatasan berhasil dibersihkan.
echo.

:: ---------------------------------------------------------
:: 3. RESET REGISTRI PARENTAL CONTROLS
:: ---------------------------------------------------------
echo [3/4] Mereset registri pembatasan aplikasi...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Parental Controls" /v "Users" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Parental Controls" /v "Disabled" /t REG_DWORD /d 1 /f >nul 2>&1
echo       -^> Pengaturan registri Family Safety dinonaktifkan.
echo.

:: ---------------------------------------------------------
:: 4. MEMBUAT / MENGAKTIFKAN AKUN ADMIN CADANGAN (JIKA TERKUNCI TOTAL)
:: ---------------------------------------------------------
echo [4/4] Mengaktifkan akun Administrator lokal...
net user Administrator /active:yes >nul 2>&1
echo       -^> Akun Administrator bawaan telah diaktifkan.
echo.

echo ========================================================
echo        PROSES BYPASS SELESAI!
echo ========================================================
echo.
echo LANGKAH PENTING SELANJUTNYA (Lepas Akun Siswa):
echo 1. Buka Settings (tekan tombol Windows + I).
echo 2. Masuk ke menu "Accounts" (Akun) -^> "Your info" (Info Anda).
echo 3. Klik tulisan: "Sign in with a local account instead"
echo    (Masuk dengan akun lokal sebagai gantinya).
echo 4. Ikuti langkahnya, kosongkan password jika tidak mau pakai sandi.
echo 5. Begitu akun berubah jadi Akun Lokal, Microsoft Family Safety
echo    AKAN HILANG 100%% SELAMANYA!
echo.
pause
