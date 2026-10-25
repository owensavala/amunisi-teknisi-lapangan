@echo off
setlocal enabledelayedexpansion
title KONSOL PUSAT TEKNISI LAPANGAN (MULTI-TOOLKIT V1.0)

REM Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta izin Administrator...
    powershell -Command "Start-Process cmd -ArgumentList '/k \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

set "ROOT=%~dp0"

:MAIN_MENU
cls
color 1F
set "M_CHOICE="
echo ===============================================================================
echo            KONSOL PUSAT AMUNISI TEKNISI LAPANGAN (ALL-IN-ONE)
echo            Offline - Mandiri - Bebas Lisensi Berbayar - Siap Tugas
echo ===============================================================================
echo.
echo   [1] KATEGORI 01: LAPTOP DAN KOMPUTER (Diagnostik, Windows Fix, Tweak, Driver)
echo   [2] KATEGORI 02: PRINTER (Spooler, Sharing 0x11b, Offline Fix, Nozzle Test)
echo   [3] KATEGORI 03: JARINGAN (IP Switcher ANBK, Wi-Fi Booster, Scanner, Sharing)
echo   [4] KATEGORI 04: SERVIS ANDROID (Scrcpy Layar Rusak, Fastboot, Backup, Driver)
echo   [5] KATEGORI 05: SERVIS IPHONE (Panic Log 3 Menit, Keluar Recovery, Baterai)
echo   [6] DARURAT VIRUS DAN RECYCLER (Expiro Fix, Buka TaskMgr, Recycler Base64)
echo.
echo   [7] BUKA BUKU SOP DAN PANDUAN LENGKAP LAPANGAN (File Teks)
echo   [8] BUKA FOLDER TOOLKIT DI WINDOWS EXPLORER
echo   [9] UNDUH TOOLS PENDUKUNG RESMI (Scrcpy, CrystalDiskInfo, ADB, AdwCleaner)
echo.
echo   [0] KELUAR
echo.
echo ===============================================================================
set /p "M_CHOICE=Pilih nomor kategori (0-9): "

if "%M_CHOICE%"=="1" goto MENU_LAPTOP
if "%M_CHOICE%"=="2" goto MENU_PRINTER
if "%M_CHOICE%"=="3" goto MENU_JARINGAN
if "%M_CHOICE%"=="4" goto MENU_ANDROID
if "%M_CHOICE%"=="5" goto MENU_IPHONE
if "%M_CHOICE%"=="6" goto MENU_VIRUS
if "%M_CHOICE%"=="7" goto OPEN_SOP
if "%M_CHOICE%"=="8" goto OPEN_EXPLORER
if "%M_CHOICE%"=="9" goto DOWNLOAD_TOOLS
if "%M_CHOICE%"=="0" exit /b
goto MAIN_MENU

REM ===============================================================================
REM SUBMENU 1: LAPTOP DAN KOMPUTER
REM ===============================================================================
:MENU_LAPTOP
cls
color 0B
set "L_CHOICE="
echo ===============================================================================
echo                      KATEGORI 01: LAPTOP DAN KOMPUTER
echo ===============================================================================
echo.
echo   [1] Cek Kesehatan Storage SSD / HDD (CrystalDiskInfo Portable)
echo   [2] Tes Layar LCD dan Dead Pixel (Full-screen HTML Tester)
echo   [3] Tes Tombol Keyboard Laptop Rusak / Lengket (Offline HTML)
echo   [4] Buat Laporan Kesehatan Baterai Laptop (HTML Report ke Desktop)
echo   [5] Cek Serial Number BIOS, Model Laptop, dan Slot RAM
echo   [6] Cek Lisensi Windows Bawaan Laptop dari Chip BIOS (MSDM Key)
echo.
echo   [7] Perbaikan Ikon Desktop Blank / Kertas Putih Polos
echo   [8] Reset Windows Update yang Macet / Error
echo   [9] Kontrol Saklar Windows Update (Matikan / Nyalakan)
echo  [10] Pembersih Sampah Mendalam (Temp, Prefetch, Dump Crash)
echo  [11] Paksa Hapus File / Folder Terkunci (Take Ownership)
echo  [12] Bypass Batasan Windows 11 (TPM 2.0, Secure Boot, CPU Jadul)
echo  [13] Perbaikan File Sistem Windows Rusak (SFC dan DISM Otomatis)
echo  [14] Backup Semua Driver Laptop / Restore Driver Offline
echo  [15] Masuk / Keluar Safe Mode Windows (1-Klik)
echo.
echo   [0] Kembali ke Menu Utama
echo ===============================================================================
set /p "L_CHOICE=Pilih nomor tool (0-15): "

