
# FIND_CURRENT_OS() Sets the TART_CURRENT_OS variable
#
FUNCTION(FIND_CURRENT_OS)
  IF(${CMAKE_HOST_SYSTEM_NAME} MATCHES "Darwin")
    SET(TART_CURRENT_OS "macOS" CACHE STRING "")
  ELSEIF(${CMAKE_HOST_SYSTEM_NAME} MATCHES "Windows")
    SET(TART_CURRENT_OS "Windows" CACHE STRING "")
  ELSEIF(${CMAKE_HOST_SYSTEM_NAME} MATCHES "Linux")
    SET(TART_CURRENT_OS "Linux" CACHE STRING "")
  ELSE()
    SET(TART_TARGET_OS "UNDEFINED" CACHE STRING "")
  ENDIF()
  # Set target os to current. If cache variable already exists it is not overwritten
  IF(NOT ${TART_CURRENT_OS} STREQUAL "UNDEFINED")
    SET(TART_TARGET_OS ${TART_CURRENT_OS} CACHE STRING "")
  ENDIF()
ENDFUNCTION() 

# FIND_CURRENT_ARCH() Sets the TART_CURRENT_ARCH variable
#
FUNCTION(FIND_CURRENT_ARCH)
  IF(${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86_64")
    SET(TART_CURRENT_ARCH "x86_64" CACHE STRING "")
  ELSEIF(${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "i386")
    SET(TART_CURRENT_ARCH "i386" CACHE STRING "")
  ELSEIF(${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "arm64")
    SET(TART_CURRENT_ARCH "arm64" CACHE STRING "")
  ELSE()
    SET(TART_CURRENT_ARCH "UNDEFINED" CACHE STRING "")
  ENDIF()
  # Set target architecture to current. If cache variable already exists it is not overwritten
    IF(NOT ${TART_CURRENT_ARCH} STREQUAL "UNDEFINED")
      SET(TART_TARGET_ARCH ${TART_CURRENT_ARCH} CACHE STRING "")
    ENDIF()
ENDFUNCTION() 

# ADD_TART_SEARCH_PATH()
#
FUNCTION(ADD_TART_SEARCH_PATH NEW_PATH)
  SET(VAR "${TART_PACKAGE_SEARCH_PATH};${NEW_PATH}" CACHE INTERNAL "Tart package search path")
ENDFUNCTION() 
