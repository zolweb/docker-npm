#!/usr/bin/env sh

COMMAND=$1
TAG=$2
PREFIX=$3

# Usage
if [ "" == "$COMMAND" ] || [ "install.sh" == "$COMMAND" ]; then
    echo "
    Usage
        $0 COMMAND [TAG [PREFIX]]

    Synopsys
        Install a command wrapper script locally

    Options
        COMMAND  - Required, the name of the command to install (bower, gulp, npm, etc.)
        TAG      - Optional, the image tag to use. Default 'latest'
        PREFIX   - Optional, the location to install the command script. Default '\$HOME/bin'

    Examples
        $ curl -L https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/install.sh | sh -s gulp 7.0-debian \$HOME/bin
        $ cat ./install.sh | sh -s gulp 7.0-debian \$HOME/bin
        $ chmod +x ./install.sh && ./install.sh gulp 7.0-debian \$HOME/bin
"
    exit 1
fi

# Defaults
if [ "" == "$TAG" ]; then
    TAG=latest
fi
if [ "" == "$PREFIX" ]; then
    PREFIX=$HOME/bin
fi

if [ "|sh|" = "|$0|" ] || echo $0 | grep -q 'install.sh'; then
    echo

    # Download and validate the script
    curl -s -L https://raw.githubusercontent.com/mkenney/docker-npm/${TAG/latest/master}/bin/$COMMAND > /tmp/$COMMAND

    if grep -q '404: Not Found' /tmp/$COMMAND; then
        echo "404: Not Found";
        echo "Please verify that the command and tag names are correct"
        exit 404
    fi
    errors=$?
    if [ 0 -lt $errors ]; then
        echo "Could not download '$COMMAND' from https://raw.githubusercontent.com/mkenney/docker-npm/${TAG/latest/master}/bin/$COMMAND"
        exit 1
    fi
    if ! [ -s /tmp/$COMMAND ]; then
        cat /tmp/$COMMAND
        echo "Invalid '$COMMAND' script at https://raw.githubusercontent.com/mkenney/docker-npm/${TAG/latest/master}/bin/$COMMAND"
        exit 1
    fi

    # Cat the tmpfile instead of moving it so that symlinkys aren't overwritten
    cat /tmp/$COMMAND > $PREFIX/$COMMAND \
        && chmod +x $PREFIX/$COMMAND

    errors=$?
    if [ 0 -lt $errors ]; then
        echo "Installation failed: Could not update '$PREFIX/$COMMAND'"
        exit 1
    fi

    # Cleanup
    rm -f /tmp/$COMMAND
    errors=$?
    if [ 0 -lt $errors ]; then
        echo "Error: Could delete tempfile '/tmp/$COMMAND'"
        exit 1
    fi

    echo "$PREFIX/$COMMAND: Installation succeeded"
    exit 0

else
    echo "
    Invalid shell: $0

    In order to ensure cross-platform consistency when using via this script, it
    should be executed via a Bourne Shell (sh) input pipe. Valid syntax includes:

    $ curl -L https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/install.sh | sh -s [script arguments]
    $ cat ./install.sh | sh -s [script arguments]
    $ chmod +x ./install.sh && ./install.sh [script arguments]
"
fi

echo "$PREFIX/$COMMAND: Installation failed"
exit 1
