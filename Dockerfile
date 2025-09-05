# syntax=docker/dockerfile:1
FROM php:8.2-apache

# Optional extensions (add what you need)
# RUN docker-php-ext-install pdo pdo_mysql

# Useful modules + tools
RUN apt-get update && apt-get install -y --no-install-recommends unzip \
 && rm -rf /var/lib/apt/lists/*

# Enable Apache modules
RUN a2enmod rewrite headers

# Allow .htaccess overrides in /var/www/html
# (php:8.2-apache default DocRoot is /var/www/html)
RUN sed -i 's/AllowOverride None/AllowOverride All/i' /etc/apache2/apache2.conf

WORKDIR /var/www/html

# Copy app
COPY . /var/www/html

# App data dirs (match your validate.php usage)
RUN mkdir -p /var/www/html/.data /var/www/html/ogas \
 && chown -R www-data:www-data /var/www/html \
 && find /var/www/html -type d -exec chmod 755 {} \; \
 && find /var/www/html -type f -exec chmod 644 {} \;

EXPOSE 80
CMD ["apache2-foreground"]
