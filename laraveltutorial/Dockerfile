# Dockerfile
FROM php:8.2-cli

# Update the package repository and install the required packages
RUN apt-get update -y \
    && apt-get install -y libonig-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install required PHP extensions
RUN docker-php-ext-install pdo mbstring

# Set the working directory to /app
WORKDIR /app

# Copy the application files to the container
COPY . /app

# Run Composer install to install the dependencies
RUN composer install --no-interaction --no-dev --prefer-dist --optimize-autoloader

# Expose port 8000
EXPOSE 8000

# Use Laravel's built-in server to serve the application
CMD php artisan serve --host=0.0.0.0 --port=8000
