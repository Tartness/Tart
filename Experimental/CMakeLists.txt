CMAKE_MINIMUM_REQUIRED (VERSION 3.2)

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


# CHECK_IF_GIT_URL("https://github.com/Tartness/Tart.git" IS_GIT_URL)
# MESSAGE(${IS_GIT_URL})

PARSE_YAML("${CMAKE_CURRENT_LIST_DIR}/tart.yaml" NODE_NAMES NODE_VALS NODE_INDENTS)
# MESSAGE("${NODE_VALS}")
# MESSAGE("${NODE_NAMES}")
# MESSAGE("${NODE_INDENTS}")
# 
FIND_LIST_VALUE("dependency" "${NODE_NAMES}" "${NODE_VALS}" TARGET_PROPERTIES_LIST)
MESSAGE("${TARGET_PROPERTIES_LIST}")

GET_GIT_REPO_URL_AND_TAG_FROM_DETAILS("github;Tartness;1.0" "ExampleLibD" GIT_URL GIT_TAG)
MESSAGE(${GIT_URL})
MESSAGE(${GIT_TAG})


# ASSERT_LIB_AVAILABILITY("https://github.com/Tartness/ExampleLibD.git" "2.0" "${CMAKE_CURRENT_LIST_DIR}/../ExampleWorkspace")
