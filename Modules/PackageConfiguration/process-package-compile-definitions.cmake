# PROCESS_PACKAGE_COMPILE_DEFINITIONS() Process additional tart.yaml compile definition
#
FUNCTION(PROCESS_PACKAGE_COMPILE_DEFINITIONS PACKAGE_NAME ENTRIES ENTRY_INDENTS)
  PROCESS_TARGET_DEFAULT_COMPILE_DEFINITIONS(${PACKAGE_NAME} "${ENTRIES}" "${ENTRY_INDENTS}")
  PROCESS_TARGET_COMPILE_DEFINITIONS(${PACKAGE_NAME} "${ENTRIES}" "${ENTRY_INDENTS}")
  PROCESS_CUSTOM_CONFIG_COMPILE_DEFINITIONS(${PACKAGE_NAME} "${ENTRIES}" "${ENTRY_INDENTS}")
  # TODO add these as well
  # PROCESS_TARGET_OS_COMPILE_DEFINITIONS(${PACKAGE_NAME} "${ENTRIES}" "${ENTRY_INDENTS}")
  # PROCESS_TARGET_ARCH_COMPILE_DEFINITIONS(${PACKAGE_NAME} "${ENTRIES}" "${ENTRY_INDENTS}")
ENDFUNCTION()


# PROCESS_TARGET_DEFAULT_COMPILE_DEFINITIONS() Process default compile definition list 
#
FUNCTION(PROCESS_TARGET_DEFAULT_COMPILE_DEFINITIONS PACKAGE_TARGET ENTRIES ENTRY_INDENTS)
  GET_ENTRY_VALUES("package_path" "${ENTRIES}" "${ENTRY_INDENTS}" PACKAGE_PATH HAS_SUBTREE)
  # support git tag if it is a git repo
  # GET_LAST_GIT_TAG("${PACKAGE_PATH}" GIT_TAG)
  # TART_TMP("${GIT_TAG}")
  TART_TMP("${PACKAGE_PATH}")
  # TARGET_COMPILE_DEFINITIONS(${PACKAGE_TARGET} PRIVATE "PACKAGE_VERSION=${GIT_TAG}")
ENDFUNCTION(PROCESS_TARGET_DEFAULT_COMPILE_DEFINITIONS)

# PROCESS_TARGET_COMPILE_DEFINITIONS() Process entries of the target compile definition list from a tart.yaml file
#
FUNCTION(PROCESS_TARGET_COMPILE_DEFINITIONS PACKAGE_TARGET ENTRIES ENTRY_INDENTS)
  GET_ENTRY_VALUES("target_compile_definitions" "${ENTRIES}" "${ENTRY_INDENTS}" TARGET_COMPILE_DEFINITIONS HAS_SUBTREE)
  TART_DEBUG("Processing target_compile_definitions: ${TARGET_COMPILE_DEFINITIONS}")
  
  FOREACH(TARGET_COMPILE_DEFINITION ${TARGET_COMPILE_DEFINITIONS})
    STRING(STRIP ${TARGET_COMPILE_DEFINITION} TARGET_COMPILE_DEFINITION)
    TARGET_COMPILE_DEFINITIONS(${PACKAGE_TARGET} PRIVATE "${TARGET_COMPILE_DEFINITION}")
  ENDFOREACH()
ENDFUNCTION(PROCESS_TARGET_COMPILE_DEFINITIONS)

# PROCESS_CUSTOM_CONFIG_COMPILE_DEFINITIONS() Process entries of the custom configuration compile definition list from a tart.yaml file
#
FUNCTION(PROCESS_CUSTOM_CONFIG_COMPILE_DEFINITIONS PACKAGE_TARGET ENTRIES ENTRY_INDENTS)
  GET_ENTRY_VALUES("custom_configuration_compile_definitions" "${ENTRIES}" "${ENTRY_INDENTS}" CUSTOM_CONFIGURATIONS HAS_SUBTREE)
  TART_DEBUG("Processing custom_configuration_compile_definitions: ${CUSTOM_CONFIGURATIONS}")
  
  FOREACH(CUSTOM_CONFIG ${CUSTOM_CONFIGURATIONS})
    GET_ENTRY_VALUES(${CUSTOM_CONFIG} "${ENTRIES}" "${ENTRY_INDENTS}" SPECIFIC_CONFIG_COMPILE_DEFINITIONS HAS_SUBTREE)
    FOREACH(SPECIFIC_CONFIG_COMPILE_DEFINITION ${SPECIFIC_CONFIG_COMPILE_DEFINITIONS})
      STRING(STRIP ${SPECIFIC_CONFIG_COMPILE_DEFINITION} SPECIFIC_CONFIG_COMPILE_DEFINITION)
      TARGET_COMPILE_DEFINITIONS(${PACKAGE_TARGET} PRIVATE "${COMPILE_DEFINITION_KEY}")
    ENDFOREACH()
  ENDFOREACH()
ENDFUNCTION(PROCESS_CUSTOM_CONFIG_COMPILE_DEFINITIONS)
