#!/bin/sh -e
git --version
cd ./ExampleWorkspace/ExampleApp
mkdir -p build
cd build
# rm -r ./*
cmake ..
make -j8

if [ "$(uname)" == "Darwin" ]; then
  cd ../../../Scripts
  sh xcode.sh
fi
