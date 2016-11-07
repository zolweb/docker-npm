#!/bin/bash

PREFIX="        "
project_path=$(dirname `pwd`)

cd $project_path

output=$(docker build -t mkenney/npm:ci-build .)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'docker build'"
fi
exit $result