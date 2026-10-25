@echo off
title Scan IP Komputer & Perangkat Aktif di Lab
color 1F

echo ========================================================
echo        SCAN PERANGKAT & IP AKTIF DI JARINGAN LAB
echo ========================================================
echo.
echo Membaca daftar komputer, HP, dan router yang sedang terhubung...
echo Mohon tunggu sebentar...
echo.

arp -a | findstr /V "Interface: --- 255.255.255.255"

echo.
echo ========================================================
echo Panduan Teknisi:
echo Kolom pertama adalah Alamat IP perangkat yang aktif.
echo Kolom kedua adalah Alamat Fisik (MAC Address).
echo ========================================================
echo.
pause
