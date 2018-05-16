FROM php:7.1.3-fpm

# Install extra modules here
RUN /usr/local/bin/docker-php-ext-install pdo_mysql

RUN apt-get update -qq && apt-get install -yq wget vim