@echo off
setlocal
title Unduh Kaspersky Virus Removal Tool (KVRT) Resmi Terbaru

color 0B
echo ================================================================
echo       PENGUNDUH RESMI KASPERSKY VIRUS REMOVAL TOOL (KVRT)
echo                    Tools Teknisi Lapangan
echo ================================================================
echo.
echo Alat ini akan mengunduh versi portabel resmi terbaru dari server
echo Kaspersky untuk membersihkan infeksi virus Expiro, Sality, dan Trojan.
echo.
echo File tujuan:
echo %~dp0Kaspersky_Virus_Removal_Tool_KVRT.exe
echo.
echo Sedang mengunduh file (~116 MB)... Mohon tunggu hingga selesai!
echo.

curl.exe -L -o "%~dp0Kaspersky_Virus_Removal_Tool_KVRT.exe" "https://devbuilds.s.kaspersky-labs.com/devbuilds/KVRT/latest/full/KVRT.exe"

if exist "%~dp0Kaspersky_Virus_Removal_Tool_KVRT.exe" (
    color 0A
    echo.
    echo ================================================================
    echo [SUKSES] Kaspersky Virus Removal Tool berhasil diunduh!
    echo Anda dapat langsung menjalankannya secara portabel tanpa instalasi.
    echo ================================================================
) else (
    color 0C
    echo [GAGAL] Pengunduhan terputus. Pastikan koneksi internet stabil.
)

echo.
pause
