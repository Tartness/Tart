FUNCTION(PARSE_YAML YAML_PATH)
  MESSAGE(STATUS "YAML_PATH: " ${YAML_PATH})
  FILE(STRINGS ${YAML_PATH} YAML_CONTENT)
  MESSAGE(STATUS "YAML_CONTENT: " ${YAML_CONTENT})

  SET(LAST_NODE_IS_LIST FALSE)

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
      IF(${LAST_NODE_IS_LIST})
        STRING(REPLACE "-" "" NODE_VALUE ${YAML_FILE_LINE})
        SET(NODE_NAME ${LIST_NODE_NAME})
      ELSE()
        MESSAGE(FATAL_ERROR "Unexpected symbol '-' found. There is no list at '" ${NODE_NAME} "'")
      ENDIF()
    ELSE()
      # We are dealing with a new node entry
      IF(${YAML_FILE_LINE} MATCHES "(.*):$")
        # We have detected a node that has no entries, i.e. it is the beginning of a list
        SET(LAST_NODE_IS_LIST TRUE)
        SET(NODE_VALUE "")
        # Store line if it was a node
        SET(LIST_NODE_NAME "${NODE_NAME}")
      ELSE()
        # we are dealing with a one-line node
        STRING(REPLACE "${NODE_NAME}: " "" NODE_VALUE ${YAML_FILE_LINE})
        SET(LAST_NODE_IS_LIST FALSE)
      ENDIF()
    ENDIF()

    # Set the variable
    IF(${LAST_NODE_IS_LIST})
       MESSAGE(STATUS ${LIST_NODE_NAME} ": ${${LIST_NODE_NAME}} ${NODE_VALUE}")
      SET(${LIST_NODE_NAME} "${${LIST_NODE_NAME}} ${NODE_VALUE}")
    ELSE()
      MESSAGE(STATUS ${NODE_NAME} ": ${NODE_VALUE}")
      SET(${NODE_NAME} "${NODE_VALUE}")
    ENDIF()
  ENDFOREACH()

  # # Uncomment to display all CMAKE variables:
  # GET_CMAKE_PROPERTY(VARIABLE_NAMES VARIABLES)
  # FOREACH (VARIABLE_NAME ${VARIABLE_NAMES})
  #    MESSAGE(STATUS "${VARIABLE_NAME}=${${VARIABLE_NAME}}")
  # ENDFOREACH()
ENDFUNCTION(PARSE_YAML)
