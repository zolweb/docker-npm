FROM mkenney/npm:node-8-alpine

RUN apk add --update \
    bash \
    lcms2-dev \
    libpng-dev \
    gcc \
    g++ \
    make \
    autoconf \
    automake \
    libtool \
    nasm \
  && rm -rf /var/cache/apk/*