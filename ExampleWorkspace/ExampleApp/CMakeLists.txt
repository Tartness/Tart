CMAKE_MINIMUM_REQUIRED(VERSION 3.8)

PROJECT("ExampleApp")

INCLUDE("${CMAKE_CURRENT_LIST_DIR}/../../Modules/yaml-parser.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_DIR}/../../Modules/configure-target.cmake")

ADD_EXECUTABLE("ExampleApp" "./main.cc")

ADD_DEPENDENCY("ExampleLib" "ExampleApp")
ADD_DEPENDENCY("Example2Lib" "ExampleApp")


PARSE_YAML("${CMAKE_CURRENT_LIST_DIR}/../ExampleLib/tart.yaml" NODE_NAMES NODE_VALS NODE_INDENTS)

SET(A "0;1;1;2;2;2;1;0;1;2;1;2;2;2")
SET(AN "Title;A;B;1;2;3;C;SAW;Z;1;X;2;3;4")

NODE_TREE_NAMES("${AN}" "${A}" NODE_TREE_NAMES)

MESSAGE("${NODE_TREE_NAMES}")
