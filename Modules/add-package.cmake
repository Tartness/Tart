# ADD_KAKE_PACKAGE will add the given Package to a BUILD_TARGET

FUNCTION(ADD_KAKE_PACKAGE BUILD_TARGET)
  # NOTE: Try to not configure cmake files
  CONFIGURE_FILE("${CMAKE_CURRENT_LIST_DIR}/include/ktools/build-config.h.in"
                 "${CMAKE_CURRENT_LIST_DIR}/include/ktools/build-config.h")


  ############################################
  # File Globbing
  ############################################

  # these instructions search the directory tree when cmake is invoked
  FILE(GLOB_RECURSE K_TOOLS_SOURCES  "${CMAKE_CURRENT_LIST_DIR}/src/*.cpp" "${CMAKE_CURRENT_LIST_DIR}/include/ktools/*.h")



  ############################################
  # Target Definition
  ############################################

  ADD_LIBRARY(${K_TOOLS_TARGET} STATIC ${K_TOOLS_SOURCES})

  SOURCE_GROUP("KapanuTools" FILES ${K_TOOLS_SOURCES})
  set_property(TARGET tgt PROPERTY CXX_STANDARD 11)
  SET_TARGET_PROPERTIES(${BUILD_TARGET} PROPERTIES
    CXX_STANDARD 14
  )
ENDFUNCTION(CONFIGURE_FRAMEWORK)
