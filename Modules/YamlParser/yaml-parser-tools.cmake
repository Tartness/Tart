# WHITESPACE_TO_DELIMETER()
# This function replaces whitespaces in a string
#     ...
FUNCTION(WHITESPACE_TO_DELIMETER YAML_ENTRY_STRING OUT_STRING)
  # SET(DELIMETER "&")
  # # Strip leading/trailing spaces and comments
  # STRING(REGEX REPLACE "[ ]" "${DELIMETER}" YAML_ENTRY_STRING ${YAML_ENTRY_STRING})
  # STRING(REGEX REPLACE "[:][&]+" ": " YAML_ENTRY_STRING ${YAML_ENTRY_STRING})  
  # STRING(REGEX REPLACE "[-][&]+" "- " YAML_ENTRY_STRING ${YAML_ENTRY_STRING})
  
  SET(${OUT_STRING} "${YAML_ENTRY_STRING}" PARENT_SCOPE)
ENDFUNCTION(WHITESPACE_TO_DELIMETER)

# GET_YAML_ENTRIES_WITH_INDENDTS()
# Function to parse a yaml file
FUNCTION(GET_YAML_ENTRIES_WITH_INDENDTS YAML_PATH ENTRIES ENTRY_INDENTS)
  FILE(STRINGS ${YAML_PATH} YAML_CONTENT)

  # Also add package directory path from the parsed yaml dir
  GET_FILENAME_COMPONENT(PACKAGE_PATH ${YAML_PATH} DIRECTORY)
  SET(ENTRY_LIST "package_path;${PACKAGE_PATH}")
  SET(ENTRY_INDENT_LIST "0;1")
  
  # Also add package version
  GET_LAST_GIT_TAG("${PACKAGE_PATH}" GIT_TAG)
  # TART_WARNING("${PACKAGE_VERSION}")
  LIST(APPEND ENTRY_LIST "package_version;${GIT_TAG}")
  LIST(APPEND ENTRY_INDENT_LIST "0;1")

  FOREACH(YAML_NODE ${YAML_CONTENT})
    STRIP_YAML_LINE(${YAML_NODE} YAML_NODE INDENTATION_LEVEL)
    IF("${YAML_NODE}" STREQUAL "")
    TART_DEBUG("Empty line found at YAML_NODE ${YAML_NODE}")
      CONTINUE()
    ENDIF()
    IF("${INDENTATION_LEVEL}" STREQUAL "-1")
      MESSAGE(FATAL_ERROR "Indentation level invalid for line '${YAML_NODE}'")
      CONTINUE()
    ENDIF()
    # Unused: if entries have whitespaces, then maybe use it again
    # WHITESPACE_TO_DELIMETER(${YAML_NODE} YAML_NODE)
    # Remove listing formats and colon:
    STRING(REGEX REPLACE "^[-][ ]" "" YAML_NODE ${YAML_NODE})
    STRING(REGEX REPLACE "[:]$" "" YAML_NODE ${YAML_NODE})
    # STRING(REPLACE "- " "" YAML_NODE ${YAML_NODE})
    
    IF("${YAML_NODE}" MATCHES "[.]*: ")
      # We are dealing with a "key: value" pair here
      STRING(REGEX REPLACE "^[^:]+[:][ ]" "" ENTRY_VALUE ${YAML_NODE})
      STRING(REGEX REPLACE "[:][ ][^:]+$" "" ENTRY_KEY ${YAML_NODE})
      
      MATH(EXPR VALUE_INDENT "1 + 0${INDENTATION_LEVEL}")
      
      # Append only entry key
      LIST(APPEND ENTRY_INDENT_LIST ${INDENTATION_LEVEL})
      LIST(APPEND ENTRY_LIST ${ENTRY_KEY})
      # Append Entry Value with one more indent (like single element list)
      LIST(APPEND ENTRY_INDENT_LIST ${VALUE_INDENT})
      LIST(APPEND ENTRY_LIST ${ENTRY_VALUE})
    ELSE()
    # Else, this line is either a list entry or a list key
      LIST(APPEND ENTRY_INDENT_LIST ${INDENTATION_LEVEL})
      LIST(APPEND ENTRY_LIST ${YAML_NODE})
    ENDIF()
  ENDFOREACH()

  SET(${ENTRIES} "${ENTRY_LIST}" PARENT_SCOPE)
  SET(${ENTRY_INDENTS} "${ENTRY_INDENT_LIST}" PARENT_SCOPE)
