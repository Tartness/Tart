CMAKE_MINIMUM_REQUIRED(VERSION 3.2)

PROJECT("ExampleApp")

# Include Tart Modules
INCLUDE("${CMAKE_CURRENT_LIST_DIR}/../../Modules/tart-include.cmake")

GENERATE_TART_TARGET("ExampleApp")