if "%L_CHOICE%"=="1" goto RUN_L1
if "%L_CHOICE%"=="2" goto RUN_L2
if "%L_CHOICE%"=="3" goto RUN_L3
if "%L_CHOICE%"=="4" goto RUN_L4
if "%L_CHOICE%"=="5" goto RUN_L5
if "%L_CHOICE%"=="6" goto RUN_L6
if "%L_CHOICE%"=="7" goto RUN_L7
if "%L_CHOICE%"=="8" goto RUN_L8
if "%L_CHOICE%"=="9" goto RUN_L9
if "%L_CHOICE%"=="10" goto RUN_L10
if "%L_CHOICE%"=="11" goto RUN_L11
if "%L_CHOICE%"=="12" goto RUN_L12
if "%L_CHOICE%"=="13" goto RUN_L13
if "%L_CHOICE%"=="14" goto RUN_L14
if "%L_CHOICE%"=="15" goto RUN_L15
if "%L_CHOICE%"=="0" goto MAIN_MENU
goto MENU_LAPTOP

:RUN_L1
if exist "%ROOT%01_Laptop_dan_Komputer\03_Diagnostik_Hardware\CrystalDiskInfo\DiskInfo64.exe" (
    start "" "%ROOT%01_Laptop_dan_Komputer\03_Diagnostik_Hardware\CrystalDiskInfo\DiskInfo64.exe"
) else (
    echo.
    echo [INFO] CrystalDiskInfo Portable belum diunduh.
    echo Menjalankan diagnostik Storage bawaan Windows (WMIC / PowerShell)...
    echo.
    call "%ROOT%01_Laptop_dan_Komputer\03_Diagnostik_Hardware\Cek_Kesehatan_Storage_CMD.bat"
)
goto MENU_LAPTOP

:RUN_L2
start "" "%ROOT%01_Laptop_dan_Komputer\03_Diagnostik_Hardware\Tes_Layar_LCD_DeadPixel_Offline.html"
goto MENU_LAPTOP

:RUN_L3
start "" "%ROOT%01_Laptop_dan_Komputer\03_Diagnostik_Hardware\Tes_Keyboard_Offline.html"
goto MENU_LAPTOP

:RUN_L4
call "%ROOT%01_Laptop_dan_Komputer\03_Diagnostik_Hardware\Generate_Laporan_Baterai.bat"
goto MENU_LAPTOP

:RUN_L5
call "%ROOT%01_Laptop_dan_Komputer\03_Diagnostik_Hardware\Cek_Spek_Lengkap_Laptop.bat"
goto MENU_LAPTOP

:RUN_L6
call "%ROOT%01_Laptop_dan_Komputer\04_Aktivasi_Resmi_MAS\Cek_Serial_Key_Bawaan_Laptop_BIOS.bat"
goto MENU_LAPTOP

:RUN_L7
call "%ROOT%01_Laptop_dan_Komputer\14_Tweak_Windows_Driver\Perbaikan_Icon_Blank_Putih.bat"
goto MENU_LAPTOP

:RUN_L8
call "%ROOT%01_Laptop_dan_Komputer\14_Tweak_Windows_Driver\Reset_Windows_Update_Macet.bat"
goto MENU_LAPTOP

:RUN_L9
call "%ROOT%01_Laptop_dan_Komputer\14_Tweak_Windows_Driver\Kontrol_Windows_Update.bat"
goto MENU_LAPTOP

:RUN_L10
call "%ROOT%01_Laptop_dan_Komputer\14_Tweak_Windows_Driver\Pembersih_Sampah_Windows_Temp.bat"
goto MENU_LAPTOP

