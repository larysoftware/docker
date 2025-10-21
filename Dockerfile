FROM php:8.4-apache

ARG VHOST_CONF_PATH

RUN a2enmod ssl
RUN a2enmod rewrite
RUN docker-php-ext-install pdo pdo_mysql
RUN echo "Copying virtual host config"
COPY ${VHOST_CONF_PATH} /etc/apache2/sites-enabled/.
RUN apt-get update \
    && apt-get install -y libzip-dev \
    && apt-get install -y zlib1g-dev \
    && apt-get install -y librabbitmq-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install zip

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
install-php-extensions gd xdebug

# Instalacja Node.js (LTS) + npm
RUN curl -fsSL https://nodejs.org/dist/v22.11.0/node-v22.11.0-linux-arm64.tar.xz -o /tmp/node.tar.xz \
    && tar -xf /tmp/node.tar.xz -C /usr/local --strip-components=1 \
    && rm /tmp/node.tar.xz \
    && npm install -g npm@11.5.2


# Instalacja Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir -p /var/www/backend
RUN mkdir -p /var/www/front
RUN docker-php-ext-enable xdebug

WORKDIR /var/www/front/
