CMAKE_MINIMUM_REQUIRED(VERSION 3.8)

PROJECT("KakeExample")

INCLUDE("${CMAKE_CURRENT_LIST_DIR}/../../Modules/yaml-parser.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_DIR}/../../Modules/configure-target.cmake")

ADD_EXECUTABLE("ExampleApp" "./main.cc")

ADD_DEPENDENCY("ExampleLib" "ExampleApp")
ADD_DEPENDENCY("Example2Lib" "ExampleApp")
