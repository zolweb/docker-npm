#!/bin/bash

PREFIX="        "
project_path=$(dirname `pwd`)

cd $project_path/test/resources
rm -rf node_modules

$project_path/bin/npm install > /dev/null 2>&1
output=$($project_path/bin/grunt)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'grunt'"
fi
exit $result