# Dockerfile
FROM php:8.2-cli

# Install system dependencies including unzip and git
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

# Install PHP extensions including zip
RUN docker-php-ext-install pdo mbstring zip

# Clear out the local repository of retrieved package files
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set the working directory to the Laravel app directory
WORKDIR /app

# Copy the application files to the container
COPY . /app

# Install Composer dependencies
RUN composer install --no-interaction --no-dev --prefer-dist --optimize-autoloader

# Expose port 8000
EXPOSE 8000

# Use Laravel's built-in server to serve the application
CMD php artisan serve --host=0.0.0.0 --port=8000