ENDFUNCTION(GET_YAML_ENTRIES_WITH_INDENDTS)

# GET_ENTRY_SUBTREE()
# Function to parse a yaml file
FUNCTION(GET_ENTRY_SUBTREE QUERY_ENTRY ENTRIES INDENTS CHILD_ENTRIES CHILD_INDENTS)
  LIST(FIND ENTRIES ${QUERY_ENTRY} QUERY_INDEX)
  LIST(LENGTH ENTRIES ENTRY_LIST_LENGTH)
  
  LIST(GET INDENTS ${QUERY_INDEX} QUERY_INDENT)

  MATH(EXPR CURRENT_INDEX "1 + 0${QUERY_INDEX}")
  IF(${CURRENT_INDEX} EQUAL ${ENTRY_LIST_LENGTH})
    # Max index is 1 larger than list length
    RETURN()
  ENDIF()
  LIST(GET INDENTS ${CURRENT_INDEX} CURRENT_INDENT)

  WHILE(${CURRENT_INDENT} GREATER ${QUERY_INDENT})
    IF(${CURRENT_INDEX} EQUAL ${ENTRY_LIST_LENGTH})
      # Max index is 1 larger than list length
      BREAK()
    ENDIF()
    LIST(APPEND INDENT_SUBLIST ${CURRENT_INDENT})
    LIST(GET ENTRIES ${CURRENT_INDEX} CURRENT_ENTRY)
    LIST(APPEND ENTRY_SUBLIST ${CURRENT_ENTRY})
    
    MATH(EXPR CURRENT_INDEX "1 + 0${CURRENT_INDEX}")
    LIST(GET INDENTS ${CURRENT_INDEX} CURRENT_INDENT)
  ENDWHILE()
  SET(${CHILD_INDENTS} "${INDENT_SUBLIST}" PARENT_SCOPE)
  SET(${CHILD_ENTRIES} "${ENTRY_SUBLIST}" PARENT_SCOPE)
ENDFUNCTION(GET_ENTRY_SUBTREE)

# GET_ENTRY_VALUES()
# Function to parse a yaml file
# TODO dont read vals for QUERY_ENTRY but all parent vals for subtree
FUNCTION(GET_ENTRY_VALUES QUERY_ENTRY ENTRIES ENTRY_INDENTS VALUES HAS_SUBTREE)
  TART_DEBUG("GET_ENTRY_VALUES with QUERY_ENTRY: ${QUERY_ENTRY}")

  LIST(FIND ENTRIES ${QUERY_ENTRY} QUERY_INDEX)
  LIST(LENGTH ENTRIES ENTRY_LIST_LENGTH)
  LIST(GET ENTRY_INDENTS ${QUERY_INDEX} QUERY_INDENT)
  MATH(EXPR CURRENT_INDEX "1 + 0${QUERY_INDEX}")
  IF(${CURRENT_INDEX} EQUAL ${ENTRY_LIST_LENGTH})
    # Max index is 1 larger than list length
    RETURN()
  ENDIF()
  LIST(GET ENTRY_INDENTS ${CURRENT_INDEX} CURRENT_INDENT)
  WHILE(${CURRENT_INDENT} GREATER ${QUERY_INDENT})
    LIST(GET ENTRIES ${CURRENT_INDEX} CURRENT_ENTRY)
    MATH(EXPR PARENT_INDENT "${CURRENT_INDENT} - 1")
    IF(${PARENT_INDENT} EQUAL ${QUERY_INDENT})
      LIST(APPEND VALUES_LIST ${CURRENT_ENTRY})
    ENDIF()
    
    MATH(EXPR CURRENT_INDEX "1 + 0${CURRENT_INDEX}")
    
    IF(${CURRENT_INDEX} EQUAL ${ENTRY_LIST_LENGTH})
      # Max index is 1 larger than list length
      BREAK()
    ENDIF()
    LIST(GET ENTRY_INDENTS ${CURRENT_INDEX} CURRENT_INDENT)
  ENDWHILE()
  SET(${VALUES} "${VALUES_LIST}" PARENT_SCOPE)
ENDFUNCTION(GET_ENTRY_VALUES)
