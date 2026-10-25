@echo off
setlocal
title Pengunduh Tools Pendukung - Amunisi Teknisi Lapangan
color 0B

echo Memeriksa hak akses dan memulai skrip unduh...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0UNDUH_TOOLS_PENDUKUNG.ps1"
exit /b