:RUN_L11
call "%ROOT%01_Laptop_dan_Komputer\14_Tweak_Windows_Driver\Paksa_Hapus_File_Folder_Terkunci.bat"
goto MENU_LAPTOP

:RUN_L12
call "%ROOT%01_Laptop_dan_Komputer\14_Tweak_Windows_Driver\Bypass_Syarat_Windows_11_TPM_CPU.bat"
goto MENU_LAPTOP

:RUN_L13
call "%ROOT%01_Laptop_dan_Komputer\14_Tweak_Windows_Driver\Perbaikan_Windows_Rusak_SFC_DISM.bat"
goto MENU_LAPTOP

:RUN_L14
call "%ROOT%01_Laptop_dan_Komputer\14_Tweak_Windows_Driver\Backup_Semua_Driver_Laptop.bat"
goto MENU_LAPTOP

:RUN_L15
call "%ROOT%01_Laptop_dan_Komputer\14_Tweak_Windows_Driver\Masuk_Safe_Mode.bat"
goto MENU_LAPTOP

REM ===============================================================================
REM SUBMENU 2: PRINTER
REM ===============================================================================
:MENU_PRINTER
cls
color 0E
set "P_CHOICE="
echo ===============================================================================
echo                           KATEGORI 02: PRINTER
echo ===============================================================================
echo.
echo   [1] Fix Error Sharing Printer Jaringan (0x0000011b / 0x00000709)
echo   [2] Paksa Printer Offline Menjadi Online (Reset WorkOffline)
echo   [3] Reset Print Spooler (Hapus Dokumen Nyangkut / Macet)
echo   [4] Kirim Perintah Cetak Halaman Uji Resmi (Windows Test Page)
echo   [5] Bersihkan Driver Printer Lama / Corrupt (Print Server Properties)
echo   [6] Cetak Halaman Tes Warna dan Nozzle Head CMYK (HTML)
echo   [7] Buka Panduan Servis dan Reset Bantalan Tinta Epson/Canon
echo.
echo   [0] Kembali ke Menu Utama
echo ===============================================================================
set /p "P_CHOICE=Pilih nomor tool (0-7): "

if "%P_CHOICE%"=="1" goto RUN_P1
if "%P_CHOICE%"=="2" goto RUN_P2
if "%P_CHOICE%"=="3" goto RUN_P3
if "%P_CHOICE%"=="4" goto RUN_P4
if "%P_CHOICE%"=="5" goto RUN_P5
if "%P_CHOICE%"=="6" goto RUN_P6
if "%P_CHOICE%"=="7" goto RUN_P7
if "%P_CHOICE%"=="0" goto MAIN_MENU
goto MENU_PRINTER

:RUN_P1
call "%ROOT%02_Printer\Fix_Sharing_Printer_0x0000011b.bat"
goto MENU_PRINTER

:RUN_P2
call "%ROOT%02_Printer\Perbaikan_Printer_Offline.bat"
goto MENU_PRINTER

:RUN_P3
call "%ROOT%02_Printer\Reset_Print_Spooler.bat"
goto MENU_PRINTER

:RUN_P4
call "%ROOT%02_Printer\Kirim_Halaman_Tes_Cetak.bat"
goto MENU_PRINTER

:RUN_P5
call "%ROOT%02_Printer\Bersihkan_Driver_Printer_Lama.bat"
goto MENU_PRINTER

:RUN_P6
start "" "%ROOT%02_Printer\Cetak_Tes_Warna_Nozzle.html"
goto MENU_PRINTER

:RUN_P7
notepad "%ROOT%02_Printer\PANDUAN_RESET_DAN_SERVIS_PRINTER.txt"
goto MENU_PRINTER

