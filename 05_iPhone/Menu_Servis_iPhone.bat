@echo off
setlocal
cd /d "%~dp0"

title Multi-Tool Servis iPhone dan iOS Teknisi (Free dan Standalone)
color 1F

:menu
cls
echo ========================================================
echo       TOOL SERVIS IPHONE / IOS TEKNISI (STANDALONE)
echo ========================================================
echo (Catatan: Pastikan kabel data iPhone tercolok ke laptop)
echo.
echo [ DIAGNOSTIK DAN INFORMASI ]
echo   1. Cek iPhone Terhubung dan Baca Info Lengkap
echo      (Tipe, Model, Seri, Versi iOS, IMEI, Serial Number)
echo   2. Cek Kesehatan Baterai iPhone (Cycle Count dan Kondisi)
echo   3. Cek Status Aktivasi dan iCloud iPhone
echo   4. Pasangkan Perangkat / Pair (Trust This Computer)
echo.
echo [ RECOVERY, BOOTLOOP DAN HARDWARE ]
echo   5. KELUAR DARI RECOVERY MODE (Solusi Nyangkut di Logo iTunes/Kabel)
echo   6. Masuk ke Recovery Mode (Tanpa Tombol Fisik)
echo   7. Diagnosa Chip Mode DFU / Recovery (iRecovery Query)
echo   8. Tarik Crash Log Panic Full (Diagnosa iPhone Restart Tiap 3 Menit)
echo.
echo [ MANAJEMEN DAN KONTROL PERANGKAT ]
echo   9. Ambil Screenshot Layar iPhone ke Desktop
echo  10. Backup Penuh iPhone ke Desktop (Tanpa iTunes)
echo  11. Restart / Reboot iPhone
echo  12. Matikan / Shutdown iPhone Bersih Lewat PC
echo.
echo   0. Keluar
echo.
echo ========================================================
set /p "PIL=Pilih menu (0-12): "

if "%PIL%"=="1" goto :info_iphone
if "%PIL%"=="2" goto :baterai_iphone
if "%PIL%"=="3" goto :aktivasi_iphone
if "%PIL%"=="4" goto :pair_iphone
if "%PIL%"=="5" goto :exit_recovery
if "%PIL%"=="6" goto :enter_recovery
if "%PIL%"=="7" goto :query_irecovery
if "%PIL%"=="8" goto :panic_log
if "%PIL%"=="9" goto :screenshot_iphone
if "%PIL%"=="10" goto :backup_iphone
if "%PIL%"=="11" goto :restart_iphone
if "%PIL%"=="12" goto :shutdown_iphone
if "%PIL%"=="0" exit /b
goto :menu

:info_iphone
cls
echo ========================================================
echo               INFORMASI LENGKAP IPHONE
echo ========================================================
echo.
ideviceinfo.exe | findstr /C:"DeviceName" /C:"ProductType" /C:"ProductVersion" /C:"SerialNumber" /C:"UniqueDeviceID" /C:"InternationalMobileEquipmentIdentity"
echo.
pause
goto :menu

:baterai_iphone
cls
echo ========================================================
echo             KESEHATAN BATERAI IPHONE (CYCLE COUNT)
echo ========================================================
echo.
echo Membaca sensor baterai iPhone...
echo.
ideviceinfo.exe -q com.apple.mobile.battery
echo.
echo Panduan Teknisi:
echo - CycleCount: Jumlah berapa kali baterai dicas dari 0-100%%.
echo - Jika CycleCount di atas 500-800 kali, kapasitas baterai sudah turun drastis.
echo.
pause
goto :menu

:aktivasi_iphone
cls
echo ========================================================
echo             STATUS AKTIVASI DAN ICLOUD IPHONE
echo ========================================================
echo.
ideviceactivation.exe state
echo.
echo Keterangan:
echo - Activated         : iPhone normal siap pakai.
echo - Unactivated       : iPhone baru atau baru saja di-restore/reset pabrik.
echo - FactoryActivated  : Aktivasi bypass pabrikan.
echo.
pause
goto :menu

:pair_iphone
cls
echo Memasangkan koneksi laptop dengan iPhone...
echo (Lihat layar iPhone, klik 'Percayai / Trust This Computer' jika muncul)
echo.
idevicepair.exe pair
echo.
pause
goto :menu

:exit_recovery
cls
echo ========================================================
echo        MEMAKSA IPHONE KELUAR DARI RECOVERY MODE
echo ========================================================
echo (Solusi iPhone macet di logo iTunes / kabel / restore)
echo.
irecovery.exe -n
echo.
echo Selesai. Jika berhasil, iPhone akan otomatis restart ke menu normal.
pause
goto :menu

:enter_recovery
cls
echo Mengirim perintah agar iPhone masuk ke Recovery Mode...
ideviceenterrecovery.exe
pause
goto :menu

:query_irecovery
call "%~dp0Cek_Chip_DFU_Recovery_irecovery.bat"
goto :menu

:panic_log
call "%~dp0Tarik_Crash_Log_Panic_Full.bat"
goto :menu

:screenshot_iphone
call "%~dp0Ambil_Screenshot_iPhone.bat"
goto :menu

:backup_iphone
cls
echo ========================================================
echo         BACKUP LENGKAP IPHONE KE DESKTOP (OFFLINE)
echo ========================================================
echo.
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set "TGL=%%a-%%b-%%c"
set "IPHONE_BACKUP_DIR=%USERPROFILE%\Desktop\Backup_iPhone_%TGL%"
echo Folder tujuan: %IPHONE_BACKUP_DIR%
echo.
echo Proses ini membutuhkan waktu beberapa menit sesuai kapasitas data...
idevicebackup2.exe backup "%IPHONE_BACKUP_DIR%"
echo.
echo Selesai!
pause
goto :menu

:restart_iphone
cls
echo Merestart iPhone...
idevicediagnostics.exe restart
pause
goto :menu

:shutdown_iphone
cls
echo Mematikan iPhone secara aman...
idevicediagnostics.exe shutdown
pause
goto :menu
