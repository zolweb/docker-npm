#!/bin/bash

PREFIX="        "
project_path=$(dirname `pwd`)

cd $project_path/test/resources
rm -rf bower_components

output=$($project_path/bin/bower install)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'bower install'"
    exit $result
fi

output=$(ls bower_components)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'ls bower_components'"
    exit $result
fi

exit $result