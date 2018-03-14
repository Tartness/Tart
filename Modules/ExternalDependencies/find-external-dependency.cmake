# FIND_EXTERNAL_DEPENDENCY() Process all entries of the dependency list from a tart.yaml file
# 
FUNCTION(FIND_EXTERNAL_DEPENDENCY PARENT_BUILD_TARGET DEPENDENCY FOUND_EXTERNAL_DEPENDENCY)
  TART_DEBUG("Processing dependencies: ${DEPENDENCIES}")
  IF(${DEPENDENCY} STREQUAL "OpenGL")
    # add OpenGL or OpenGL ES
    IF(TART_TARGET_OS STREQUAL "iOS")
      # NOTE: on iOS simply add   "-framework OpenGLES"
      TARGET_LINK_LIBRARIES(${PARENT_BUILD_TARGET} PRIVATE "-framework OpenGLES")
      SET(${FOUND_EXTERNAL_DEPENDENCY} TRUE PARENT_SCOPE)
      RETURN()
    ELSE()
      FIND_PACKAGE(OpenGL REQUIRED)
      IF(OpenGL_FOUND)
        SET(${FOUND_EXTERNAL_DEPENDENCY} TRUE PARENT_SCOPE)
        TARGET_LINK_LIBRARIES(${PARENT_BUILD_TARGET} PRIVATE debug ${OPENGL_LIBRARIES} optimized ${OPENGL_LIBRARIES})
        RETURN()
      ELSE()
        CONTINUE()
      ENDIF()
    ENDIF()
  ELSEIF(${DEPENDENCY} STREQUAL "OpenGL")
  ENDIF()
  SET(${FOUND_EXTERNAL_DEPENDENCY} FALSE PARENT_SCOPE)
ENDFUNCTION()