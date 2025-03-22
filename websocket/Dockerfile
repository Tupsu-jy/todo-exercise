FROM php:8.1-cli

# Install dependencies
RUN apt-get update && apt-get install -y \
  libpq-dev \
  git \
  zip \
  unzip \
  libzip-dev \
  && docker-php-ext-install pdo pdo_pgsql zip \
  && pecl install redis \
  && docker-php-ext-enable redis

WORKDIR /app

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy keeping structure
COPY src/ src/
COPY composer.json composer.lock ./

# Install dependencies
RUN composer install --no-scripts --no-autoloader

# Generate optimized autoloader
RUN composer dump-autoload --optimize

# Start WebSocket server
CMD ["php", "src/websocket_server.php"]
