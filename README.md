![Node.js](https://img.shields.io/badge/Node.js-v6.2.0-026e00.svg) ![npm](https://img.shields.io/badge/npm-v3.8.9-c12127.svg) ![MIT License](https://img.shields.io/github/license/mkenney/docker-npm.svg) ![Docker pulls](https://img.shields.io/docker/pulls/mkenney/npm.svg) ![Docker stars](https://img.shields.io/docker/stars/mkenney/npm.svg) ![Github issues](https://img.shields.io/github/issues-raw/mkenney/docker-npm.svg)

# Portable npm and related executables

The [image](https://hub.docker.com/r/mkenney/npm/) contains the latest `node` and `npm` binaries for [Debian:jessie](https://hub.docker.com/_/debian/). `npm` has been used to install `gulp-cli` and `grunt-cli` globally. The current directory is mounted into `/src` in the container and a wrapper script executes `npm` as a user who's `uid` and `gid` matches those properties on that directory. This way any output is written as the directory owner/group instead of root or a random user.

If you need additional modules and/or wrapper scripts (`bower`, etc.) [let me know](https://github.com/mkenney/docker-npm/issues).

## Breaking changes: 2016-05-25

I have added a wrapper script to the container that executes `npm`, `gulp` and `grunt` commands as a user who's `uid` and `gid` matches those properties on the current directory. This way any files are installed as the directory owner/group instead of root or a random user.

If you have been using the [previous version](https://github.com/mkenney/docker-npm/tree/deprecated) of this image and wrapper scripts, you likely will need to change the permissions of files created using those scripts. This command should take care of it for you but _make sure you understand what it will do **before** you run it_. I can't help you if you hose your system.

* From your **_project directory_**: `sudo chown -R $(stat -c '%u' .):$(stat -c '%g' .) ./`

If you need to use the [previous version](https://github.com/mkenney/docker-npm/tree/deprecated) of this image it is tagged as [deprecated](https://hub.docker.com/r/mkenney/npm/tags/) but the build is updated automatically when there are updates to [node:latest](https://hub.docker.com/_/node/) or [Debian:jessie](https://hub.docker.com/_/debian/).

# Source Repo

[mkenney/docker-npm](https://github.com/mkenney/docker-npm)

# Docker image

[mkenney/npm](https://hub.docker.com/r/mkenney/npm/) Based on [node:latest](https://hub.docker.com/_/node/) (debian:jessie)

# Commands

The following wrapper scripts are available in the source repository

* [npm](https://github.com/mkenney/docker-npm/blob/master/bin/npm)
* [gulp](https://github.com/mkenney/docker-npm/blob/master/bin/gulp)
* [grunt](https://github.com/mkenney/docker-npm/blob/master/bin/grunt)

# Tagged Dockerfiles
* [latest](https://github.com/mkenney/docker-npm/blob/master/Dockerfile)
* [deprecated](https://github.com/mkenney/docker-npm/blob/deprecated/Dockerfile)
