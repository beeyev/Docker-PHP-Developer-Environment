FROM rabbitmq:3.9-management-alpine

LABEL maintainer = "Alexander Tebiev"

ENV TERM="xterm-256color"

RUN set -eux \
    && apk add --no-cache --upgrade \
    bash \
    mc \
    coreutils \
    nano \
    tzdata \
    unzip

# Cleanup
RUN set -eux \
    && rm -rf /var/cache/apk/* \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

