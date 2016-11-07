#!/bin/bash

PREFIX="        "
project_path=$(dirname `pwd`)

cd $project_path
docker build -t mkenney/npm:ci-build .
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'docker build'"
fi

cd $project_path/test
build_result=0
output=$(sh node.sh);  echo $output; result=$?; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(sh bower.sh); echo $output; result=$?; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(sh npm.sh);   echo $output; result=$?; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(sh yarn.sh);  echo $output; result=$?; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(sh md.sh);    echo $output; result=$?; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(sh grunt.sh); echo $output; result=$?; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(sh gulp.sh);  echo $output; result=$?; if [ 0 -ne $result ]; then build_result=1; fi;

exit $build_result