FROM node:latest

MAINTAINER Michael Kenney <mkenney@webbedlam.com>

RUN set -x \
    # System update
    && apt-get update \
    
    # Install npm (and its extra packages)
    && apt-get install -y \
                npm \
    
    # Cleanup apt cache
    && apt-get clean && rm -r /var/lib/apt/lists/* \
    
    # Install gulp and grunt
    && npm install -g \
                gulp-cli \
                grunt-cli

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["npm"]
