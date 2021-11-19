FROM node:14-bullseye

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
    && apt-get -qq update \
    && apt-get install -qqy apt-transport-https apt-utils \
    && apt-get -qq upgrade \
    && apt-get -qq dist-upgrade \
    && apt-get -qq update \
    && apt-get install -qqy \
        acl \
        autoconf \
        automake \
        bash \
        binutils-gold \
        ca-certificates \
        curl \
        dirmngr \
        file \
        g++ \
        gcc \
        git \
        gnupg \
        libatomic1 \
        liblcms2-dev \
        libpng-dev \
        libtool \
        make \
        mercurial \
        nasm \
        python2 \
        python3 \
        rsync \
        subversion \
        sudo \
        wget \
        xz-utils \
    && rm /bin/sh \
    && ln -s /bin/bash /bin/sh

RUN set -x \
    && npm install --silent --global \
        gulp-cli \
        grunt-cli \
        bower \
        markdown-styles

RUN set -x \
    && apt-get install -qqy locales \
    && locale-gen C.UTF-8 ${UTF8_LOCALE} \
    && dpkg-reconfigure locales \
    && /usr/sbin/update-locale LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8 \
    && export LANG=C.UTF-8 \
    && export LANGUAGE=C.UTF-8 \
    && export LC_ALL=C.UTF-8 \
    && echo $TIMEZONE > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

RUN set -x \
    && echo "export NLS_LANG=$(echo $NLS_LANG)"                >> /root/.bash_profile \
    && echo "export LANG=$(echo $LANG)"                        >> /root/.bash_profile \
    && echo "export LANGUAGE=$(echo $LANGUAGE)"                >> /root/.bash_profile \
    && echo "export LC_ALL=$(echo $LC_ALL)"                    >> /root/.bash_profile \
    && echo "export TERM=xterm"                                >> /root/.bash_profile \
    && echo "export PATH=$(echo $PATH)"                        >> /root/.bash_profile \
    && echo "cd /src"                                          >> /root/.bash_profile \
    && echo "source \$HOME/.bashrc"                            >> /root/.bash_profile \
    && echo "node:password" | chpasswd \
    && echo "node ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && rsync -a /root/ /home/node/ \
    && chown -R node:node /home/node/ \
    && chmod 0777 /home/node \
    && chmod -R u+rwX,g+rwX,o+rwX /home/node \
    && curl -o /run-as-user https://raw.githubusercontent.com/zolweb/docker-npm/master/context/run-as-user \
    && setfacl -R -d -m user::rwx,group::rwx,other::rwx /home/node

RUN set -x \
    && chmod 0755 /run-as-user \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

VOLUME /src
WORKDIR /src

ENTRYPOINT ["/run-as-user"]
CMD ["/usr/local/bin/npm"]
