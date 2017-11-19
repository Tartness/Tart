# GET_SOURCE_FILES() Set sources according to tart.yaml file
# 
FUNCTION(GET_SOURCE_FILES PACKAGE_DIR SOURCES_OUT)
  # TODO deprecate use of PARSE_YAML()
  # GET_ENTRY_VALUES("dependency" "${ENTRIES}" "${ENTRY_INDENTS}" DEPENDENCIES HAS_SUBTREE)
  # TART_DEBUG("Processing dpendencies: ${DEPENDENCIES}")
  TART_TMP("get src for : ${PACKAGE_DIR}/tart.yaml")
  PARSE_YAML("${PACKAGE_DIR}/tart.yaml" NODE_NAMES NODE_VALS NODE_INDENTS)

  FIND_LIST_VALUE("include_dir" "${NODE_NAMES}" "${NODE_VALS}" INCLUDE_DIR)
  FIND_LIST_VALUE("src_dir" "${NODE_NAMES}" "${NODE_VALS}" SOURCE_DIR)
  FIND_LIST_VALUE("lib_name" "${NODE_NAMES}" "${NODE_VALS}" PACKAGE_NAME)
  FIND_LIST_VALUE("target_properties" "${NODE_NAMES}" "${NODE_VALS}" TARGET_PROPERTIES_LIST)

  FILE(GLOB_RECURSE LIBSOURCES "${PACKAGE_DIR}/${SOURCE_DIR}/*.cc"
                                "${PACKAGE_DIR}/${SOURCE_DIR}/*.m"
                                "${PACKAGE_DIR}/${SOURCE_DIR}/*.mm"
                                "${PACKAGE_DIR}/${SOURCE_DIR}/*.cpp"
                                "${PACKAGE_DIR}/${SOURCE_DIR}/*.c"
                                "${PACKAGE_DIR}/${INCLUDE_DIR}/*.hpp"
                                "${PACKAGE_DIR}/${INCLUDE_DIR}/*.h")
  SET(${SOURCES_OUT} PARENT_SCOPE ${LIBSOURCES})
ENDFUNCTION(GET_SOURCE_FILES)