REM ===============================================================================
REM SUBMENU 3: JARINGAN
REM ===============================================================================
:MENU_JARINGAN
cls
color 0A
set "N_CHOICE="
echo ===============================================================================
echo                           KATEGORI 03: JARINGAN
echo ===============================================================================
echo.
echo   [1] Pengatur Cepat IP Address (Static Ujian ANBK / DHCP Otomatis)
echo   [2] Optimasi Maksimal Kecepatan Wi-Fi (Disable Throttling & TCP Tuning)
echo   [3] Aktifkan Network Sharing dan Discovery (Buka Akses Folder Lab)
echo   [4] Izinkan Ping Masuk Windows Firewall (Buka Blokir ICMP)
echo   [5] Pengecek Port Jaringan Server (Uji Port 80, 8088 CBT, 445 SMB)
echo   [6] Lihat Semua Kata Sandi Wi-Fi Tersimpan di Laptop
echo   [7] Buat Hotspot Wi-Fi Virtual dari Laptop
echo   [8] Scan Daftar Seluruh IP dan MAC Address di Jaringan Lab
echo   [9] Tes Kestabilan Koneksi Ping Ujian (Monitoring RTO)
echo.
echo   [0] Kembali ke Menu Utama
echo ===============================================================================
set /p "N_CHOICE=Pilih nomor tool (0-9): "

if "%N_CHOICE%"=="1" goto RUN_N1
if "%N_CHOICE%"=="2" goto RUN_N2
if "%N_CHOICE%"=="3" goto RUN_N3
if "%N_CHOICE%"=="4" goto RUN_N4
if "%N_CHOICE%"=="5" goto RUN_N5
if "%N_CHOICE%"=="6" goto RUN_N6
if "%N_CHOICE%"=="7" goto RUN_N7
if "%N_CHOICE%"=="8" goto RUN_N8
if "%N_CHOICE%"=="9" goto RUN_N9
if "%N_CHOICE%"=="0" goto MAIN_MENU
goto MENU_JARINGAN

:RUN_N1
call "%ROOT%03_Jaringan\Atur_IP_Address_Static_DHCP.bat"
goto MENU_JARINGAN

:RUN_N2
call "%ROOT%03_Jaringan\Optimasi_Kecepatan_Wifi.bat"
goto MENU_JARINGAN

:RUN_N3
call "%ROOT%03_Jaringan\Aktifkan_Network_Sharing_Folder.bat"
goto MENU_JARINGAN

:RUN_N4
call "%ROOT%03_Jaringan\Izinkan_Ping_Masuk_Firewall.bat"
goto MENU_JARINGAN

:RUN_N5
call "%ROOT%03_Jaringan\Cek_Port_Jaringan_Server.bat"
goto MENU_JARINGAN

:RUN_N6
call "%ROOT%03_Jaringan\Lihat_Semua_Password_Wifi.bat"
goto MENU_JARINGAN

:RUN_N7
call "%ROOT%03_Jaringan\Buat_Hotspot_Laptop.bat"
goto MENU_JARINGAN

:RUN_N8
call "%ROOT%03_Jaringan\Scan_IP_Komputer_Lab.bat"
goto MENU_JARINGAN

:RUN_N9
call "%ROOT%03_Jaringan\Tes_Koneksi_Ping_Ujian.bat"
goto MENU_JARINGAN

REM ===============================================================================
REM SUBMENU 4: SERVIS ANDROID
REM ===============================================================================
:MENU_ANDROID
cls
color 1E
set "A_CHOICE="
echo ===============================================================================
echo                        KATEGORI 04: SERVIS ANDROID
echo ===============================================================================
echo.
echo   [1] Buka Dashboard Servis HP Android Multi-Tool
echo   [2] Tampilkan dan Kontrol Layar HP di Laptop (Scrcpy - Penyelamat Layar Pecah)
echo   [3] Fastboot Toolkit (Hard Reset Userdata / Unlock Bootloader HP Bootloop)
echo   [4] Backup Kilat Galeri Foto (DCIM) dan WhatsApp ke Laptop
echo   [5] Pasang File Aplikasi APK ke HP via Drag-and-Drop
echo   [6] Pasang Driver Resmi Google ADB dan Fastboot (android_winusb.inf)
echo   [7] Buka Panduan Servis Android (Kode Rahasia Dial, USB Debugging)
echo.
echo   [0] Kembali ke Menu Utama
echo ===============================================================================
set /p "A_CHOICE=Pilih nomor tool (0-7): "

