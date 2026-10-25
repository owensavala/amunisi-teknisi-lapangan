# 🧰 Amunisi Teknisi Lapangan (MSB Field Technician Toolkit)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011%20%7C%20Server-0078D6?logo=windows&logoColor=white)](https://microsoft.com)
[![Languages](https://img.shields.io/badge/Stack-Batch%20%7C%20PowerShell%20%7C%20HTML5-4EAA25)](https://github.com/owensavala/amunisi-teknisi-lapangan)
[![Author](https://img.shields.io/badge/Author-Muh.%20Sattar%20Barakati-blue)](https://muhsattarbarakati.my.id)

**Amunisi Teknisi Lapangan** adalah kumpulan skrip otomatisasi, utilitas diagnostik, dan SOP (Standar Operasional Prosedur) praktis yang dirancang khusus untuk teknisi komputer, IT support, proktor sekolah/kampus, dan teknisi servis lapangan di Indonesia.

Toolkit ini menggabungkan diagnostik perangkat keras (hardware), jaringan lab komputer (ANBK / CBT), servis printer (termasuk fix sharing printer error `0x0000011b`), penanganan malware/shortcut flashdisk, hingga penyelamatan data smartphone (Android ADB/Scrcpy & iPhone Panic Log analysis) ke dalam **satu menu interaktif mandiri tanpa instalasi rumit**.

---

## 🚀 Fitur Utama & Modul Toolkit

```
AMUNISI TEKNISI LAPANGAN
│
├── 01_Laptop_dan_Komputer/      # Diagnostik HW, Tweak Windows, Reset Sandi, ANBK
├── 02_Printer/                  # Fix Error 0x0000011b, Reset Spooler, Tes Nozzle
├── 03_Jaringan/                 # Scan IP Lab, Static/DHCP, Audit WiFi, Port Server
├── 04_Android/                  # Scrcpy Layar Pecah, ADB Fastboot, Backup Kilat
├── 05_iPhone/                   # Analisis Panic Full Log, Cycle Baterai, Exit Recovery
│
├── MENU_UTAMA_TEKNISI.bat       # Menu Master Interaktif (Jalankan sebagai Admin)
├── UNDUH_TOOLS_PENDUKUNG.bat    # Pengunduh Otomatis Binari Pendukung Resmi
├── SOP_DAN_CATATAN_LENGKAP.txt  # Dokumentasi SOP Lengkap Kasus Lapangan Nyata
└── PANDUAN_TEKNISI_LAPANGAN.txt # Buku Sakti Penanganan Kerusakan Cepat
```

---

### 💻 1. Laptop & Komputer (PC Desktop)
- **Diagnostik Layar & Keyboard Offline**:
  - `Tes_Layar_LCD_DeadPixel_Offline.html`: Pengujian canvas warna penuh layar tanpa internet untuk mendeteksi dead pixel atau stuck pixel.
  - `Tes_Keyboard_Offline.html`: Visualizer layout tombol keyboard interaktif untuk melacak tombol macet/ghosting.
- **Pemeriksaan Baterai & Storage**:
  - `Generate_Laporan_Baterai.bat`: Menghasilkan battery report resmi Windows (Cycle Count, Design Capacity, Full Charge Capacity, Wear Level).
  - `Cek_Kesehatan_Storage_CMD.bat`: Diagnostik SMART status drive SSD/HDD via WMIC & PowerShell.
  - `Cek_Spek_Lengkap_Laptop.bat`: Audit nomor seri BIOS, tipe prosesor, dan ketersediaan slot RAM tanpa bongkar casing.
- **Pemulihan & Akses Sistem**:
  - `Bypass_PopUp_Microsoft_Family_Anak.bat`: Bypass layar kunci proteksi keluarga Windows yang memblokir akses pengguna.
  - `Cara_1_Aktifkan_Administrator_Tersembunyi.bat`: Membuka user Administrator bawaan darurat saat akun klien terkunci.
  - `Bypass_Syarat_Windows_11_TPM_RAM.bat`: Tweak registry untuk instalasi Windows 11 pada perangkat generasi lama tanpa TPM 2.0 / Secure Boot.
  - `Perbaiki_File_Sistem_Corrupt_SFC_DISM.bat`: Satu tombol perbaikan file sistem korup Windows otomatis.

---

### 🖨️ 2. Servis & Sharing Printer
- **Solusi Tuntas Error Sharing Printer `0x0000011b`**:
  - `Fix_Sharing_Printer_0x0000011b.bat`: Mengatur parameter autentikasi `RpcAuthnLevelExemption` registry Windows pasca-update keamanan Microsoft.
- **Manajemen Antrean Cetak**:
  - `Reset_Print_Spooler.bat`: Menghentikan service Spooler, mengosongkan folder antrean `%systemroot%\system32\spool\printers\`, dan me-restart service dengan bersih.
  - `Bersihkan_Driver_Printer_Lama.bat`: Membuka antarmuka pembersihan driver sisa (PrintUI).
- **Pengujian Cetak Mandiri**:
  - `Cetak_Tes_Warna_Nozzle.html`: Halaman uji kalibrasi warna (Cyan, Magenta, Yellow, Black) siap cetak langsung dari browser secara offline.

---

### 🌐 3. Jaringan, WiFi & Lab Komputer (ANBK / CBT)
- **Persiapan Ujian Sekolah & Kampus**:
  - `Persiapan_Ujian_ANBK_TKA.bat`: Otomatisasi konfigurasi lingkungan ujian komputer (matikan update, optimasi adapter, verifikasi konektivitas gateway CBT).
- **Audit & Penyelamat Jaringan**:
  - `Lihat_Semua_Password_Wifi.bat`: Mengekstrak seluruh profil WiFi dan password WPA2/WPA3 tersimpan di sistem klien.
  - `Scan_IP_Komputer_Lab.bat`: Pemindai subnet ARP/ICMP cepat untuk memetakan seluruh komputer klien lab yang aktif.
  - `Atur_IP_Address_Static_DHCP.bat`: Menu beralih IP address statik ke DHCP dengan cepat.
  - `Cek_Port_Jaringan_Server.bat`: Menguji status ketersediaan port server lokal (80, 443, 8080, 3306, 8000, 8088).

---

### 📱 4. Servis Smartphone Android (Layar Rusak / Mati)
- **Penyelamat Data Layar Pecah**:
  - `Layar_HP_Mirror_Scrcpy.bat`: Menampilkan dan mengendalikan HP Android langsung dari laptop menggunakan Mouse dan Keyboard (sangat berguna jika layar sentuh pecah atau LCD blank hitam namun USB debugging aktif).
- **Otomatisasi Backup & Fastboot**:
  - `Backup_Data_HP_Kilat.bat`: Menarik DCIM (Foto/Kamera), Dokumen, dan Chat WhatsApp ke Desktop via ADB.
  - `Fastboot_Toolkit.bat`: Navigasi cepat flashing, reboot recovery, dan cek status bootloader.
  - `Pasang_Driver_Android_Google.bat`: Panduan instalasi cepat INF driver ADB Google.

---

### 🍎 5. Servis iPhone & Diagnostik Panic Log
- **Tarik & Analisis Panic Full Log**:
  - `Tarik_Crash_Log_Panic_Full.bat`: Menarik crash log `.ips` dari iPhone yang sering restart sendiri setiap 3 atau 5 menit.
  - Dilengkapi panduan identifikasi kerusakan hardware:
    - `0x80000` / `0x40000`: Sensor charging port / Mic 1 / Dock Flex korosi/pecah.
    - `0x100000`: Sensor flex earpiece / proximity / ambient light sensor basah/rusak.
    - `0x200000`: Sensor tombol power / flash LIDAR flex rusak.
- **Diagnostik Tingkat Lanjut**:
  - `Menu_Servis_iPhone.bat`: Baca cycle count kesehatan baterai pabrikan, cek status aktivasi iCloud, dan keluar dari loop Recovery Mode (iTunes) tanpa kehilangan data.

---

### 🛡️ 6. Penyelamat Flashdisk & Antivirus Darurat
- **Pemulih Shortcut & Recycler**:
  - `Pulihkan_Flashdisk_Shortcut.bat`: Menghapus file atribut tersembunyi `attrib -h -r -s /s /d` dan membasmi virus `.vbs` shortcut.
  - `Pulihkan_Virus_Recycler_Base64.bat`: Membersihkan malware folder palsu Recycler yang menyembunyikan direktori kerja klien.
- **Perbaikan Registri Terkunci**:
  - `PULIHKAN_REGISTRY_DAN_TASK_MANAGER_TERKUNCI.bat`: Membuka kunci Task Manager, Regedit, dan CMD yang dinonaktifkan oleh virus.

---

## 📥 Panduan Instalasi & Penggunaan

### 1. Unduh atau Clone Repositori
```bash
git clone https://github.com/owensavala/amunisi-teknisi-lapangan.git
cd amunisi-teknisi-lapangan
```

### 2. Jalankan Menu Utama
Klik kanan pada **`MENU_UTAMA_TEKNISI.bat`** dan pilih **Run as Administrator** (Jalankan sebagai administrator).

```
===============================================================================
                     AMUNISI LENGKAP TEKNISI LAPANGAN
                        Kompilasi Alat Kerja Mandiri
===============================================================================

  [1] LAPTOP DAN KOMPUTER (Diagnostik, Reset Password, Baterai, Tweak)
  [2] PRINTER (Fix Sharing 0x11b, Reset Spooler, Tes Warna Nozzle)
  [3] JARINGAN DAN LAB (Scan IP, Password Wifi, Setting IP Static/DHCP)
  [4] SERVIS HP ANDROID (Layar Pecah Mirror Scrcpy, Fastboot, Backup)
  [5] SERVIS HP IPHONE (Tarik Crash Log Panic Full, Info Baterai, DFU)
  [6] PENANGANAN VIRUS DAN FLASHDISK (Hapus Shortcut, Buka Regedit/Taskmgr)

  [7] BUKA BUKU SOP DAN PANDUAN LENGKAP LAPANGAN (File Teks)
  [8] BUKA FOLDER TOOLKIT DI WINDOWS EXPLORER
  [9] UNDUH TOOLS PENDUKUNG RESMI (Scrcpy, CrystalDiskInfo, ADB, AdwCleaner)

  [0] KELUAR
```

### 3. (Opsional) Mengunduh Binari Pihak Ketiga Resmi
Repositori ini sengaja **tidak menyertakan file binary `.exe` pihak ketiga** demi kepatuhan lisensi, keamanan malware, dan menjaga ukuran repo tetap ramping.

Untuk mengunduh tool pihak ketiga resmi (open-source / freeware portable) secara otomatis:
- Jalankan **`UNDUH_TOOLS_PENDUKUNG.bat`** atau pilih opsi **`[9]`** pada menu utama.
- Skrip akan mengunduh langsung dari repositori resmi vendor (GitHub Genymobile Scrcpy, Google Android Repository, SourceForge CrystalDiskInfo, dan Malwarebytes).

---

## ⚖️ Keamanan & Kepatuhan Lisensi

- **100% Script Murni**: Semua modul utama dibangun menggunakan Batch Script (`.bat`), PowerShell (`.ps1`), dan HTML5/CSS/JavaScript canvas murni.
- **Tanpa Aktivator Ilegal / MAS**: Modul aktivasi hanya memuat `Cek_Serial_Key_Bawaan_Laptop_BIOS.bat` yang mengekstrak serial key OEM resmi yang tersimpan di chip motherboard BIOS perangkat klien secara legal menggunakan `SoftwareLicensingService`.
- **Tidak Memodifikasi Sistem Klien Secara Diam-diam**: Setiap skrip menyertakan menu konfirmasi, petunjuk penggunaan yang ramah, dan log proses.

---

## 👨‍💻 Kontributor & Lisensi

Dibuat dan dipelihara oleh **Muh. Sattar Barakati (Owen)**  
- Portofolio: [https://muhsattarbarakati.my.id](https://muhsattarbarakati.my.id)  
- GitHub: [@owensavala](https://github.com/owensavala)

Proyek ini didistribusikan di bawah lisensi **MIT License**. Silakan gunakan, pelajari, dan modifikasi untuk kebutuhan operasional IT Anda.
