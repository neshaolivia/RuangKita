# RuangKita — Booking Ruang Meeting Coworking Space

## Tim
| Peran | Nama |
|---|---|
| Tech Lead / Backend | Dewanti |
| DevOps Engineer | Annisa |
| Container Engineer | Nesha |

## Stack
- Framework: PHP Native
- Database: MySQL
- Container: Docker + Docker Compose

## Fitur Wajib (Studi Kasus K10)
1. CRUD ruang (kapasitas, fasilitas, harga per jam)
2. Cek ketersediaan per tanggal
3. Booking dan pembatalan
4. Kalender pemakaian ruang

## Aturan Bisnis
1. Dua booking pada ruang yang sama tidak boleh tumpang tindih.
2. Jumlah peserta tidak boleh melebihi kapasitas ruang.
3. Durasi booking 1–8 jam (jam operasional 08.00–21.00).
4. Pembatalan < 2 jam sebelum mulai dikenai denda 50%.
