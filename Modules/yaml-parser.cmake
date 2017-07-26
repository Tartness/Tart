FUNCTION(PARSE_YAML YAML_PATH)
  MESSAGE(STATUS "YAML_PATH: " ${YAML_PATH})
  FILE(STRINGS ${YAML_PATH} YAML_CONTENT)
  MESSAGE(STATUS "YAML_CONTENT: " ${YAML_CONTENT})
  # Create a variable that i seen in parent scope
  SET(NODE_NAME_LIST "" CACHE INTERNAL "" FORCE)
  SET(NODE_VALUE_LIST "" CACHE INTERNAL "" FORCE)


  SET(LAST_NODE_IS_LISTING FALSE)

  FOREACH(YAML_FILE_LINE ${YAML_CONTENT})
    # MESSAGE(STATUS "YAML_FILE_LINE: " ${YAML_FILE_LINE})

    # Strip leading spaces
    STRING(REGEX REPLACE "^[ ]+" "" YAML_FILE_LINE ${YAML_FILE_LINE})
    STRING(REGEX REPLACE "\#.*$" "" YAML_FILE_LINE ${YAML_FILE_LINE})
    # MESSAGE(STATUS "stripped: " ${YAML_FILE_LINE})

    IF("${YAML_FILE_LINE}" STREQUAL "")
      # MESSAGE(STATUS "Empty line found")
      CONTINUE()
    ENDIF()

    # Find variable name
    STRING(REGEX MATCH "^[^:]+" NODE_NAME ${YAML_FILE_LINE})

    # Check if entry is part of a node list
    IF(${NODE_NAME} MATCHES "^-(.*)")
      # We are dealing with a list entry in the last node's NODE_NAME
      IF(${LAST_NODE_IS_LISTING})
        STRING(REPLACE "-" "" NODE_VALUE ${YAML_FILE_LINE})
        SET(NODE_NAME ${LISTING_NODE_NAME})
      ELSE()
        MESSAGE(FATAL_ERROR "Unexpected symbol '-' found. There is no list at '" ${NODE_NAME} "'")
      ENDIF()
    ELSE()
      # We are dealing with a new node entry
      IF(${YAML_FILE_LINE} MATCHES "(.*):$")
        # We have detected a node that has no entries, i.e. it is the beginning of a list
        SET(LAST_NODE_IS_LISTING TRUE)
        SET(NODE_VALUE "")
        # Store line if it was a node
        SET(LISTING_NODE_NAME "${NODE_NAME}")
      ELSE()
        # we are dealing with a one-line node
        STRING(REPLACE "${NODE_NAME}: " "" NODE_VALUE ${YAML_FILE_LINE})
        SET(LAST_NODE_IS_LISTING FALSE)
      ENDIF()
    ENDIF()

    # Set the exported list of variables
    IF(${LAST_NODE_IS_LISTING})
      MESSAGE(STATUS ${LISTING_NODE_NAME} ": ${${LISTING_NODE_NAME}} ${NODE_VALUE}")
      SET(${LISTING_NODE_NAME} "${${LISTING_NODE_NAME}} ${NODE_VALUE}")

    ELSE()
      MESSAGE(STATUS ${NODE_NAME} ": ${NODE_VALUE}")
      SET(${NODE_NAME} "${NODE_VALUE}")
      LIST(APPEND NODE_NAME_LIST ${NODE_NAME})
      LIST(APPEND NODE_VALUE_LIST ${NODE_VALUE})
    ENDIF()
  ENDFOREACH()

  MESSAGE("${NODE_NAME_LIST}")
  MESSAGE("${NODE_VALUE_LIST}")
  # # Uncomment to display all CMAKE variables:
  # GET_CMAKE_PROPERTY(VARIABLE_NAMES VARIABLES)
  # FOREACH (VARIABLE_NAME ${VARIABLE_NAMES})
  #    MESSAGE(STATUS "${VARIABLE_NAME}=${${VARIABLE_NAME}}")
  # ENDFOREACH()
ENDFUNCTION(PARSE_YAML)
