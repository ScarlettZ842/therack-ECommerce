FROM php:7.4-fpm

# Set working directory
WORKDIR /var/www

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create entrypoint script
RUN echo '#!/bin/sh\n\
cd /var/www\n\
\n\
# Install composer dependencies if vendor directory does not exist\n\
if [ ! -d "vendor" ]; then\n\
    composer install --no-interaction --optimize-autoloader\n\
fi\n\
\n\
# Wait for MySQL to be ready\n\
echo "Waiting for MySQL..."\n\
while ! nc -z mysql 3306; do\n\
    sleep 1\n\
done\n\
echo "MySQL is ready!"\n\
\n\
# Generate application key if not exists\n\
if [ ! -f ".env" ]; then\n\
    cp .env.example .env\n\
fi\n\
\n\
php artisan key:generate --force\n\
\n\
# Create storage link\n\
php artisan storage:link\n\
\n\
# Set proper permissions\n\
chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache\n\
chmod -R 775 /var/www/storage /var/www/bootstrap/cache\n\
\n\
# Run migrations and seeds\n\
php artisan migrate --force\n\
php artisan db:seed --force\n\
\n\
# Start PHP-FPM\n\
php-fpm' > /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Install netcat for MySQL health check
RUN apt-get update && apt-get install -y netcat-traditional && rm -rf /var/lib/apt/lists/*

# Expose port 9000 and start php-fpm server
EXPOSE 9000

CMD ["/usr/local/bin/docker-entrypoint.sh"]
