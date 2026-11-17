# Stage 1: Base
FROM php:8.3-fpm-alpine AS base
RUN apk add --no-cache $PHPIZE_DEPS oniguruma-dev libzip-dev icu-dev unzip git curl \
    && docker-php-ext-install pdo pdo_mysql mbstring zip intl opcache
WORKDIR /var/www/html
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Stage 2: Test (dipakai Jenkins nanti)
FROM base AS test
COPY composer.json composer.lock ./
RUN composer install --prefer-dist --no-scripts
COPY . .
CMD ["php", "artisan", "test"]

# Stage 3: Final (untuk production)
FROM base AS final
COPY composer.json composer.lock ./
RUN composer install --no-dev --no-scripts --prefer-dist
COPY . .
RUN composer dump-autoload --optimize \
    && chown -R www-data:www-data storage bootstrap/cache
EXPOSE 9000
CMD ["php-fpm"]
