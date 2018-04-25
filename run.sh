#!/bin/bash -e


sh ./tart ExampleWorkspace/ExampleApp

if [ "$(uname)" == "Darwin" ]; then
  cd Scripts
  sh xcode.sh
  cd ..
  cd ./ExampleWorkspace/ExampleFramework/build
  xcodebuild -scheme ExampleFramework | xcpretty
fi
