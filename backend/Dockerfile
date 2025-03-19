FROM php:7.4-apache

# Install dependencies for PostgreSQL
RUN apt-get update && apt-get install -y \
  libpq-dev \
  && docker-php-ext-install pdo pdo_pgsql

COPY src/ /var/www/html/

# Expose the default Apache port
EXPOSE 80
