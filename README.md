# RuangKita – Booking Ruang Meeting & Coworking

Startup fiktif **RuangKita** (K10) untuk Tugas Besar 1 DevOps: CI/CD Pipeline Jenkins.
Mata kuliah Komputasi Awan – Semester Ganjil 2026–2027.

RuangKita adalah aplikasi pemesanan ruang meeting di coworking space. Setiap perubahan kode yang di-push ke GitHub otomatis dites, dikemas menjadi image Docker, dikirim ke Docker Hub, lalu di-deploy dengan Docker Compose lewat Jenkins.

## Anggota & Peran

| Nama | NIM | Peran |
|---|---|---|
| (isi nama) | (isi NIM) | Tech Lead / Backend |
| (isi nama) | (isi NIM) | DevOps Engineer |
| (isi nama) | (isi NIM) | Container Engineer |
| (isi nama) | (isi NIM) | QA Engineer & Tech Writer |

## Stack

| Komponen | Teknologi |
|---|---|
| Bahasa | PHP 8.3 (native, tanpa framework) |
| Web server | Apache (image `php:8.3-apache`) |
| Database | MySQL 8.0 |
| Test | PHPUnit |
| Container | Docker, Docker Compose |
| CI/CD | Jenkins, GitHub Webhook, Ngrok |
| Registry | Docker Hub |

## Fitur

- CRUD ruang (nama, kapasitas, fasilitas, harga per jam)
- Cek ketersediaan ruang per tanggal
- Booking dan pembatalan
- Kalender pemakaian ruang
- Endpoint `GET /health` (status aplikasi dan koneksi database)

## Aturan Bisnis

1. Dua booking pada ruang yang sama tidak boleh tumpang tindih, termasuk irisan sebagian.
2. Jumlah peserta tidak boleh melebihi kapasitas ruang.
3. Durasi booking 1–8 jam, pada jam operasional 08.00–21.00.
4. Pembatalan kurang dari 2 jam sebelum mulai dikenai denda 50%.

Semua aturan divalidasi di sisi server dan diuji otomatis dengan PHPUnit.

## Struktur Project

```
ruangkita/
├── public/
│   └── index.php            # router dan endpoint
├── src/
│   ├── Database.php         # koneksi PDO
│   └── BookingRules.php     # aturan bisnis
├── database/
│   ├── migrate.php          # menjalankan file migrasi
│   └── migrations/          # file .sql
├── tests/                   # test PHPUnit
├── Dockerfile               # multi-stage: vendor, test, production
├── compose.yaml             # app + db (image dari Docker Hub)
├── compose.local.yaml       # build lokal untuk development
├── Jenkinsfile              # pipeline CI/CD
├── .env.example             # contoh konfigurasi (salin ke .env)
└── composer.json
```

## Menjalankan di Lokal

Prasyarat: Docker Desktop dan Git.

```bash
git clone <url-repo> ruangkita
cd ruangkita

cp .env.example .env        # Windows PowerShell: Copy-Item .env.example .env
# isi password database dan DOCKERHUB_USER di .env

# jalankan test di dalam container
docker build --target test -t ruangkita:test .

# jalankan aplikasi dan database
docker compose -f compose.yaml -f compose.local.yaml up -d --build

# jalankan migrasi
docker compose exec app php database/migrate.php

# cek status dan health
docker compose ps
curl -i http://localhost:8000/health
```

Respons `/health` yang sehat:

```json
{"status":"ok","database":"connected"}
```

Menghentikan aplikasi:

```bash
docker compose down
```

## Alur CI/CD

```
Push ke GitHub → Webhook (Ngrok) → Jenkins
   → Checkout → Test → Build Image → Push Image (Docker Hub)
   → Deploy (docker compose) → Smoke Test (/health)
```

| Stage | Fungsi |
|---|---|
| Checkout | Mengambil kode dari GitHub |
| Test | Menjalankan PHPUnit di dalam container (`--target test`) |
| Build Image | Membuat image dengan tag nomor build dan `latest` |
| Push Image | Mengirim image ke Docker Hub memakai Jenkins Credentials |
| Deploy | Menarik image dan menjalankan `docker compose up -d` |
| Smoke Test | Memanggil `/health`; pipeline gagal jika respons bukan 200 |

Rahasia (token, password database) disimpan di Jenkins Credentials dan file `.env`, tidak pernah di-commit.

## Tantangan DevOps: Rollback Otomatis

Sebelum deploy, pipeline mencatat tag image yang sedang berjalan. Jika Smoke Test gagal, blok `post { failure { ... } }` otomatis men-deploy ulang tag sebelumnya, sehingga aplikasi kembali ke versi terakhir yang sehat.

## Alur Kolaborasi Git

- Branch `main` hanya diubah lewat pull request.
- Setiap anggota bekerja di branch sendiri (`feature/...`), lalu membuka PR untuk di-review dan di-merge.
- Merge ke `main` memicu pipeline Jenkins.
