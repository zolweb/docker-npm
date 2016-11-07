#!/bin/bash

PREFIX="        "
project_path=$(dirname `pwd`)

cd $project_path/test/resources
rm -rf node_modules

output=$($project_path/bin/npm install)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'npm install'"
    exit $result
fi

output=$(ls node_modules)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'ls node_modules'"
    exit $result
fi

exit $result