if "%A_CHOICE%"=="1" goto RUN_A1
if "%A_CHOICE%"=="2" goto RUN_A2
if "%A_CHOICE%"=="3" goto RUN_A3
if "%A_CHOICE%"=="4" goto RUN_A4
if "%A_CHOICE%"=="5" goto RUN_A5
if "%A_CHOICE%"=="6" goto RUN_A6
if "%A_CHOICE%"=="7" goto RUN_A7
if "%A_CHOICE%"=="0" goto MAIN_MENU
goto MENU_ANDROID

:RUN_A1
call "%ROOT%04_Android\Menu_Servis_Android.bat"
goto MENU_ANDROID

:RUN_A2
call "%ROOT%04_Android\Layar_HP_Mirror_Scrcpy.bat"
goto MENU_ANDROID

:RUN_A3
call "%ROOT%04_Android\Fastboot_Toolkit.bat"
goto MENU_ANDROID

:RUN_A4
call "%ROOT%04_Android\Backup_Data_HP_Kilat.bat"
goto MENU_ANDROID

:RUN_A5
call "%ROOT%04_Android\Pasang_APK_Otomatis.bat"
goto MENU_ANDROID

:RUN_A6
call "%ROOT%04_Android\Driver_USB_Google\Pasang_Driver_Android_Google.bat"
goto MENU_ANDROID

:RUN_A7
notepad "%ROOT%04_Android\PANDUAN_SERVIS_HP_ANDROID.txt"
goto MENU_ANDROID

REM ===============================================================================
REM SUBMENU 5: SERVIS IPHONE
REM ===============================================================================
:MENU_IPHONE
cls
color 1F
set "I_CHOICE="
echo ===============================================================================
echo                         KATEGORI 05: SERVIS IPHONE
echo ===============================================================================
echo.
echo   [1] Buka Dashboard Servis iPhone Multi-Tool (libimobiledevice Engine)
echo   [2] Tarik Crash Log Panic Full (Diagnosa iPhone Restart Tiap 3 Menit)
echo   [3] KELUAR DARI RECOVERY MODE LOOP (Solusi Nyangkut di Logo iTunes Kabel)
echo   [4] Cek Kesehatan Baterai Asli dan Cycle Count
echo   [5] Diagnosa Chip Mode DFU / Recovery (iRecovery Query CPID/ECID)
echo   [6] Ambil Screenshot Layar iPhone ke Desktop PC
echo   [7] Buka Panduan Servis iPhone dan Kamus Sensor Panic Full
echo.
echo   [0] Kembali ke Menu Utama
echo ===============================================================================
set /p "I_CHOICE=Pilih nomor tool (0-7): "

if "%I_CHOICE%"=="1" goto RUN_I1
if "%I_CHOICE%"=="2" goto RUN_I2
if "%I_CHOICE%"=="3" goto RUN_I3
if "%I_CHOICE%"=="4" goto RUN_I4
if "%I_CHOICE%"=="5" goto RUN_I5
if "%I_CHOICE%"=="6" goto RUN_I6
if "%I_CHOICE%"=="7" goto RUN_I7
if "%I_CHOICE%"=="0" goto MAIN_MENU
goto MENU_IPHONE

:RUN_I1
call "%ROOT%05_iPhone\Menu_Servis_iPhone.bat"
goto MENU_IPHONE

:RUN_I2
call "%ROOT%05_iPhone\Tarik_Crash_Log_Panic_Full.bat"
goto MENU_IPHONE

:RUN_I3
cd /d "%ROOT%05_iPhone"
irecovery.exe -n
pause
goto MENU_IPHONE

:RUN_I4
cd /d "%ROOT%05_iPhone"
ideviceinfo.exe -q com.apple.mobile.battery
pause
goto MENU_IPHONE

:RUN_I5
call "%ROOT%05_iPhone\Cek_Chip_DFU_Recovery_irecovery.bat"
goto MENU_IPHONE

:RUN_I6
call "%ROOT%05_iPhone\Ambil_Screenshot_iPhone.bat"
goto MENU_IPHONE

:RUN_I7
notepad "%ROOT%05_iPhone\PANDUAN_SERVIS_IPHONE_DAN_PANIC_LOG.txt"
goto MENU_IPHONE

