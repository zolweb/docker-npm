#!/bin/bash
which curl
exit

COMMAND=$1
TAG=$2
PATH=$3

# Usage || [ "install.sh" == "$COMMAND" ]
if [ "" == "$COMMAND" ]; then
    echo "
    Usage
        $0 COMMAND [TAG [PATH]]

    Synopsys
        Install a command wrapper script locally

    Options
        COMMAND  - Required, the name of the command to install (bower, gulp, npm, etc.)
        TAG      - Optional, the image tag to use. Default 'latest'
        PATH     - Optional, the location to install the command script. Default '\$HOME/bin'

    Example
        $ curl -L https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/install.sh | bash -s gulp 7.0-debian \$HOME/bin
"
    exit 1
fi




#asdf

if [ "" == "$TAG" ]; then
    TAG=latest
fi
if [ "" == "$PATH" ]; then
    PATH=$HOME/bin
fi

# Download the requested script
SCRIPT=$(/usr/bin/curl -L https://raw.githubusercontent.com/mkenney/docker-npm/${TAG/latest/master}/bin/$COMMAND);
errors=$?

if [ 0 -lt $errors ]; then
    echo "Could not download '$COMMAND' from https://raw.githubusercontent.com/mkenney/docker-npm/${TAG/latest/master}/bin/$COMMAND"
    exit 1
fi
if [[ $SCRIPT == "*404: Not Found*" ]]; then
    echo $SCRIPT;
    echo "Please verify that the command and tag names are correct"
    exit 404
fi
if [ "" == $SCRIPT ]; then
    echo "Invalid $COMMAND script at https://raw.githubusercontent.com/mkenney/docker-npm/${TAG/latest/master}/bin/$COMMAND"
    exit 1
fi

# Install the requested script
echo $SCRIPT > $PATH/$COMMAND

echo "Install complete"
