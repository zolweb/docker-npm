# npm

[![dockeri.co](http://dockeri.co/image/mkenney/npm)](https://hub.docker.com/r/mkenney/npm/)

[![MIT License](https://img.shields.io/github/license/mkenney/docker-npm.svg)](https://raw.githubusercontent.com/mkenney/docker-npm/master/LICENSE)
[![Github issues](https://img.shields.io/github/issues-raw/mkenney/docker-npm.svg)](https://github.com/mkenney/docker-npm/issues)
[![build status](https://travis-ci.org/mkenney/docker-npm.svg?branch=master)](https://travis-ci.org/mkenney/docker-npm)

## Portable `node`, package managers and build tools

- [Tagged Dockerfiles](#tagged-dockerfiles)
- [Installation](#installation)
- [Images](#images)
- [Change log](#change-log)

### Tagged Dockerfiles

In order to keep them small and lightweight, the `alpine` based images do not include build tools like `make`, `gcc`, `g++` and the like, so some packages that require them like `node-sass` or `node-gyp` won't work out of the box. However, the more robust `debian` based images do include those tools and should meet those needs.

* [`latest`, `alpine` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/Dockerfile)

  ![Image size](https://img.shields.io/badge/image size-69MB-blue.svg) This image is under development and may not be as stable as versioned images. This image is based on a recent version of [alpine](https://hub.docker.com/_/alpine/) and compiles a recent version of `node` from source. Package versions are not pinned, instead `https://npmjs.org/install.sh` is executed to install a current version of `npm`, which is then used to install current versions of the packages.

* [`debian` Dockerfile](https://github.com/mkenney/docker-npm/blob/master/Dockerfile)

  ![Image size](https://img.shields.io/badge/image size-301MB-blue.svg) This image is under development and may not be as stable as versioned images. This image is based on [`node:latest`](https://hub.docker.com/r/library/node/tags/latest/). Package versions are not pinned, instead the included `npm` executable is used to install current versions of the packages.

* [`7.0-alpine` Dockerfile](https://github.com/mkenney/docker-npm/blob/7.0-alpine/Dockerfile)

  ![Image size](https://img.shields.io/badge/image size-69MB-blue.svg) Based on [`alpine:3.4`](https://hub.docker.com/r/library/alpine/tags/3.4/) with `node` v7.0 compiled from source.

* [`7.0-debian` Dockerfile](https://github.com/mkenney/docker-npm/blob/7.0-debian/Dockerfile)

  ![Image size](https://img.shields.io/badge/image size-301MB-blue.svg) Based on[`node:7.0-wheezy`](https://hub.docker.com/r/library/node/tags/6.9-wheezy/).

### About

Essentially, this is just a set of [shell scripts](https://github.com/mkenney/docker-npm/tree/master/bin) that manages a [Node.js](https://nodejs.org/) docker image. The docker image includes a script that allows commands to run as either the current user or the owner/group of the current directory, which the shell scripts take advantage of to make sure files are written with appropriate permissions rather than root.

#### Installation

This assumes that you already have [Docker](https://www.docker.com) installed. A running `docker` daemon is required. You probably want to be able to [run docker commands without sudo](https://docs.docker.com/v1.8/installation/ubuntulinux/#create-a-docker-group), but even if you excute the scripts with sudo files will be written with the appropriate `uid` and `gid`.

The following wrapper scripts are available in the source repository:

* [`bower`](https://github.com/mkenney/docker-npm/blob/master/bin/bower)
* [`generate-md`](https://github.com/mkenney/docker-npm/blob/master/bin/generate-md)
* [`grunt`](https://github.com/mkenney/docker-npm/blob/master/bin/grunt)
* [`gulp`](https://github.com/mkenney/docker-npm/blob/master/bin/gulp)
* [`node`](https://github.com/mkenney/docker-npm/blob/master/bin/node)
* [`npm`](https://github.com/mkenney/docker-npm/blob/master/bin/npm)
* [`yarn`](https://github.com/mkenney/docker-npm/blob/master/bin/yarn)

Installation is just a matter of putting them somewhere in your path and making them executable. I like to put my scripts in a `bin/` folder in my home directory. You can easily install the scripts using this command, just adjust the `command`, `install_path` and `tag` values as needed:

```sh
$ command=gulp \
  install_path=$HOME/bin \
  tag=7.0-debian \
  bash -c 'wget -nv -O $install_path/$command https://raw.githubusercontent.com/mkenney/docker-npm/${tag/latest/master}/bin/$command && chmod 0755 $install_path/$command'
```

##### Updating

* `bower self-update`
* `generate self-update`
* `grunt self-update`
* `gulp self-update`
* `node self-update`
* `npm self-update`

Each of the scripts have a `self-update` command which pulls down the latest docker image (which all the scripts share) and then updates the shell script itself. If you don't have write permissions on the shell script you'll get a permissions error, you can run the self-update command with `sudo` if needed. At the time of this writing, I expect the shell scripts, which couldn't be much simpler, probably won't change so a simple `docker pull mkenney/npm:{version}` should generally be enough.

### Images

These [images](https://hub.docker.com/r/mkenney/npm/tags/) contain the latest stable `node` and `npm` binaries for [`debian:jessie`](https://hub.docker.com/_/debian/) and [`alpine:3.4`](https://hub.docker.com/_/alpine/). `npm` has been used to install various build tools globally. When using the [shell scripts](https://github.com/mkenney/docker-npm/tree/master/bin) available in the [source repository](https://github.com/mkenney/docker-npm), the current directory is mounted into `/src` in the container and a [wrapper script](https://github.com/mkenney/docker-scripts/blob/master/container/run-as-user) executes `npm` as a user who's `uid` and `gid` matches those properties on that directory. This way any output is written as the directory owner/group instead of root or a random user.

If you need additional modules and/or wrapper scripts [let me know](https://github.com/mkenney/docker-npm/issues).

### Change log

#### 2016-11-02

* Upgraded `node` to 7.0.0 in the `alpine` image.
* Created "stable" branches for the 7.0 images

#### 2016-10-20

Added support for the `yarn` package manager. Please [let me know](https://github.com/mkenney/docker-phpunit/issues) if you have any problems.

#### 2016-09-17

Because it produces a much smaller image, I have moved the Alpine build into the `master` branch and the Debian build into it's own `debian` branch and made corresponding changes on [hub.docker.com](https://hub.docker.com/r/mkenney/npm/).

Added the `--allow-root` option to the `bower` script to resolve [issue #4](https://github.com/mkenney/docker-npm/issues/4).

Merged [a PR](https://github.com/mkenney/docker-npm/pull/5) to prevent ssl certificate issues in `self-update` commands.

Updated the `self-update` command in the scripts to resolve [issue #8](https://github.com/mkenney/docker-npm/issues/8).

#### 2016-08-29

Added a markdown-to-html generator for static documentation ([`markdown-styles`](https://www.npmjs.com/package/markdown-styles)) and a script to run it ([`generate-md`](https://github.com/mkenney/docker-npm/blob/master/bin/generate-md)).

Removed the dev user from the root group, the way it was setup new files were owned by root because it was the default group. Please [let me know](https://github.com/mkenney/docker-npm/issues) if that change causes any issues.

#### 2016-07-13

Re-structured automated the Docker Hub builds, they are no longer triggered by GitHub pushes. Instead they are triggered by a deployment script that is executed on successful `travis-ci` builds. This way, even if builds are failing the image on DockerHub should remain the last stable image at all times.

There may be an issue with API call throttling on the Docker Hub side, if that seems to be happening I'll dig in further.

Fixed an issue with the path in the source URL that had been preventing successuful alpine builds for a few days.

Please [let me know](https://github.com/mkenney/docker-phpunit/issues) if you have any problems.

#### 2016-07-05

Fixed a string-comparison issue on logins where the default shell is Bourne shell rather than Bourne again shell.

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you have any problems.

#### 2016-06-29

Added updating `npm` to the latest stable version in the `debian` image. I changed to compiling `node` from source in the `alpine` image because the version installed by `n` was compiled with a different prefix than the `apk` packages which made a mess. I also to use the same prefix as the `node:latest` image.

I also added some simple checks to the travis-ci configuration to catch the issue I found the other day with the missing `shadow` package.

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you run into any problems.

#### 2016-06-28

alpine:latest doesn't have the `shadow` available (at the moment) so the `/run-as-user` script wasn't functioning correctly. I added the `edge/testing` repo, installed `shadow` and also went ahead and updated `npm` to the latest available version (`3.10.2`).

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you run into any problems.

#### 2016-06-23

* Added `bower` to the image and a [wrapper script](https://github.com/mkenney/docker-npm/blob/master/bin/bower) to the repository.
* Added a `node` [wrapper script](https://github.com/mkenney/docker-npm/blob/master/bin/node) to the repository.
* Added mounting your `~/.ssh/` directory into the container to support access to private repositories. If that directory is mounted, then `npm` and `bower` will run as the `uid`/`gid` that owns that `~/.ssh/` directory (hopefully you), otherwise it will run as the project directories `uid` and `gid` as usual.
* Updated all the wrapper scripts to use variables for the image tag and github branch to make merges simpler
* Created a [tagged](https://hub.docker.com/r/mkenney/npm/tags/) version of the image based on [`alpine:latest`](https://hub.docker.com/_/alpine/)

Please [let me know](https://github.com/mkenney/docker-npm/issues) if you run into any problems.

#### 2016-06-06

I modified the `run-as-user` script so that it doesn't require specifying which user account in the container that should be modified, and instead will always modify the `dev` user. This required updating both the image and the wrapper scripts, if you use the wrapper scripts you should run:
* `sudo npm self-update`
* `sudo gulp self-update`
* `sudo grunt self-update`

#### 2016-06-03

I removed the `as-user` script and put it in a [separate repo](https://github.com/mkenney/docker-scripts/blob/master/container/run-as-user) as it's used in several images. [Let me know](https://github.com/mkenney/docker-npm/issues) if you have any trouble, this is the first image I've switched over.

#### 2016-05-25

##### Breaking changes

I have added a wrapper script to the container that executes `npm`, `gulp` and `grunt` commands as a user who's `uid` and `gid` matches those properties on the current directory. This way any files are installed as the directory owner/group instead of root or a random user.

If you've been using the [previous version](https://github.com/mkenney/docker-npm/tree/deprecated/bin) of the included shell scripts from the project's `/bin` directory you will probably need to update the permissions of files created using them or the new scripts are likely to have permissions errors because previously the files would have been created by the `root` user. This command should take care of it for you but _make sure you understand what it will do **before** you run it_. I can't help you if you hose your system.

* From your **_project directory_**: `sudo chown -R $(stat -c '%u' .):$(stat -c '%g' .) ./`

If you haven't been using the included scripts, then you don't need to do anything.

If you need to use the [previous version](https://github.com/mkenney/docker-npm/tree/deprecated) of this image it's [tagged](https://hub.docker.com/r/mkenney/npm/tags/) as `deprecated` but the image is still rebuilt automatically when there are changes to [node:latest](https://hub.docker.com/_/node/) or [Debian:jessie](https://hub.docker.com/_/debian/) so it will stay up to date.

### Source Repo

[mkenney/docker-npm](https://github.com/mkenney/docker-npm)
