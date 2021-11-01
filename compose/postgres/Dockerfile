FROM postgres:13.4

LABEL maintainer = "Alexander Tebiev"

ENV CONTAINER_VERSION="2021.10.07"
ENV CONTAINER_TITLE="POSTGRES"
ENV CONTAINER_COPYRIGHT="Beeyev"
#Command bellow will be executed in motd via eval function, example: eval ${CONTAINER_HELLO_TEXT}
ENV CONTAINER_HELLO_TEXT="printf \"PostgreSQL Version: \${cGreen}\${PG_VERSION}\${cNo}\n\""

ENV TZ=${TZ}

# Enable hello banner
RUN set -eux \
        && touch /etc/hello-msg.sh && echo '[ -f /etc/hello-msg.sh ] && . /etc/hello-msg.sh' >> /root/.bashrc

RUN set -eux \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    mc \
    nano \
    unzip \
    inetutils-ping

RUN set -eux \
    && mkdir /var/log/postgres/ && chmod -R 777 /var/log/postgres/ && chown -R postgres:postgres /var/log/postgres/

# Cleanup
RUN set -eux \
    && apt-get clean -y \
    && apt-get autoremove --purge -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && rm /var/log/lastlog /var/log/faillog