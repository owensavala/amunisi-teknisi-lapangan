@echo off
setlocal
cd /d "%~dp0"
set "ADB=%~dp0platform-tools\adb.exe"
set "FASTBOOT=%~dp0platform-tools\fastboot.exe"

title Multi-Tool Servis HP Android Teknisi (ADB dan Fastboot)
color 1F

:menu
cls
echo ========================================================
echo       TOOL SERVIS HP ANDROID TEKNISI (OFFLINE DAN FREE)
echo ========================================================
echo.
echo [ STATUS DAN DIAGNOSTIK ]
echo   1. Cek Perangkat Terhubung (Mode Normal / ADB)
echo   2. Cek Perangkat Terhubung (Mode Fastboot / Bootloader)
echo   3. Baca Informasi Lengkap HP (Merk, Model, Baterai, Versi OS)
echo.
echo [ REBOOT DAN MODE KHUSUS (Solusi Tombol HP Rusak) ]
echo   4. Reboot ke Recovery Mode (Tanpa Pencet Tombol Volume)
echo   5. Reboot ke Fastboot / Bootloader
echo   6. Reboot ke EDL Mode (Qualcomm 9008 untuk Flashing)
echo   7. Reboot Normal (Kembali ke Sistem Android)
echo.
echo [ PERBAIKAN, BACKUP DAN FITUR SPESIAL ]
echo   8. Hapus Kunci Sandi / Pola / PIN (Syarat: USB Debugging Aktif)
echo   9. Buka Pengaturan HP Langsung (Settings)
echo  10. Tampilkan Layar dan Kontrol HP di Laptop (Scrcpy)
echo  11. Backup Kilat Foto dan WhatsApp ke Laptop
echo  12. Pasang File Aplikasi APK ke HP
echo  13. Buka Terminal Perintah Manual (ADB Shell)
echo.
echo   0. Keluar
echo.
echo ========================================================
set /p "PIL=Pilih menu (0-13): "

if "%PIL%"=="1" goto :cek_adb
if "%PIL%"=="2" goto :cek_fastboot
if "%PIL%"=="3" goto :info_hp
if "%PIL%"=="4" goto :reboot_recovery
if "%PIL%"=="5" goto :reboot_fastboot
if "%PIL%"=="6" goto :reboot_edl
if "%PIL%"=="7" goto :reboot_system
if "%PIL%"=="8" goto :bypass_lock
if "%PIL%"=="9" goto :open_settings
if "%PIL%"=="10" goto :open_scrcpy
if "%PIL%"=="11" goto :open_backup
if "%PIL%"=="12" goto :open_apk
if "%PIL%"=="13" goto :adb_shell
if "%PIL%"=="0" exit /b
goto :menu

:cek_adb
cls
echo Memeriksa perangkat Android (Mode ADB)...
"%ADB%" devices
echo.
pause
goto :menu

:cek_fastboot
cls
echo Memeriksa perangkat Android (Mode Fastboot)...
"%FASTBOOT%" devices
echo.
pause
goto :menu

:info_hp
cls
echo ========================================================
echo              INFORMASI PERANGKAT ANDROID
echo ========================================================
echo.
echo Merk / Brand   :
"%ADB%" shell getprop ro.product.brand
echo Model Perangkat :
"%ADB%" shell getprop ro.product.model
echo Versi Android  :
"%ADB%" shell getprop ro.build.version.release
echo Tipe Prosesor  :
"%ADB%" shell getprop ro.product.cpu.abi
echo Status Baterai :
"%ADB%" shell dumpsys battery | findstr "level"
echo.
pause
goto :menu

:reboot_recovery
cls
echo Mengirim perintah reboot ke RECOVERY MODE...
"%ADB%" reboot recovery
echo Selesai. HP akan masuk ke menu recovery.
pause
goto :menu

:reboot_fastboot
cls
echo Mengirim perintah reboot ke FASTBOOT MODE...
"%ADB%" reboot bootloader
echo Selesai. HP akan masuk ke layar Fastboot / Download.
pause
goto :menu

:reboot_edl
cls
echo Mengirim perintah reboot ke EDL MODE (Qualcomm 9008)...
"%ADB%" reboot edl
echo Selesai.
pause
goto :menu

:reboot_system
cls
echo Mengirim perintah reboot kembali ke sistem normal...
"%ADB%" reboot
"%FASTBOOT%" reboot
echo Selesai.
pause
goto :menu

:bypass_lock
cls
echo ========================================================
echo    RESET KUNCI LAYAR (GESTURE.KEY / PASSWORD.KEY)
echo ========================================================
echo.
echo Menghapus database kunci pola dan password...
"%ADB%" shell rm /data/system/gesture.key >nul 2>&1
"%ADB%" shell rm /data/system/password.key >nul 2>&1
"%ADB%" shell rm /data/system/locksettings.db >nul 2>&1
"%ADB%" shell rm /data/system/locksettings.db-wal >nul 2>&1
"%ADB%" shell rm /data/system/locksettings.db-shm >nul 2>&1
echo.
echo Selesai. Silakan swipe atau masukkan pola sembarang untuk masuk!
pause
goto :menu

:open_settings
cls
echo Membuka aplikasi Pengaturan (Settings) di layar HP...
"%ADB%" shell am start -n com.android.settings/.Settings
echo Selesai.
pause
goto :menu

:open_scrcpy
call "%~dp0Layar_HP_Mirror_Scrcpy.bat"
goto :menu

:open_backup
call "%~dp0Backup_Data_HP_Kilat.bat"
goto :menu

:open_apk
call "%~dp0Pasang_APK_Otomatis.bat"
goto :menu

:adb_shell
cls
echo Membuka sesi interaktif ADB Shell (Ketik 'exit' untuk kembali):
"%ADB%" shell
goto :menu
