@echo off
setlocal enabledelayedexpansion
title Penampil dan Pengendali Layar HP Android (Scrcpy)

set "SCRCPY_EXE=%~dp0scrcpy\scrcpy-win64-v5.0.1\scrcpy.exe"
if not exist "%SCRCPY_EXE%" (
    where scrcpy >nul 2>&1
    if !errorlevel! equ 0 set "SCRCPY_EXE=scrcpy"
)

:MENU
cls
color 0B
echo ================================================================
echo        PENAMPIL DAN PENGENDALI LAYAR HP ANDROID (SCRCPY)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat penyelamat teknisi jika HP klien mengalami:
echo - Layar sentuh (touchscreen) pecah / retak / tidak bisa disentuh.
echo - Ingin backup chat WhatsApp atau buka galeri dari laptop.
echo - Mengoperasikan HP sepenuhnya menggunakan Mouse dan Keyboard PC.
echo.
echo Syarat: HP harus terhubung via kabel USB dengan USB Debugging aktif.
echo.
echo PILIHAN MODE:
echo [1] TAMPILKAN LAYAR HP (Kontrol Penuh Mouse dan Keyboard - Normal)
echo [2] TAMPILKAN LAYAR + MATIKAN LAYAR FISIK HP (Layar HP gelap, hemat baterai)
echo [3] REKAM LAYAR HP KE FILE VIDEO MP4 (Tersimpan di Desktop)
echo [4] MODE KONTROL OTG (Kendali Tanpa Video - Hemat Resource)
echo [5] Keluar
echo.
set /p "CHOICE=Masukkan nomor pilihan (1-5): "

if "%CHOICE%"=="1" goto MODE_NORMAL
if "%CHOICE%"=="2" goto MODE_OFF_SCREEN
if "%CHOICE%"=="3" goto MODE_RECORD
if "%CHOICE%"=="4" goto MODE_OTG
if "%CHOICE%"=="5" exit /b
goto MENU

:MODE_NORMAL
call :VERIFY_SCRCPY
cls
echo Menjalankan Scrcpy Mirroring...
echo Tips: Klik kiri = Sentuh, Klik kanan = Tombol Back, Scroll = Geser.
echo.
start "" "%SCRCPY_EXE%" --window-title "Layar HP Android Teknisi"
goto MENU

:MODE_OFF_SCREEN
call :VERIFY_SCRCPY
cls
echo Menjalankan Scrcpy dengan layar fisik HP dimatikan...
echo.
start "" "%SCRCPY_EXE%" --turn-screen-off --stay-awake --window-title "Layar HP Android (Layar Fisik Mati)"
goto MENU

:MODE_RECORD
call :VERIFY_SCRCPY
cls
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set "TGL=%%a-%%b-%%c"
set "REC_PATH=%USERPROFILE%\Desktop\Rekaman_HP_%TGL%_%random%.mp4"
echo Sedang merekam layar HP ke:
echo %REC_PATH%
echo.
echo (Tutup jendela scrcpy untuk menghentikan rekaman video)
echo.
"%SCRCPY_EXE%" --record "%REC_PATH%"
echo.
echo [SUKSES] Rekaman video tersimpan di Desktop!
pause
goto MENU

:MODE_OTG
call :VERIFY_SCRCPY
cls
echo Menjalankan Mode OTG Keyboard dan Mouse...
echo.
"%SCRCPY_EXE%" --otg
pause
goto MENU

:VERIFY_SCRCPY
if not exist "%SCRCPY_EXE%" if not "%SCRCPY_EXE%"=="scrcpy" (
    echo.
    echo [PERINGATAN] Executable scrcpy.exe belum ditemukan!
    echo Silakan jalankan 'UNDUH_TOOLS_PENDUKUNG.bat' di folder utama untuk mengunduh otomatis,
    echo atau unduh manual dari: https://github.com/Genymobile/scrcpy/releases
    echo.
    pause
    goto MENU
)
exit /b
