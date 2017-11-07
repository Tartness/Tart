CMAKE_MINIMUM_REQUIRED(VERSION 3.2)

# Include Tart Modules
INCLUDE("${CMAKE_CURRENT_LIST_DIR}/../../Modules/tart-include.cmake")

PROJECT("ExampleApp")

# ADD_EXECUTABLE("ExampleApp" "./main.cc")

ADD_TART_TARGET("ExampleApp")

# ADD_TART_DEPENDENCY("ExampleApp" "ExampleLibAAddTartDependencyExampleAppExampleLibB")
