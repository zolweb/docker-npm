#!/bin/bash

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
        $ curl -L https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/install.sh | /bin/bash gulp 7.0-debian \$HOME/bin
"
#    exit 1
fi


echo $0 $COMMAND $TAG $PATH


#asdf

if [ "" == "$TAG" ]; then
    TAG=latest
fi
if [ "" == "$PATH" ]; then
    PATH=$HOME/bin
fi
#echo $0 $COMMAND $TAG $PATH

# Install wrapper script
#mkdir -p $PATH
#echo "curl -L https://raw.githubusercontent.com/mkenney/docker-npm/${TAG/latest/master}/bin/install.sh | bash $COMMAND $TAG $PATH"
#curl -L https://raw.githubusercontent.com/mkenney/docker-npm/${TAG/latest/master}/bin/install.sh | bash  $COMMAND $TAG $PATH
#\
#    && cat /tmp/$COMMAND > $PATH/$COMMAND \
#    && rm -f /tmp/$COMMAND \
#    && exit 0

echo "Install failed"
exit 1
