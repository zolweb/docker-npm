FROM alpine:latest

MAINTAINER Michael Kenney <mkenney@webbedlam.com>

ENV PATH /root/bin:$PATH
ENV NLS_LANG American_America.AL32UTF8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8
ENV TIMEZONE America/Denver

RUN set -x \
    && apk update \
    && apk add --no-cache --repository "http://dl-cdn.alpinelinux.org/alpine/edge/testing"  \
        ca-certificates \
        curl \
        git \
        mercurial \
        openssh \
        shadow \
        subversion \
        sudo \
    && update-ca-certificates \

##############################################################################
# Install Node & NPM
##############################################################################

    && apk add \
        nodejs \

    && npm install --silent -g npm \
    && npm install --silent -g \
        bower \
        grunt-cli \
        gulp-cli \

    # Create links to work with the original wrapper scripts so don't need
    # path changes between branches
    && mkdir -p /usr/local/bin \
    && ln -s /usr/bin/node /usr/local/bin/node \
    && ln -s /usr/bin/npm /usr/local/bin/npm \
    && ln -s /usr/bin/bower /usr/local/bin/bower \
    && ln -s /usr/bin/gulp /usr/local/bin/gulp \
    && ln -s /usr/bin/grunt /usr/local/bin/grunt \

##############################################################################
# users
##############################################################################

    # Create a dev user to use as the directory owner
    && addgroup dev \
    && adduser -D -s /bin/sh -G dev -G root dev \
    && echo "dev:password" | chpasswd \

    # Setup wrapper scripts
    && curl -o /run-as-user https://raw.githubusercontent.com/mkenney/docker-scripts/master/container/run-as-user \
    && chmod 0755 /run-as-user \

##############################################################################
# ~ fin ~
##############################################################################

    && apk del curl

VOLUME /src
WORKDIR /src

CMD ["/run-as-user", "/usr/local/bin/npm"]
