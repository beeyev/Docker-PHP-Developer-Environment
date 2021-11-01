FROM mysql:8.0

LABEL maintainer="Alexander Tebiev"

ENV CONTAINER_VERSION="2021.10.07"
ENV CONTAINER_TITLE="MySQL"
ENV CONTAINER_COPYRIGHT="Beeyev"
#Command bellow will be executed in motd via eval function, example: eval ${CONTAINER_HELLO_TEXT}
ENV CONTAINER_HELLO_TEXT="printf \"MySQL Version: \${cGreen}\${MYSQL_VERSION}\${cNo}\n\""

ENV TERM="xterm-256color"

RUN set -eux \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    mc \
    nano \
    unzip \
    inetutils-ping \
    #curl and lsb-release are required for Percona toolkit
    curl \
    lsb-release


#A command line client for MySQL that can do auto-completion and syntax highlighting.
#@see https://github.com/dbcli/mycli
RUN set -eux \
    && apt-get update && apt-get install -y mycli


# Percona toolkit install
# @see https://www.percona.com/doc/percona-toolkit/LATEST/index.html
ADD  https://repo.percona.com/apt/percona-release_latest.generic_all.deb /tmp/percona-release_latest.generic_all.deb
RUN set -eux \
    && dpkg -i /tmp/percona-release_latest.generic_all.deb && rm /tmp/percona-release_latest.generic_all.deb \
    && apt-get update && apt-get install -y --no-install-recommends percona-toolkit

# Initialize phpMyAdmin configuration storage
# @see https://docs.phpmyadmin.net/en/latest/setup.html#phpmyadmin-configuration-storage
ADD https://raw.githubusercontent.com/phpmyadmin/phpmyadmin/master/sql/create_tables.sql /docker-entrypoint-initdb.d
RUN set -eux \
    && chmod 755 /docker-entrypoint-initdb.d/create_tables.sql && sync

# Enable hello banner
RUN set -eux \
        && touch /etc/hello-msg.sh && echo '[ -f /etc/hello-msg.sh ] && . /etc/hello-msg.sh' >> /root/.bashrc

# Cleanup
RUN set -eux \
    && apt-get clean -y \
    && apt-get autoremove --purge -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && rm /var/log/lastlog /var/log/faillog