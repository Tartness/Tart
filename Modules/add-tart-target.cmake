FUNCTION(ADD_TART_TARGET PACKAGE_NAME)
  SET(DEPENDENCY_LIST "")
  TART_PUBLIC("Adding target ${PACKAGE_NAME} to current project")
  FIND_PACKAGE_TART_YAML_FILEPATH("${CMAKE_CURRENT_LIST_DIR}/.." ${PACKAGE_NAME} PACKAGE_DIR)
  PARSE_YAML("${PACKAGE_DIR}/tart.yaml" NODE_NAMES NODE_VALS NODE_INDENTS)

  FIND_LIST_VALUE("include_dir" "${NODE_NAMES}" "${NODE_VALS}" INCLUDE_DIR)
  FIND_LIST_VALUE("src_dir" "${NODE_NAMES}" "${NODE_VALS}" SOURCE_DIR)
  # FIND_LIST_VALUE("main" "${NODE_NAMES}" "${NODE_VALS}" MAIN_PATH)
  FIND_LIST_VALUE("lib_name" "${NODE_NAMES}" "${NODE_VALS}" PACKAGE_NAME)
  FIND_LIST_VALUE("dependency" "${NODE_NAMES}" "${NODE_VALS}" DEPENDENCY_LIST)
  FIND_LIST_VALUE("target_properties" "${NODE_NAMES}" "${NODE_VALS}" TARGET_PROPERTIES_LIST)

  FILE(GLOB_RECURSE LIB_SOURCES "${PACKAGE_DIR}/${SOURCE_DIR}/*.cc"
                                "${PACKAGE_DIR}/${SOURCE_DIR}/*.cpp"
                                "${PACKAGE_DIR}/${INCLUDE_DIR}/*.h")

  TART_PUBLIC("${LIB_SOURCES}")
  ADD_EXECUTABLE(${PACKAGE_NAME} ${LIB_SOURCES})
  TARGET_INCLUDE_DIRECTORIES(${PACKAGE_NAME} PRIVATE "${PACKAGE_DIR}/${INCLUDE_DIR}")

  # SET_TARGET_PROPERTIES(${PACKAGE_NAME} PROPERTY CXX_STANDARD 14)

  # set mandatory target properties
  # TODO(nidegen) move to PROCESS_DEPENDENCY_LIST function
  SET(IS_IN_DETAILS FALSE)
  SET(LAST_ENTRY "")
  SET(TMP_STRING "${DEPENDENCY_LIST} DUMMY_END")
  STRING(REPLACE " " ";" TMP "${TMP_STRING}")
  FOREACH(DEPENDENCY_NAME ${TMP})
    # Check if current depenency entry opens details
    STRING(COMPARE EQUAL "${DEPENDENCY_NAME}" "at" DETAILS_START)
    IF(DETAILS_START)
      SET(IS_IN_DETAILS TRUE)
    ENDIF()
    TART_DEBUG("processing: ${DEPENDENCY_NAME}")
    IF(IS_IN_DETAILS)
      TART_DEBUG("IS_IN_DETAILS")
      STRING(COMPARE EQUAL "${DEPENDENCY_NAME}" "end" DETAILS_ENDED)
      IF(DETAILS_ENDED)
        TART_DEBUG("DETAILS_ENDED")
        SET(IS_IN_DETAILS FALSE)
        GET_GIT_REPO_URL_AND_TAG_FROM_DETAILS("${CURRENT_DETAILS}" "${LAST_ENTRY}" GIT_URL GIT_TAG)
        ASSERT_PACKAGE_AVAILABILITY("${GIT_URL}" "${GIT_TAG}" "${CMAKE_CURRENT_LIST_DIR}/..")
        SET(CURRENT_DETAILS "")
      ELSE()
        TART_DEBUG("STILL_IN_DETAILS")
        LIST(APPEND CURRENT_DETAILS ${DEPENDENCY_NAME})
      ENDIF()
    ELSE()
      #TODO(nidegen) is getting called at "github"
      TART_DEBUG("NOT_IN_DETAILS")
      STRING(COMPARE EQUAL "${LAST_ENTRY}" "" HAS_NO_PREVIOUS_ENTRY)
      IF(NOT HAS_NO_PREVIOUS_ENTRY)
        ADD_TART_DEPENDENCY(${PACKAGE_NAME} ${LAST_ENTRY})
      ENDIF()
      SET(LAST_ENTRY ${DEPENDENCY_NAME})
    ENDIF()

  ENDFOREACH()

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
    
ENDFUNCTION(ADD_TART_TARGET)
