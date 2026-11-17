<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

<p align="center">
<a href="https://github.com/laravel/framework/actions"><img src="https://github.com/laravel/framework/workflows/tests/badge.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

# RuangKita — Booking Ruang Meeting Coworking Space

## Tim
| Peran | Nama |
|---|---|
| Tech Lead / Backend | Dewanti |
| DevOps Engineer | Anissa |
| Container Engineer | Nesha |

## Stack
- Framework: Laravel (PHP)
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

---

## About Laravel

Laravel is a web application framework with expressive, elegant syntax. We believe development must be an enjoyable and creative experience to be truly fulfilling. Laravel takes the pain out of development by easing common tasks used in many web projects, such as:

- [Simple, fast routing engine](https://laravel.com/docs/routing).
- [Powerful dependency injection container](https://laravel.com/docs/container).
- Multiple back-ends for [session](https://laravel.com/docs/session) and [cache](https://laravel.com/docs/cache) storage.
- Expressive, intuitive [database ORM](https://laravel.com/docs/eloquent).
- Database agnostic [schema migrations](https://laravel.com/docs/migrations).
- [Robust background job processing](https://laravel.com/docs/queues).
- [Real-time event broadcasting](https://laravel.com/docs/broadcasting).

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).