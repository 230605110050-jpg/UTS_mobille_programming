# Project UTS Aplikasi Baca Komik — KomikKu

Aplikasi baca komik berbasis Flutter yang memiliki dua peran utama:  
**Pembaca (Reader)** dan **Author (Pembuat Komik)**.  
Proyek ini dikembangkan sebagai bagian dari tugas UTS Mobile Programming.

---

## 1. Cara Menggunakan Menu Profil

### 1.1 Lokasi Menu Profil
Menu profil berada di pojok kanan atas navbar aplikasi, ditandai dengan:
- Icon avatar bulat berisi inisial nama pengguna.
- Efek ring warna emerald muncul saat diarahkan (hover) atau difokuskan (focus).

---

### 1.2 Cara Mengakses
1. Klik icon avatar di pojok kanan atas.
2. Dropdown menu akan muncul berisi beberapa opsi.
3. Klik salah satu menu untuk membuka halaman yang diinginkan.
4. Klik di luar menu untuk menutup dropdown.

---

## 2. Fitur Menu Profil

### 2.1 Untuk Pembaca (Reader)

#### Informasi & Profil
- **Informasi Akun** — Lihat detail profil Anda.  
- **Edit Profil** — Ubah nama, bio, dan informasi lainnya.

#### Aktivitas
- **Komik Favorit** — Lihat daftar komik yang telah Anda favoritkan.  
- **Riwayat Baca** — Cek histori komik yang pernah dibaca.

#### Pengaturan
- **Pengaturan** — Kelola notifikasi, privasi, dan preferensi baca.

#### Keluar
- **Logout** — Keluar dari akun dan kembali ke halaman login.

---

### 2.2 Untuk Author (Pembuat Komik)

#### Dashboard & Profil
- **Dashboard** — Kelola semua komik yang Anda buat.
- **Informasi Akun** — Lihat profil author.
- **Edit Profil** — Ubah nama, bio, dan media sosial.

#### Pengaturan
Terdapat empat tab utama pada menu pengaturan:

| Tab | Deskripsi |
|-----|------------|
| Profil | Edit informasi author. |
| Notifikasi | Atur notifikasi push, komentar, dan email. |
| Publikasi | Atur visibilitas dan rating konten. |
| Keamanan | Ubah password, aktifkan 2FA, atau hapus akun. |

#### Keluar
- **Logout** — Keluar dari aplikasi dan kembali ke halaman login.

---

## 3. Demo Login

Aplikasi ini secara default memulai sesi dengan user yang sudah login (mode demo).  
Untuk login manual, gunakan akun berikut:

| Role | Email | Password |
|------|--------|-----------|
| Pembaca | pembaca@example.com | (bebas, mode demo) |
| Author | ahmad@example.com | (bebas, mode demo) |

Catatan: Password tidak diverifikasi di mode demo, cukup isi teks bebas untuk masuk.

---

## 4. Visual Indicators

Elemen visual di menu profil meliputi:
- **Hover Effect**: Ring emerald muncul saat diarahkan ke avatar.
- **Focus State**: Ring emerald juga muncul saat avatar difokuskan.
- **Tooltip**: Teks "Menu Akun" muncul saat hover.
- **Badge Role**: Menampilkan label “Pembaca” atau “Author”.
- **Icon Berwarna**: Setiap menu item memiliki warna ikon berbeda.
- **Logout Berwarna Merah**: Tombol keluar menggunakan warna merah untuk penegasan visual.

---

## 5. Desain Responsif

Menu dropdown menyesuaikan ukuran layar pengguna:

| Perangkat | Tampilan |
|------------|-----------|
| Desktop | Menu berlebar tetap 288px (w-72). |
| Mobile | Menu menyesuaikan lebar layar perangkat. |

---

## 6. Fitur Interaktif

| Aksi | Hasil |
|------|--------|
| Klik avatar | Membuka dropdown menu akun. |
| Klik di luar menu | Menutup dropdown secara otomatis. |
| Klik menu item | Navigasi ke halaman yang sesuai. |
| Klik "Keluar" | Logout dan kembali ke halaman login. |

---
