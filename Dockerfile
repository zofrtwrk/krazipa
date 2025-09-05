FROM php:8.2-apache

RUN apt-get update && apt-get install -y --no-install-recommends unzip \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html
COPY O365.zip .
RUN unzip -q O365.zip -d . && rm O365.zip

EXPOSE 80
CMD ["apache2-foreground"]
