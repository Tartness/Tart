#!/bin/sh -e
cd ./ExampleWorkspace/ExampleApp
mkdir -p build
cd build
# rm -r ./*
cmake ..
make -j8

cd ../../ExampleFramework
mkdir -p build
cd build
cmake .. -GXcode
