FROM node:latest

MAINTAINER Michael Kenney <mkenney@webbedlam.com>

# System update
RUN apt-get -q -y update

RUN apt-get -q -y install npm
RUN npm install -g gulp-cli
RUN npm install -g grunt-cli

RUN apt-get clean && rm -r /var/lib/apt/lists/*

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["npm"]
