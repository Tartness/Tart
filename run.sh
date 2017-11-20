#!/bin/sh -e

echo "############################"
git --version
cmake --version
echo "############################"
echo ""

cd ./ExampleWorkspace/ExampleApp
mkdir -p build
cd build
# rm -r ./*
cmake ..
make -j8

./ExampleApp

if [ "$(uname)" == "Darwin" ]; then
  cd ../../../Scripts
  sh xcode.sh
fi
