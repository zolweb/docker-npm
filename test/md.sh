#!/bin/bash

PREFIX="        "
project_path=$(dirname `pwd`)

cd $project_path/test/resources
rm -rf html

output=$($project_path/bin/generate-md --input md --output html > /dev/null 2>&1)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'generate-md'"
    exit $result
fi

output=$(ls $project_path/test/resources/html)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'ls html'"
fi

exit $result