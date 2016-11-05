#!/bin/bash

if [ "" == "$COMMAND" ] || [ "install.sh" == "$COMMAND" ]; then
    echo "
    Usage
        [VARS] $0

    Synopsys
        COMMAND=command to install [TAG=image tag] [PATH=installation path] $0

    Vars
        COMMAND  - Required, the name of the command to install (bower, gulp, npm, etc.)
        TAG      - Optional, the image tag to use. Default 'latest'
        PATH     - Optional, the location to install the command script. Default '\$HOME/bin'

    Example
        $ COMMAND=gulp TAG=7.0-debian PATH=\$HOME/bin bash -c 'curl -L https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/install.sh | /bin/bash'
"
    exit 1
fi

if [ "" == "$TAG" ]; then
    TAG=latest
fi
if [ "" == "$PATH" ]; then
    PATH=$HOME/bin
fi

# Install wrapper script
mkdir -p $PATH
curl -L https://raw.githubusercontent.com/mkenney/docker-npm/${TAG/latest/master}/bin/$COMMAND > /tmp/$COMMAND \
    && cat /tmp/$COMMAND > $PATH/$COMMAND \
    && rm -f /tmp/$COMMAND \
    && exit 0

echo "Install failed"
exit 1
