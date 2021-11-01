FROM nginx:mainline-alpine

LABEL maintainer="Alexander Tebiev"

ENV CONTAINER_VERSION="2021.10.07"
ENV CONTAINER_TITLE="NGINX"
ENV CONTAINER_COPYRIGHT="Beeyev"
#Command bellow will be executed in motd via eval function, example: eval ${CONTAINER_HELLO_TEXT}
ENV CONTAINER_HELLO_TEXT="printf \"Nginx Version: \${cGreen}\${NGINX_VERSION}\${cNo}\n\""

ENV TERM="xterm-256color"
ENV PUBLIC_DIR=${PUBLIC_DIR}

RUN set -eux \
        && apk update \
        && apk add --no-cache --upgrade bash mc nano curl wget coreutils \
        && touch /etc/hello-msg.sh && echo '[ -f /etc/hello-msg.sh ] && . /etc/hello-msg.sh' >> /root/.bashrc \
        && rm -rf /var/cache/apk/*