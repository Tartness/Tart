CMAKE_MINIMUM_REQUIRED(VERSION 3.2)

# Include Tart Modules
INCLUDE("${CMAKE_CURRENT_LIST_DIR}/../Modules/tart-include.cmake")

################################
# Test Tart Methods
################################

PROJECT("Tart Test")

################################
# Define Sources and Headers
################################

SET(SOURCES "${CMAKE_CURRENT_LIST_DIR}/main.cc")
SET(TART_CURRENT_WORKSPACE_DIR "${CMAKE_CURRENT_LIST_DIR}/Tart-Packages/")
SET(TART_TARGET_OS "macOS")
ADD_EXECUTABLE("Experiment" "${CMAKE_CURRENT_LIST_DIR}/src/main.cc")

GET_YAML_ENTRIES_WITH_INDENDTS("${CMAKE_CURRENT_LIST_DIR}/tart.yaml" ENTRIES ENTRY_INDENTS)
GET_PACKAGE_FILES("${CMAKE_CURRENT_LIST_DIR}" SRC INCL)
# PROCESS_DEPENDENCY_ENTRIES("Experiment" "${ENTRIES}" "${ENTRY_INDENTS}")
ADD_PREINSTALLED_PACKAGE("OpenGL" "Experiment")
