# Use the official PHP image with the Apache web server
FROM php:8.2-apache

# Install system dependencies
RUN apt-get update -y && apt-get install -y \
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
    curl

# Install PHP extensions
RUN docker-php-ext-install pdo mbstring zip

# Clear out the local repository of retrieved package files
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set the working directory to /app
WORKDIR /app

# Copy the application code
COPY . /app

# Ensure the SQLite database file exists and has the correct permissions
RUN touch /app/database/database.sqlite \
    && chmod -R 775 /app/database \
    && chown -R www-data:www-data /app/database

# Install Composer dependencies
RUN composer install --no-interaction --no-dev --prefer-dist --optimize-autoloader

# Fix permissions for the storage and bootstrap cache
RUN chown -R www-data:www-data /app/storage /app/bootstrap/cache \
    && chmod -R 775 /app/storage /app/bootstrap/cache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Expose port 80
EXPOSE 80

# Copy the .env file
COPY .env /app/.env

# Optimize the application (Autoloader optimization, cache configuration, routes, and views)
RUN php artisan config:cache \
    && php artisan route:cache \
    && php artisan view:cache

# Start the Apache server in the foreground
CMD ["apache2-foreground"]
