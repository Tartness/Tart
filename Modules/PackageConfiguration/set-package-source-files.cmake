# SET_PACKAGE_SOURCE_FILES() Set sources according to tart.yaml file
# 
FUNCTION(SET_PACKAGE_SOURCE_FILES PACKAGE_DIR ENTRIES ENTRY_INDENTS SOURCES_OUT)
  GET_ENTRY_VALUES("src_dir" "${ENTRIES}" "${ENTRY_INDENTS}" SRC_DIRS HAS_SUBTREE)
  TART_DEBUG("Processing src_dirs: ${SRC_DIRS}")
  SET(SOURCE_DIR "")
  FOREACH(SRC_DIR ${SRC_DIRS})
    TART_DEBUG("Found src_dir: ${SRC_DIR}")
    LIST(APPEND SOURCE_DIR "${SRC_DIR}")
  ENDFOREACH()
  
  FILE(GLOB_RECURSE LIBSOURCES "${PACKAGE_DIR}/${SOURCE_DIR}/*.cc"
                               "${PACKAGE_DIR}/${SOURCE_DIR}/*.m"
                               "${PACKAGE_DIR}/${SOURCE_DIR}/*.mm"
                               "${PACKAGE_DIR}/${SOURCE_DIR}/*.cpp"
                               "${PACKAGE_DIR}/${SOURCE_DIR}/*.c"
                               "${PACKAGE_DIR}/${PACKAGE_INCLUDE_DIR}/*.hpp"
                               "${PACKAGE_DIR}/${PACKAGE_INCLUDE_DIR}/*.h")
  SET(${SOURCES_OUT} ${LIBSOURCES} PARENT_SCOPE)
ENDFUNCTION(SET_PACKAGE_SOURCE_FILES)
