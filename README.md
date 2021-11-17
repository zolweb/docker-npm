# npm and related build and dev tools

Fork of https://github.com/mkenney/docker-npm and fork of https://github.com/fernandoacorreia/docker-npm
Please feel free to [create an issue](https://github.com/zolweb/docker-npm/issues) or [open a pull request](https://github.com/zolweb/docker-npm/pull/new/master) if you need support or would like to contribute.

## Portable `node`, package managers and build tools

- [Tagged Images](#tagged-images)
- [About](#about)
- [Images](#images)
- [Installation](#installation)
- [Change log](#change-log)

## Announcements

2021-11-17

* add node v16

2020-07-27

* add node v12 and v14, remove node < 8

## Tagged Images

Images are tagged according to the installed Node version and operating system. Package versions are not pinned, instead [`npm`](https://npmjs.org/) is executed to install current versions of each package. If stability issues arise, I will pin package versions in a `Dockerfile` for that Node/OS version and create a image tagged as `stable` based on it. Please [let me know](https://github.com/zolweb/docker-npm/issues) if you run into this situation.

### Alpine

#### [`alpine`, `latest` Dockerfile](https://github.com/zolweb/docker-npm/blob/master/alpine/Dockerfile)

Based on [`node:alpine`](https://hub.docker.com/_/node/). This image should be considered under development and may not be as stable as versioned images.

#### [`node-14-alpine` Dockerfile](https://github.com/zolweb/docker-npm/blob/master/node-14-alpine/Dockerfile)

Based on [`node:14-alpine`](https://hub.docker.com/r/library/node/tags/14-alpine/).

...

#### [`node-12-alpine` Dockerfile](https://github.com/zolweb/docker-npm/blob/master/node-12-alpine/Dockerfile)


### Debian

#### [`debian` Dockerfile](https://github.com/zolweb/docker-npm/blob/master/debian/Dockerfile)

Based on [`node:latest`](https://hub.docker.com/r/library/node/tags/latest/). This image should be considered under development and may not be as stable as versioned images.

#### [`node-14-debian` Dockerfile](https://github.com/zolweb/docker-npm/blob/master/node-14-debian/Dockerfile)

Based on [`node:14-bullseye`](https://hub.docker.com/r/library/node/tags/14-bullseye/).

...

#### [`node-12-debian` Dockerfile](https://github.com/zolweb/docker-npm/blob/master/node-12-debian/Dockerfile)


## About

The docker image includes a script ([`run-as-user`](https://github.com/mkenney/docker-scripts/tree/master/container)) that allows commands to write files as either the current user or the owner/group of the current directory, which the shell scripts take advantage of to make sure files are created with your preferred permissions rather than root.

#### Images & Wrapper Scripts

The [images](https://hub.docker.com/r/zolweb/docker-npm/tags/) contain the latest stable `bower`, `generate-md`, `grunt`, `gulp`, `node`, `npm`, `npx`, and `yarn`, binaries for [`node`](https://hub.docker.com/_/node/).
The included [`run-as-user`](https://github.com/mkenney/docker-scripts/tree/master/container) script has three methods of determining which `uid` and `gid` to execute as:

* By default, it will execute with a `uid` and `gid` that matches the current directory (the one that gets mounted into `/src`).
* In order to take advantage of public key authentication when installing packages from private repositories, all the wrapper scripts will attempt to mount your `~/.ssh` directory into the container. When that is successful, the script will run as the `uid` and `gid` of the owner of `~/.ssh` (you).

  Most software that takes advantage of public key authentication protocols do so over SSH, and by default, send the current user name as the login name. Because this process is executing out of a segregated container, it knows nothing about the current user's name and will instead try to login as a user named `dev`. In order to work around this, you need to create a SSH configuration that specifies the correct username.

  In your `~/.ssh` folder create a file called `config`. In that file you need to specify the correct username. For example, to specify your login name for all hosts:

  ```txt
  Host *
      User mkenney
  ```

  You can easily be more explicit as well, specifying by host or with additional wildcards. [Google is your friend](https://duckduckgo.com/?q=ssh+config+file).

  ```txt
  Host github.com
      User mkenney
  ```

* You can also explicitly specify the `uid` and `gid` to use at runtime by defining the `PUID` and `PGID` environment variables when executing the container, this is quite useful in automated build systems:

  ```txt
  docker run \
      --rm \
      -it \
      -v $(pwd):/src:rw \
      -e "PUID=<user id>" \
      -e "PGID=<group id>" \
      mkenney/npm:latest <commands>
  ```

If you would to see like additional node modules and/or wrapper scripts added to this project please feel free to [create an issue](https://github.com/zolweb/docker-npm/issues) or [open a pull request](https://github.com/zolweb/docker-npm/pull/new/master).
