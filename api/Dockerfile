# Use the official PHP image with Apache
FROM php:8.4-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
  libpng-dev \
  libjpeg-dev \
  libfreetype6-dev \
  libpq-dev \
  zip \
  unzip \
  git \
  supervisor \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install gd pdo pdo_pgsql pcntl

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_pgsql

# Enable Apache mod_rewrite
RUN a2enmod rewrite proxy proxy_wstunnel proxy_http

# Set the apache document root to public
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Configure Apache to proxy WebSocket connections
RUN echo "\n\
  <VirtualHost *:80>\n\
  DocumentRoot /var/www/html/public\n\
  ProxyRequests Off\n\
  ProxyPreserveHost On\n\
  RewriteEngine On\n\
  \n\
  <Location /app/ob0ildef0rapadlha0hl>\n\
  ProxyPass ws://localhost:8000/app/ob0ildef0rapadlha0hl\n\
  ProxyPassReverse ws://localhost:8000/app/ob0ildef0rapadlha0hl\n\
  RewriteEngine On\n\
  RewriteCond %{HTTP:UPGRADE} ^WebSocket$ [NC]\n\
  RewriteCond %{HTTP:CONNECTION} Upgrade$ [NC]\n\
  RewriteRule .* ws://localhost:8000%{REQUEST_URI} [P,L]\n\
  </Location>\n\
  </VirtualHost>" > /etc/apache2/sites-available/000-default.conf

# Copy existing application directory contents
COPY . /var/www/html

# Set working directory
WORKDIR /var/www/html

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install project dependencies
RUN composer install

# Copy existing application directory permissions
RUN chown -R www-data:www-data /var/www/html \
  && chmod -R 755 /var/www/html/storage

# Setup supervisor configuration
COPY docker/supervisor.conf /etc/supervisor/conf.d/supervisor.conf

# Expose port 80
EXPOSE 80

# Start supervisor
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
