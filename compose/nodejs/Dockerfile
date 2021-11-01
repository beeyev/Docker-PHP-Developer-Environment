FROM node:16-alpine

LABEL maintainer="Alexander Tebiev"

ENV CONTAINER_VERSION="2021.10.07"
ENV CONTAINER_TITLE="node.js"
ENV CONTAINER_COPYRIGHT="Beeyev"
#Command bellow will be executed in motd via eval function, example: eval ${CONTAINER_HELLO_TEXT}
ENV CONTAINER_HELLO_TEXT="printf \"Node.js Version: \${cGreen}\${NODE_VERSION}\${cNo}\n\""

ENV TERM="xterm-256color"

RUN set -eux \
    && apk add --no-cache --upgrade \
    bash \
    mc \
    wget \
    coreutils \
    git \
    nano \
    tzdata \
    unzip

# Cleanup
RUN set -eux \
    && rm -rf /var/cache/apk/* \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Enable hello banner
RUN set -eux \
    && touch /etc/hello-msg.sh && echo '[ -f /etc/hello-msg.sh ] && . /etc/hello-msg.sh' >> /home/node/.bashrc

USER node