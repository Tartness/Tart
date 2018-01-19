
# FIND_CURRENT_OS() Sets the TART_CURRENT_OS variable
#
FUNCTION(FIND_CURRENT_OS)
  IF(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    SET(TART_CURRENT_OS "macOS")
  ELSEIF(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    SET(TART_CURRENT_OS "Windows")
  ELSEIF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    SET(TART_CURRENT_OS "Linux")
  ENDIF()
  # Set target os to current as default
  IF(${TART_TARGET_OS} MATCHES "UNDEF")
    SET(TART_TARGET_OS ${TART_CURRENT_OS})
  ENDIF()
ENDFUNCTION() 

# FIND_CURRENT_ARCH() Sets the TART_CURRENT_ARCH variable
#
FUNCTION(FIND_CURRENT_ARCH)
  IF(${CMAKE_SYSTEM_PROCESSOR} MATCHES "i386")
    SET(TART_CURRENT_ARCH "i386")
  ELSEIF(${CMAKE_SYSTEM_PROCESSOR} MATCHES "arm64")
    SET(TART_CURRENT_ARCH "arm64")
  ENDIF()
  # Set target architecture to current as default
  IF(${TART_TARGET_ARCH} MATCHES "UNDEF")
    SET(TART_TARGET_ARCH ${TART_CURRENT_ARCH})
  ENDIF()
ENDFUNCTION() 