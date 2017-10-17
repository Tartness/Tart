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

FIND_LIST_VALUE("target_arch_properties" "${NODE_NAMES}" "${NODE_VALS}" TARGET_PROPERTIES_LIST)
MESSAGE(${TARGET_PROPERTIES_LIST})

FIND_LIST_SUBNODES("target_arch_properties" "${NODE_NAMES}" "${NODE_VALS}" "${NODE_INDENTS}" SUBNODE_OUTPUT_LIST)
MESSAGE(${SUBNODE_OUTPUT_LIST})

# MESSAGE("${NODE_NAMES}")
# MESSAGE("${NODE_VALS}")
# MESSAGE("${NODE_INDENTS}")
