FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    zlib1g-dev \
    libzip-dev \
    libjpeg-dev \
    libfreetype6-dev \
    git \
    curl \
    libsqlite3-dev && \
    rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl bcmath gd

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set the working directory to the Laravel app directory
WORKDIR /var/www/html

# Copy the application code to the container
COPY . /var/www/html

# Ensure the SQLite database file exists and has the correct permissions
RUN touch /var/www/html/database/database.sqlite && \
    chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database && \
    chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database

# Install Composer dependencies
RUN composer install --no-interaction --no-dev --prefer-dist --optimize-autoloader && \
    php artisan key:generate --force && \
    php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache

# Copy .env.example to .env, this can be replaced by actual .env for production
COPY .env.example /var/www/html/.env

# Update the document root to point to the Laravel public directory
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Change ownership of our applications
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
