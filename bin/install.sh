#!/usr/bin/env sh

SELF=$0
COMMAND=$1
TAG=$2
PREFIX=$3

#
# Usage
#
function usage() {
    if [ "sh" == "$SELF" ]; then
        SELF="sh -s"
    fi

    echo "
    Usage
        $SELF COMMAND [TAG [PREFIX]]

    Synopsys
        Install a command wrapper script locally

    Options
        COMMAND  - Required, the name of the command to install (bower, gulp, npm, etc.)
        TAG      - Optional, the image tag to use. Default 'latest'
        PREFIX   - Optional, the location to install the command script. Default '\$HOME/bin'

    Examples
        $ curl -L https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/install.sh | sh -s gulp 7.0-debian \$HOME/bin
        $ sh ./install.sh gulp 7.0-debian \$HOME/bin
"
}

#
# COMMAND is a required argument
#
if [ "" == "$COMMAND" ] || [ "install.sh" == "$COMMAND" ]; then
    usage
    exit 1
fi

#
# Set defaults
#
if [ "" == "$TAG" ]; then
    TAG=latest
fi
if [ "" == "$PREFIX" ]; then
    PREFIX=$HOME/bin
fi

#
# Requre bourne shell
#
if [ "|sh|" = "|$0|" ] || echo $0 | grep -q 'install.sh'; then

    #
    # Download and validate the script
    #
    curl -s -L https://raw.githubusercontent.com/mkenney/docker-npm/${TAG/latest/master}/bin/$COMMAND > /tmp/$COMMAND
    if grep -q '404: Not Found' /tmp/$COMMAND; then
        usage
        echo "Installation failed: 404: Not Found";
        echo "Please verify that the COMMAND and TAG names are correct"
        exit 404
    fi
    exit_code=$?
    if [ 0 -lt $exit_code ]; then
        echo
        echo "Installation failed: Could not download '$COMMAND' from https://raw.githubusercontent.com/mkenney/docker-npm/${TAG/latest/master}/bin/$COMMAND"
        exit $exit_code
    fi
    if ! [ -s /tmp/$COMMAND ]; then
        echo
        echo "Installation failed: Invalid or empty '$COMMAND' script at https://raw.githubusercontent.com/mkenney/docker-npm/${TAG/latest/master}/bin/$COMMAND"
        exit $exit_code
    fi

    #
    # Create the installation directory
    #
    mkdir -p $PREFIX
    exit_code=$?
    if [ 0 -lt $exit_code ]; then
        echo
        echo "Installation failed: Could not create directory '$PREFIX'"
        exit $exit_code
    fi

    #
    # Cat the tempfile into the command file instead of moving it so that
    # symlinkys aren't destroyed
    #
    cat /tmp/$COMMAND > $PREFIX/$COMMAND && chmod +x $PREFIX/$COMMAND
    exit_code=$?
    if [ 0 -lt $exit_code ]; then
        echo
        echo "Installation failed: Could not update '$PREFIX/$COMMAND'"
        exit $exit_code
    fi

    #
    # Cleanup the tempfile
    #
    rm -f /tmp/$COMMAND
    exit_code=$?
    if [ 0 -lt $exit_code ]; then
        echo
        echo "Error: Could not delete tempfile '/tmp/$COMMAND'"
        exit $exit_code
    fi

    echo
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
    exit 1
fi

echo
echo "$PREFIX/$COMMAND: Installation failed"
exit 1
