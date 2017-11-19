FUNCTION(ADD_TART_DEPENDENCY PARENT_BUILD_TARGET PACKAGE_NAME)
  SET(DEPENDENCY_LIST "")
  TART_INFO("Adding package '${PACKAGE_NAME}' to target ${PARENT_BUILD_TARGET}")
  FIND_PACKAGE_TART_YAML_FILEPATH("${TART_CURRENT_WORKSPACE_DIR}" ${PACKAGE_NAME} PACKAGE_DIR)

  PARSE_YAML("${PACKAGE_DIR}/tart.yaml" NODE_NAMES NODE_VALS NODE_INDENTS)

  FIND_LIST_VALUE("include_dir" "${NODE_NAMES}" "${NODE_VALS}" INCLUDE_DIR)
  FIND_LIST_VALUE("src_dir" "${NODE_NAMES}" "${NODE_VALS}" SOURCE_DIR)
  FIND_LIST_VALUE("lib_name" "${NODE_NAMES}" "${NODE_VALS}" PACKAGE_NAME)
  FIND_LIST_VALUE("target_properties" "${NODE_NAMES}" "${NODE_VALS}" TARGET_PROPERTIES_LIST)

  FILE(GLOB_RECURSE LIB_SOURCES "${PACKAGE_DIR}/${SOURCE_DIR}/*.cc"
                                "${PACKAGE_DIR}/${SOURCE_DIR}/*.cpp"
                                "${PACKAGE_DIR}/${INCLUDE_DIR}/*.h")


  ADD_LIBRARY(${PACKAGE_NAME} STATIC ${LIB_SOURCES})
  TARGET_INCLUDE_DIRECTORIES(${PACKAGE_NAME} PRIVATE "${PACKAGE_DIR}/${INCLUDE_DIR}")
  TARGET_INCLUDE_DIRECTORIES(${PARENT_BUILD_TARGET} PRIVATE "${PACKAGE_DIR}/${INCLUDE_DIR}")

  # SET_TARGET_PROPERTIES(${PACKAGE_NAME} PROPERTY CXX_STANDARD 14)

  TARGET_LINK_LIBRARIES(${PARENT_BUILD_TARGET} PRIVATE ${PACKAGE_NAME})
  
  GET_YAML_ENTRIES_WITH_INDENDTS("${PACKAGE_DIR}/tart.yaml" ENTRIES ENTRY_INDENTS)
  PROCESS_DEPENDENCY_ENTRIES(${PACKAGE_NAME} "${ENTRIES}" "${ENTRY_INDENTS}")
  PROCESS_TARGET_PROPERTIES(${PACKAGE_NAME} "${ENTRIES}" "${ENTRY_INDENTS}")
  PROCESS_CUSTOM_CONFIG_PROPERTIES(${PACKAGE_NAME} "${ENTRIES}" "${ENTRY_INDENTS}")
  PROCESS_TARGET_OS_PROPERTIES(${PACKAGE_NAME} "${ENTRIES}" "${ENTRY_INDENTS}")
  PROCESS_TARGET_ARCH_PROPERTIES(${PACKAGE_NAME} "${ENTRIES}" "${ENTRY_INDENTS}")


  FOREACH(TARGET_PROPERTY ${TARGET_PROPERTIES_LIST})
    STRING(REGEX MATCH "^[^ ]+" PROPERTY_NAME ${TARGET_PROPERTY})
    STRING(REPLACE "${PROPERTY_NAME} " "" PROPERTY_VALUE ${TARGET_PROPERTY})
    # MESSAGE("${TARGET_PROPERTY}")
    # MESSAGE("${PROPERTY_NAME}")
    # MESSAGE("${PROPERTY_VALUE}")
    SET_TARGET_PROPERTIES(${PACKAGE_NAME} PROPERTIES ${PROPERTY_NAME} ${PROPERTY_VALUE})
  ENDFOREACH()
  
  # TODO(nidegen) implement following:
  # IF(GENERATOR_IS_XCODE)
  #   INHERIT_XCODE_COMPILATION_OPTIONS(${PARENT_BUILD_TARGET} ${PACKAGE_NAME})
  # ENDIF()
    
ENDFUNCTION(ADD_TART_DEPENDENCY)