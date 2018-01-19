#!/bin/bash -e
cd ./Experimental
mkdir -p build
cd build

cmake .. -DTART_TARGET_OS:STRING=macOS -DTART_TARGET_ARCH:STRING=X64
