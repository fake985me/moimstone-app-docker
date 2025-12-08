---
description: Deploy aplikasi Laravel+Vue.js ke Render.com
---

# Panduan Deploy ke Render.com

Berikut adalah langkah-langkah untuk deploy aplikasi Laravel + Vue.js ke Render.com:

## Persiapan Awal

### 1. Push kode ke Git Repository

Pastikan kode Anda sudah di-push ke GitHub, GitLab, atau Bitbucket.

```bash
git add .
git commit -m "Prepare for Render deployment"
git push origin main
```

### 2. Buat file build script

Buat file `build.sh` di root project:

```bash
#!/usr/bin/env bash
# Exit on error
set -o errexit

# Install Composer dependencies
composer install --no-dev --optimize-autoloader

# Install Node.js dependencies
npm ci

# Build frontend assets
npm run build

# Clear and optimize Laravel
php artisan config:clear
php artisan cache:clear
php artisan view:clear
php artisan route:cache
php artisan config:cache
php artisan view:cache

# Run migrations (optional, bisa juga manual)
# php artisan migrate --force
```

Jangan lupa set file permission:

```bash
chmod +x build.sh
```

### 3. Buat database PostgreSQL di Render.com

1. Login ke **Render.com**
2. Klik **New +** → **PostgreSQL**
3. Beri nama database (contoh: `mai-app-db`)
4. Pilih region terdekat
5. Pilih plan (Free tier available)
6. Klik **Create Database**
7. Simpan **Internal Database URL** untuk digunakan nanti

## Setup Web Service

### 4. Buat Web Service baru

1. Di Render Dashboard, klik **New +** → **Web Service**
2. Connect repository Git Anda
3. Pilih repository aplikasi

### 5. Konfigurasi Web Service

**Basic Settings:**

-   **Name**: `mai-app` (atau nama lain)
-   **Region**: Pilih region yang sama dengan database
-   **Branch**: `main` (atau branch yang Anda gunakan)
-   **Root Directory**: (kosongkan jika di root)
-   **Runtime**: `PHP`

**Build & Deploy:**

-   **Build Command**: `./build.sh`
-   **Start Command**: `php artisan serve --host=0.0.0.0 --port=$PORT`

**Instance Type:**

-   Pilih **Free** atau **Starter** sesuai kebutuhan

### 6. Set Environment Variables

Klik **Advanced** → **Add Environment Variable**, tambahkan:

```
APP_NAME=MAI-App
APP_ENV=production
APP_KEY=
APP_DEBUG=false
APP_URL=https://mai-app.onrender.com

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=error

DB_CONNECTION=pgsql
DB_HOST=<host-dari-internal-database-url>
DB_PORT=5432
DB_DATABASE=<database-name>
DB_USERNAME=<database-username>
DB_PASSWORD=<database-password>

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=database
SESSION_DRIVER=database
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"
```

**PENTING:**

-   Untuk `APP_KEY`, jalankan `php artisan key:generate --show` di lokal dan copy hasilnya
-   Untuk database credentials, ambil dari **Internal Database URL** yang format-nya:
    ```
    postgresql://username:password@host:5432/database
    ```

### 7. Deploy aplikasi

1. Klik **Create Web Service**
2. Render akan otomatis build dan deploy aplikasi
3. Tunggu hingga proses selesai (biasanya 5-10 menit)

### 8. Jalankan migrasi database

Setelah deploy sukses:

1. Buka **Shell** di Render dashboard
2. Jalankan:

```bash
php artisan migrate --force
php artisan db:seed --force
```

## Troubleshooting

### Jika build gagal:

-   Periksa logs di Render dashboard
-   Pastikan `build.sh` memiliki permission yang benar
-   Pastikan semua dependencies ada di `composer.json` dan `package.json`

### Jika aplikasi error 500:

-   Set `APP_DEBUG=true` sementara untuk melihat error
-   Periksa logs: `php artisan log:tail` di Shell
-   Pastikan `APP_KEY` sudah di-set dengan benar

### Jika asset tidak load:

-   Pastikan `APP_URL` sudah benar
-   Periksa apakah `npm run build` berhasil
-   Pastikan `public/build` folder ter-generate

### Storage & File Permissions:

```bash
php artisan storage:link
chmod -R 775 storage bootstrap/cache
```

## Alternatif Start Command (Nginx/Apache tidak tersedia di Free tier)

Untuk production yang lebih baik, gunakan:

```bash
php -S 0.0.0.0:$PORT -t public
```

Atau dengan custom server.php jika sudah ada di Laravel.

## Custom Domain (Optional)

1. Di Web Service settings, klik **Custom Domains**
2. Tambahkan domain Anda
3. Update DNS records sesuai instruksi Render

## Tips Tambahan

1. **Enable Auto-Deploy**: Aktifkan agar setiap push ke Git otomatis deploy
2. **Health Checks**: Set health check endpoint (misalnya `/api/health`)
3. **Monitoring**: Gunakan Render logs untuk monitoring
4. **Backups**: Render PostgreSQL Free tier tidak include auto-backup, pertimbangkan upgrade atau backup manual
5. **Redis**: Jika butuh Redis, buat Redis instance terpisah di Render

## Biaya

-   **Free Tier**:
    -   Web Service: 750 jam/bulan (sleep setelah 15 menit tidak aktif)
    -   PostgreSQL: 90 hari, 1GB storage
-   **Paid Tier**: Mulai dari $7/bulan untuk web service yang always-on

---

Selamat! Aplikasi Anda sekarang sudah live di Render.com 🎉
