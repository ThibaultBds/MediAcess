FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    && docker-php-ext-install pdo pdo_mysql

RUN a2enmod rewrite

ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf \
    && sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/apache2.conf

WORKDIR /var/www/html

COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80