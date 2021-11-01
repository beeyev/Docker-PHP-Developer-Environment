FROM php:8.0-fpm

LABEL maintainer="Alexander Tebiev"

ENV CONTAINER_VERSION="2021.10.07"
ENV CONTAINER_TITLE="PHP"
ENV CONTAINER_COPYRIGHT="Beeyev"
#Command bellow will be executed in motd via eval function, example: eval ${CONTAINER_HELLO_TEXT}
ENV CONTAINER_HELLO_TEXT="printf \"PHP Version: \${cGreen}\${PHP_VERSION}\${cNo}\n\""

ENV TERM="xterm-256color"
ENV TZ=${TZ}

# install-php-extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN set -eux && chmod +x /usr/local/bin/install-php-extensions && sync


RUN set -eux \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    mc \
    curl \
    cron \
    nano \
    unzip \
    inetutils-ping

ARG BUILD_DEPS="libmagickwand-dev libzip-dev"
RUN set -eux \
    && apt-get install -y --no-install-recommends ${BUILD_DEPS} \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    && docker-php-ext-configure zip \
    && docker-php-ext-configure intl

RUN set -eux \
    && install-php-extensions \
        @composer \
        #mongodb \
        xdebug \
        pdo_pgsql \
        imagick \
        amqp \
        redis \
        opcache \
        gd \
        bcmath \
        intl \
        pdo_mysql \
        mysqli \
        soap \
        exif \
        sockets \
        zip \
        xsl \
        pcntl \
        xmlrpc


# Blackfire installation
# Atteention! You can not use Blackfire when one of the following extensions is also enabled: XDebug, XHProf, Pinba, Suhosin and pcov
# Details: https://blackfire.io/docs/up-and-running/installation
# RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
# && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
# && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
# && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
# && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini

# mhsendmail
# A sendmail replacement which forwards mail to an SMTP server.
# @see https://github.com/mailhog/mhsendmail
ADD https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 /usr/local/bin/mhsendmail
RUN set -eux && chmod +x /usr/local/bin/mhsendmail && sync

#Copying php.ini file for compatibility purposes
#By default it will be overwritten using docker-compose volume file mapping
COPY ./config/php.ini /usr/local/etc/php/php.ini

# Cleanup
RUN set -eux \
    && apt-get purge -y ${BUILD_DEPS} \
    && docker-php-source delete \
    && apt-get clean -y \
    && apt-get autoremove --purge -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && rm /var/log/lastlog /var/log/faillog

WORKDIR /var/www
EXPOSE 9000

#default username
ARG DOCKER_USER=user
ENV DOCKER_USER=${DOCKER_USER}
ARG DOCKER_UID=1000
ENV DOCKER_UID=${DOCKER_UID}
# Create system user to run Composer and Artisan Commands
RUN  set -eux \
    && useradd -G www-data,root -u ${DOCKER_UID} -ms /bin/bash -d /home/${DOCKER_USER} ${DOCKER_USER} \
    && chown -R ${DOCKER_USER}.${DOCKER_USER} /var/www

RUN set -eux \
    && touch /etc/hello-msg.sh \
    && echo '[ -f /etc/hello-msg.sh ] && . /etc/hello-msg.sh' | tee -a /root/.bashrc /home/${DOCKER_USER}/.bashrc

USER ${DOCKER_USER}

ENV PATH="/home/${DOCKER_USER}/.composer/vendor/bin:${PATH}"
RUN set -eux \
    && composer global require phpstan/phpstan phpstan/extension-installer vimeo/psalm phpmd/phpmd friendsofphp/php-cs-fixer squizlabs/php_codesniffer --no-scripts \
    && composer clear-cache

