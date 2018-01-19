# STRIP_YAML_LINE()
# This function takes a raw yaml line as input and returns the stripped values
#     and the indentaton level
FUNCTION(STRIP_YAML_LINE LINE_STRING STRIPPED_LINE_STRING INDENTATION_LEVEL)
  # Strip comments form string
  STRING(REGEX REPLACE "\#.*$" "" LINE_STRING ${LINE_STRING})
  IF("${LINE_STRING}" STREQUAL "")
  # TART_DEBUG("Empty line found")
    SET(${INDENTATION_LEVEL} "-1" PARENT_SCOPE)
    SET(${STRIPPED_LINE_STRING} "" PARENT_SCOPE)
    RETURN()
  ENDIF()

  # Strip leading/trailing spaces and comments
  STRING(REGEX REPLACE "^[ ]+" "" LINE_STRING_NO_INDENT ${LINE_STRING})
  IF("${LINE_STRING_NO_INDENT}" STREQUAL "")
  # TART_DEBUG("Empty line found")
    SET(${INDENTATION_LEVEL} "-1" PARENT_SCOPE)
    SET(${STRIPPED_LINE_STRING} "" PARENT_SCOPE)
    RETURN()
  ENDIF()

  STRING(LENGTH ${LINE_STRING_NO_INDENT} LINE_LENGTH_STRIPPED)
  STRING(LENGTH ${LINE_STRING} LINE_LENGTH)
  MATH(EXPR INDENTATION "(${LINE_LENGTH} - ${LINE_LENGTH_STRIPPED}) / 2")

  STRING(REGEX REPLACE "[ \t]+$" "" LINE_STRING_NO_INDENT ${LINE_STRING_NO_INDENT})
  IF("${LINE_STRING_NO_INDENT}" STREQUAL "")
  # TART_DEBUG("Empty line found")
    SET(${INDENTATION_LEVEL} "-1" PARENT_SCOPE)
    SET(${STRIPPED_LINE_STRING} "" PARENT_SCOPE)
    RETURN()
  ENDIF()

  SET(${STRIPPED_LINE_STRING} "${LINE_STRING_NO_INDENT}" PARENT_SCOPE)
  SET(${INDENTATION_LEVEL} "${INDENTATION}" PARENT_SCOPE)
ENDFUNCTION(STRIP_YAML_LINE)

MACRO(LIST_REPLACE LIST INDEX NEW_VALUE)
  LIST(INSERT ${LIST} ${INDEX} ${NEW_VALUE})
  MATH(EXPR __INDEX "1 + 0${INDEX}")
  LIST(REMOVE_AT ${LIST} ${__INDEX})
ENDMACRO(LIST_REPLACE)

# NODE_TREE_NAMES()
# Create a A list of the tree hieerarchy name of each node
FUNCTION(NODE_TREE_NAMES NODE_NAMES NODE_INDENTS NODE_TREE_NAMES)
  SET(NODE_TREE_NAME_LIST "")
  LIST(LENGTH NODE_NAMES LIST_LENGTH)
  SET(NODE_INDEX 0)
  # FOREACH(NODE_NAME ${NODE_NAMES})
  WHILE(${NODE_INDEX} LESS ${LIST_LENGTH})
    LIST(GET NODE_NAMES ${NODE_INDEX} NODE_NAME)
    LIST(APPEND NODE_TREE_NAME_LIST ${NODE_NAME})
    # LIST(FIND NODE_NAMES ${NODE_NAME} NODE_INDEX)
    LIST(GET NODE_INDENTS ${NODE_INDEX} INDENT)
    SET(INDEX ${NODE_INDEX})
    SET(PREV_INDENT ${INDENT})
    SET(MIN_INDENT ${INDENT})

    WHILE(${INDEX} GREATER "0")
      MATH(EXPR INDEX "${INDEX} - 1")
      LIST(GET NODE_INDENTS ${INDEX} INDENT)
      LIST(GET NODE_NAMES ${INDEX} NODE_NAME)
      IF(${INDENT} LESS ${MIN_INDENT})
        LIST(GET NODE_TREE_NAME_LIST ${NODE_INDEX} CURRENT_TREE)
        LIST_REPLACE(NODE_TREE_NAME_LIST ${NODE_INDEX} "${NODE_NAME}>${CURRENT_TREE}")
        SET(MIN_INDENT ${INDENT})
      ENDIF()
    ENDWHILE()
    MATH(EXPR NODE_INDEX "1 + 0${NODE_INDEX}")
  ENDWHILE()
  # ENDFOREACH()
  SET(${NODE_TREE_NAMES} "${NODE_TREE_NAME_LIST}" PARENT_SCOPE)
ENDFUNCTION()


FUNCTION(FIND_LIST_VALUE VAR_NAME NAME_LIST VAL_LIST VAL_OUTPUT)
  LIST(FIND NAME_LIST ${VAR_NAME} INDEX)
  IF(${INDEX} EQUAL -1)
  # TART_DEBUG("var ${VAR_NAME} undefined..")
    RETURN()
  ENDIF()

  LIST(GET VAL_LIST ${INDEX} TMP)
  SET(${VAL_OUTPUT} "${TMP}" PARENT_SCOPE)
ENDFUNCTION(FIND_LIST_VALUE)

FUNCTION(FIND_LIST_SUBNODES VAR_NAME NAME_LIST VAL_LIST INDENT_LIST SUBNODE_OUTPUT_LIST)
  LIST(FIND NAME_LIST ${VAR_NAME} INDEX)
  IF(${INDEX} EQUAL -1)
  # TART_DEBUG("var ${VAR_NAME} undefined..")
    RETURN()
  ENDIF()

  LIST(GET INDENT_LIST ${INDEX} PARENT_NODE_INDENT)
    
  SET(REACHED_NEXT_NODE FALSE)
  LIST(LENGTH INDENT_LIST LIST_LENGTH)
  
  WHILE(NOT REACHED_NEXT_NODE)
    MATH(EXPR INDEX "1 + 0${INDEX}")

    LIST(GET INDENT_LIST ${INDEX} TMP)
    TART_DEBUG("ITERATION:")
    TART_DEBUG(${INDEX})
    TART_DEBUG(${TMP})
    IF(${PARENT_NODE_INDENT} GREATER ${TMP})
      LIST(GET NAME_LIST ${INDEX} SUBNODE_NAME)
      TART_DEBUG(${SUBNODE_NAME})
      LIST(APPEND SUBNODE_NAMES ${SUBNODE_NAME})
    ELSE()
      SET(REACHED_NEXT_NODE TRUE)
    ENDIF()
    IF(${INDEX} GREATER ${LIST_LENGTH})
      BREAK()
    ENDIF()
  ENDWHILE()
  
  SET(${SUBNODE_OUTPUT_LIST} "${SUBNODE_NAMES}" PARENT_SCOPE)
ENDFUNCTION(FIND_LIST_SUBNODES)