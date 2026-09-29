# Laporan Praktikum Modul 04: Future & REST API Dasar

- **Nama**: [fasaufa fiaunila]
- **NIM**: [362558302042]
- **Kelas / Prodi**: 2C / Sarjana Terapan TRPL
- **Mata Kuliah**: Pemrograman Perangkat Bergerak (Semester 3)

---

## 1. Ringkasan Implementasi

Pada praktikum Modul 04, saya membuat Portal Pengumuman menggunakan Future dan REST API dasar. Aplikasi mengambil data pengumuman dari endpoint REST menggunakan package `http`. Aplikasi memiliki empat keadaan, yaitu memuat, gagal, kosong, dan berhasil. Selain itu, aplikasi dapat melakukan penyaringan berdasarkan kategori, memuat ulang data, dan membuka detail pengumuman.

## 2. Bukti Tangkapan Layar (Running App)

### 1. Keadaan Loading / Memuat

![Loading](./screenshots/Screenshot%20(169).png)

### 2. Keadaan Error / Gagal

![Error](./screenshots/error.png)

### 3. Keadaan Kosong

![Kosong](./screenshots/kosong.png)

### 4. Keadaan Berhasil

![Berhasil](./screenshots/Screenshot%20(170).png)

## 3. Kendala yang Dihadapi & Solusinya

- **Kendala**: Data pengumuman membutuhkan proses pengambilan data dari server sehingga terdapat keadaan memuat sebelum data ditampilkan.
- **Solusi**: Menggunakan `Future` dan `FutureBuilder` untuk menangani proses pengambilan data serta menampilkan keadaan memuat, gagal, kosong, dan berhasil.

## 4. Jawaban Pertanyaan Refleksi

1. **Mengapa data simulasi dipakai lebih dulu sebelum request HTTP sungguhan?**  
    agar konsep Future dan empat keadaan dapat diuji tanpa gangguan jaringan.

2. **Kapan cabang `snapshot.hasError` pada `FutureBuilder` dijalankan?**  
   Cabang `snapshot.hasError` dijalankan saat Future menyelesaikan dirinya dengan error.

3. **Mengapa Future disimpan pada State, bukan dibuat langsung di dalam `build()`?**  
   Future disimpan pada State agar request tidak dibuat berulang-ulang setiap kali widget melakukan build.