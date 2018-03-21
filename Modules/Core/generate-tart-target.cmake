# GENERATE_TART_TARGET() adds a target to the current 
# cmake generated project
FUNCTION(GENERATE_TART_TARGET PACKAGE_NAME)
  SET(EXTRA_MACRO_ARGS ${ARGN})

  # DID WE GET ANY OPTIONAL ARGS?
  LIST(LENGTH EXTRA_MACRO_ARGS NUM_EXTRA_ARGS)
  IF(${NUM_EXTRA_ARGS} GREATER 0)
    LIST(GET EXTRA_MACRO_ARGS 0 OPTIONAL_ARG)
    SET(ENFORCED_BIN_TYPE "${OPTIONAL_ARG}")
  ELSE()
    SET(ENFORCED_BIN_TYPE "")
  ENDIF()
  
  TART_INFO("Adding package '${PACKAGE_NAME}' to generated project")
  FIND_PACKAGE_TART_YAML_FILEPATH("${TART_CURRENT_WORKSPACE_DIR}" ${PACKAGE_NAME} PACKAGE_DIR)
  GET_YAML_ENTRIES_WITH_INDENDTS("${PACKAGE_DIR}/tart.yaml" ENTRIES ENTRY_INDENTS)
  
  IF("${ENFORCED_BIN_TYPE}" STREQUAL "")
    GET_ENTRY_VALUES("binary_type" "${ENTRIES}" "${ENTRY_INDENTS}" BIN_TYPE HAS_SUBTREE)
    SET(ENFORCED_BIN_TYPE ${BIN_TYPE})
  ENDIF()
  SET_PACKAGE_SOURCE_FILES("${PACKAGE_DIR}" "${ENTRIES}" "${ENTRY_INDENTS}" LIB_SOURCES INCLUDE_DIR)
  TART_DEBUG("${PACKAGE_NAME} sources: ${LIB_SOURCES}")
  STRING(TOLOWER "${ENFORCED_BIN_TYPE}" ENFORCED_BIN_TYPE)
  IF(${ENFORCED_BIN_TYPE} STREQUAL "library")
    ADD_LIBRARY(${PACKAGE_NAME} STATIC ${LIB_SOURCES})
  ELSEIF(${ENFORCED_BIN_TYPE} STREQUAL "shared")
    ADD_LIBRARY(${PACKAGE_NAME} SHARED ${LIB_SOURCES})
  ELSEIF(${ENFORCED_BIN_TYPE} STREQUAL "static")
    ADD_LIBRARY(${PACKAGE_NAME} STATIC ${LIB_SOURCES})
  ELSEIF(${ENFORCED_BIN_TYPE} STREQUAL "executable")
    ADD_EXECUTABLE(${PACKAGE_NAME} ${LIB_SOURCES})
  ELSE()
    # Defaults to static library
    ADD_LIBRARY(${PACKAGE_NAME} STATIC ${LIB_SOURCES})
  ENDIF()
  
  SET_PACKAGE_HEADER_FILES("${PACKAGE_NAME}" "${PACKAGE_DIR}" "${ENTRIES}" "${ENTRY_INDENTS}")

  # SET_TARGET_PROPERTIES(${PACKAGE_NAME} PROPERTY CXX_STANDARD 14)
  

  PROCESS_PACKAGE_PROPERTIES(${PACKAGE_NAME} "${ENTRIES}" "${ENTRY_INDENTS}")
  PROCESS_PACKAGE_COMPILE_DEFINITIONS(${PACKAGE_NAME} "${ENTRIES}" "${ENTRY_INDENTS}")
  SET_DEFAULT_PROPERTIES(${PACKAGE_NAME})

  # TODO(nidegen) implement following:
  # IF(GENERATOR_IS_XCODE)
  #   INHERIT_XCODE_COMPILATION_OPTIONS(${PARENT_BUILD_TARGET} ${PACKAGE_NAME})
  # ENDIF()
    
ENDFUNCTION(GENERATE_TART_TARGET)
