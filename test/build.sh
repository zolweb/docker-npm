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

cd $project_path/test
build_result=0
output=$(sh node.sh);  result=$?; if [ 0 -ne $result ]; then build_result=1; fi; echo $output;
output=$(sh bower.sh); result=$?; if [ 0 -ne $result ]; then build_result=1; fi; echo $output;
output=$(sh npm.sh);   result=$?; if [ 0 -ne $result ]; then build_result=1; fi; echo $output;
output=$(sh yarn.sh);  result=$?; if [ 0 -ne $result ]; then build_result=1; fi; echo $output;
output=$(sh md.sh);    result=$?; if [ 0 -ne $result ]; then build_result=1; fi; echo $output;
output=$(sh grunt.sh); result=$?; if [ 0 -ne $result ]; then build_result=1; fi; echo $output;
output=$(sh gulp.sh);  result=$?; if [ 0 -ne $result ]; then build_result=1; fi; echo $output;

exit $build_result