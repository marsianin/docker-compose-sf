FROM php:7.2-fpm

RUN apt-get update && \
    apt-get install -y \
        zlib1g-dev

# Install extra modules here
RUN /usr/local/bin/docker-php-ext-install pdo_mysql zip

RUN apt-get update -qq && apt-get install -yq wget vim