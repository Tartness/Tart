
# ADD_PREINSTALLED_PACKAGE() Finds libraries that are not supposed 
# to be compiled but are used as installed package
#
FUNCTION(ADD_PREINSTALLED_PACKAGE PACKAGE_NAME LINKING_TARGET)
  IF(${PACKAGE_NAME} STREQUAL "OpenGL")
    LINK_OPENGL(${LINKING_TARGET})
  ELSE()
    TART_WARNING("Unknown preinstalled package ${PACKAGE_NAME}, trying standard Cmake FIND_PACKAGE to add it.")
  ENDIF()
ENDFUNCTION() 


# Usage of find package: https://stackoverflow.com/questions/20746936/cmake-of-what-use-is-find-package-if-you-need-to-specify-cmake-module-path-an

# Link OpenGL according to target properties
FUNCTION(LINK_OPENGL TARGET_LINKED_TO)
  IF(${TART_TARGET_OS} STREQUAL "iOS")
    TART_DEBUG("Adding iOS OpenGL (GLKit and OpenGLES)")
    TARGET_LINK_LIBRARIES(${TARGET_LINKED_TO} PRIVATE
                          "-framework GLKit" # TODO: check if we can/should add 'PRIVATE'
                          "-framework OpenGLES"
    )
  ELSEIF(${TART_TARGET_OS} STREQUAL "Android")
    TART_DEBUG("Adding Andorid OpenGL")
    # TODO
    # GLESv2
    # FIND_PATH(GLES2_INCLUDE_DIR GLES2/gl2.h HINTS ${ANDROID_NDK})
    # FIND_LIBRARY(GLES2_LIBRARY libGLESv2.so HINTS ${GLES2_INCLUDE_DIR}/../lib)
    # TARGET_INCLUDE_DIRECTORIES(${TARGET_LINKED_TO} PUBLIC ${GLES2_INCLUDE_DIR})
    # TARGET_LINK_LIBRARIES(${TARGET_LINKED_TO}  PRIVATE DEBUG ${GLES2_LIBRARY} OPTIMIZED ${GLES2_LIBRARY})
  ELSE()
    TART_DEBUG("Adding FIND_PACKAGE OpenGL")
    FIND_PACKAGE(OPENGL REQUIRED)
    # FIND_LIBRARY(OPENGL_LIBRARIES OPENGL)
    TARGET_INCLUDE_DIRECTORIES(${TARGET_LINKED_TO} PRIVATE "${OPENGL_INCLUDE_DIR}")

    TARGET_LINK_LIBRARIES(${TARGET_LINKED_TO} PRIVATE debug ${OPENGL_LIBRARIES} optimized ${OPENGL_LIBRARIES})
  ENDIF()
ENDFUNCTION(LINK_OPENGL)
