CMAKE_MINIMUM_REQUIRED (VERSION 3.8)

# Include Tart Modules
INCLUDE("${CMAKE_CURRENT_LIST_DIR}/../Modules/tart-include.cmake")

################################
# Experimental Executable
################################

PROJECT("Experimental")

################################
# Define Sources and Headers
################################

SET(SOURCES "${CMAKE_CURRENT_LIST_DIR}/main.cc")

PARSE_YAML("${CMAKE_CURRENT_LIST_DIR}/tart.yaml" NODE_NAMES NODE_VALS NODE_INDENTS)

ASSERT_LIB_AVAILABILITY("https://github.com/Tartness/ExampleLibD.git" "2.0" "${CMAKE_CURRENT_LIST_DIR}/../ExampleWorkspace")
