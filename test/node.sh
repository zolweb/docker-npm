#!/bin/bash

PREFIX="        "
project_path=$(dirname `pwd`)

cd $project_path/test/resources
rm -rf node_modules

output=$($project_path/bin/node --version)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'node --version'"
fi
exit $result