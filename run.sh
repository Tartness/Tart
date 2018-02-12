#!/bin/bash -e
cd ./ExampleWorkspace/ExampleApp
mkdir -p build
cd build
# rm -r ./*
cmake ..
make -j8

cd ..
./bin/*/ExampleApp
cd ../..

if [ "$(uname)" == "Darwin" ]; then
  cd Scripts
  sh xcode.sh
  cd ..
  cd ./ExampleWorkspace/ExampleFramework/build
  xcodebuild -scheme ExampleFramework | xcpretty
fi
