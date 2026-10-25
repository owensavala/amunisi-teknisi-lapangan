@echo off
title Kembalikan Tombol Kemudahan Akses Asli
color 1F

echo ========================================================
echo    MENGEMBALIKAN SISTEM UTILMAN KE KONDISI NORMAL
echo ========================================================
echo.

set WINDRV=
if exist C:\Windows\System32\utilman.bak set WINDRV=C:
if exist D:\Windows\System32\utilman.bak set WINDRV=D:

if "%WINDRV%"=="" (
    echo [INFO] File backup utilman.bak tidak ditemukan atau sistem sudah normal.
    pause
    exit /b
)

echo Mengembalikan file utilman asli di %WINDRV%...
copy /y %WINDRV%\Windows\System32\utilman.bak %WINDRV%\Windows\System32\utilman.exe >nul 2>&1
del /q %WINDRV%\Windows\System32\utilman.bak >nul 2>&1

echo.
echo ========================================================
echo         SISTEM SUDAH KEMBALI NORMAL SEPERTI ASLI!
echo ========================================================
echo.
pause
