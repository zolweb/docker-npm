FROM node:18-alpine

LABEL org.label-schema.schema-version = 1.0.0 \
    org.label-schema.vendor = virgile@zol.fr \
    org.label-schema.vcs-url = https://github.com/zolweb/docker-npm \
    org.label-schema.description = "This image provides node based build tools." \
    org.label-schema.name = "NPM" \
    org.label-schema.url = https://github.com/zolweb/docker-npm

ENV TERM=xterm \
    NLS_LANG=FRENCH_FRANCE.UTF8 \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TIMEZONE=Europe/Paris
    
RUN set -x \
    && apk update \
    && apk add \
        acl \
        autoconf \
        automake \
        bash \
        binutils-gold \
        ca-certificates \
        curl \
        file \
        g++ \
        gcc \
        git \
        gnupg \
        lcms2-dev \
        libgcc \
        libpng-dev \
        libtool \
        linux-headers \
        make \
        mercurial \
        nasm \
        python2 \
        python3 \
        rsync \
        shadow \
        subversion \
        sudo

RUN set -x \
    && touch /root/.profile \
    && npm install --silent -g \
        gulp-cli \
        grunt-cli \
        bower \
        markdown-styles \
    && echo "export NLS_LANG=$(echo $NLS_LANG)"                >> /root/.profile \
    && echo "export LANG=$(echo $LANG)"                        >> /root/.profile \
    && echo "export LANGUAGE=$(echo $LANGUAGE)"                >> /root/.profile \
    && echo "export LC_ALL=$(echo $LC_ALL)"                    >> /root/.profile \
    && echo "export TERM=xterm"                                >> /root/.profile \
    && echo "export PATH=$(echo $PATH)"                        >> /root/.profile \
    && echo "cd /src"                                          >> /root/.profile \
    && echo "node:password" | chpasswd \
    && rsync -a /root/ /home/node/ \
    && chown -R node:node /home/node/ \
    && chmod 0777 /home/node \
    && chmod -R u+rwX,g+rwX,o+rwX /home/node \
    && setfacl -R -d -m user::rwx,group::rwx,other::rwx /home/node \
    && curl -o /run-as-user https://raw.githubusercontent.com/zolweb/docker-npm/master/context/run-as-user \
    && chmod 0755 /run-as-user

RUN set -x \
    && apk del \
        paxctl \
        rsync \
    && rm -rf \
        /var/cache/apk/* \
        ${NODE_PREFIX}/lib/node_modules/npm/man \
        ${NODE_PREFIX}/lib/node_modules/npm/doc \
        ${NODE_PREFIX}/lib/node_modules/npm/html


VOLUME /src
WORKDIR /src

ENTRYPOINT ["/run-as-user"]
CMD ["/usr/local/bin/npm"]