REM ===============================================================================
REM SUBMENU 6: DARURAT VIRUS & RECYCLER
REM ===============================================================================
:MENU_VIRUS
cls
color 0C
set "V_CHOICE="
echo ===============================================================================
echo                      DARURAT VIRUS, RECYCLER, DAN DISINFEKSI
echo ===============================================================================
echo.
echo   [1] Perbaikan Asosiasi File EXE Rusak (Solusi Aplikasi Tidak Bisa Dibuka)
echo   [2] Buka Blokir Task Manager, Registry Editor, dan Command Prompt
echo   [3] Bersihkan Spam Iklan / Virus Palsu Notifikasi Browser (Chrome & Edge)
echo   [4] Pulihkan File Flashdisk Terkena Virus Recycler Base64 (CEFHelper Worm)
echo   [5] Pulihkan File Flashdisk Terkena Virus Shortcut Biasa (Unhide Attrib)
echo   [6] Buka Malwarebytes AdwCleaner (Pembersih Adware Portabel)
echo   [7] Buka SOP Panduan Penanganan Virus Expiro, Sality, dan Ramnit
echo.
echo   [0] Kembali ke Menu Utama
echo ===============================================================================
set /p "V_CHOICE=Pilih nomor tool (0-7): "

if "%V_CHOICE%"=="1" goto RUN_V1
if "%V_CHOICE%"=="2" goto RUN_V2
if "%V_CHOICE%"=="3" goto RUN_V3
if "%V_CHOICE%"=="4" goto RUN_V4
if "%V_CHOICE%"=="5" goto RUN_V5
if "%V_CHOICE%"=="6" goto RUN_V6
if "%V_CHOICE%"=="7" goto RUN_V7
if "%V_CHOICE%"=="0" goto MAIN_MENU
goto MENU_VIRUS

:RUN_V1
call "%ROOT%01_Laptop_dan_Komputer\10_Antivirus_Darurat_dan_Disinfeksi\Fix_Asosiasi_File_EXE_Rusak.bat"
goto MENU_VIRUS

:RUN_V2
call "%ROOT%01_Laptop_dan_Komputer\10_Antivirus_Darurat_dan_Disinfeksi\Buka_Blokir_TaskManager_Regedit_CMD.bat"
goto MENU_VIRUS

:RUN_V3
call "%ROOT%01_Laptop_dan_Komputer\10_Antivirus_Darurat_dan_Disinfeksi\Bersihkan_Spam_Notifikasi_Browser.bat"
goto MENU_VIRUS

:RUN_V4
call "%ROOT%01_Laptop_dan_Komputer\09_Penyelamat_Flashdisk\Pulihkan_Virus_Recycler_Base64.bat"
goto MENU_VIRUS

:RUN_V5
call "%ROOT%01_Laptop_dan_Komputer\09_Penyelamat_Flashdisk\Pulihkan_Flashdisk_Shortcut.bat"
goto MENU_VIRUS

:RUN_V6
if exist "%ROOT%01_Laptop_dan_Komputer\10_Antivirus_Darurat_dan_Disinfeksi\AdwCleaner.exe" (
    start "" "%ROOT%01_Laptop_dan_Komputer\10_Antivirus_Darurat_dan_Disinfeksi\AdwCleaner.exe"
) else (
    echo.
    echo [INFO] AdwCleaner.exe belum diunduh.
    echo Mengarahkan ke halaman resmi Malwarebytes AdwCleaner...
    start https://www.malwarebytes.com/adwcleaner
    pause
)
goto MENU_VIRUS

:RUN_V7
notepad "%ROOT%01_Laptop_dan_Komputer\10_Antivirus_Darurat_dan_Disinfeksi\SOP_PENANGANAN_VIRUS_EXPIRUS_SALITY_RAMNIT.txt"
goto MENU_VIRUS

REM ===============================================================================
REM PINTASAN LAINNYA
REM ===============================================================================
:OPEN_SOP
start "" "%ROOT%SOP_DAN_CATATAN_LENGKAP_SEMUA_TOOLS.txt"
goto MAIN_MENU

:OPEN_EXPLORER
start "" "%ROOT%"
goto MAIN_MENU

:DOWNLOAD_TOOLS
call "%ROOT%UNDUH_TOOLS_PENDUKUNG.bat"
goto MAIN_MENU
