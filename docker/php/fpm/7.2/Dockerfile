FROM php:7.2-fpm

RUN apt-get update && \
    apt-get install -y \
        zlib1g-dev

#RUN pecl install xdebug-2.7.0alpha1
#
#RUN docker-php-ext-enable xdebug

#RUN docker-php-ext-configure opcache --enable-opcache \
#    && docker-php-ext-install opcache


RUN apt-get update && apt-get install -my gnupg

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

# Install extra modules here
RUN /usr/local/bin/docker-php-ext-install pdo_mysql zip

RUN apt-get update -qq && apt-get install -yq wget vim

RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini
