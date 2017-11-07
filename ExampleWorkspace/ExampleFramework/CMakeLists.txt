CMAKE_MINIMUM_REQUIRED (VERSION 3.2)

# Include Tart Modules
INCLUDE("${CMAKE_CURRENT_LIST_DIR}/../../Modules/tart-include.cmake")

################################
# ExampleFramework
################################

PROJECT("EFKit")

SET(EXAMPLE_IOS_FW "EFKit")

################################
# Define Sources and Headers
################################

SET(EFKIT_SOURCES "${CMAKE_CURRENT_LIST_DIR}/rocket.mm"
                  "${CMAKE_CURRENT_LIST_DIR}/rocket.h")
                  
ADD_LIBRARY(${EXAMPLE_IOS_FW} SHARED ${EFKIT_SOURCES})

CONFIGURE_FOR_XCODE_FW(${EXAMPLE_IOS_FW} "${CMAKE_CURRENT_LIST_DIR}/rocket.h")
CONFIGURE_FOR_IOS_10_3(${EXAMPLE_IOS_FW})

################################
# Define Dependencies
################################

ADD_TART_DEPENDENCY(${EXAMPLE_IOS_FW} "ExampleLibB")
INHERIT_XCODE_COMPILATION_OPTIONS(${EXAMPLE_IOS_FW} "ExampleLibB")
INHERIT_XCODE_COMPILATION_OPTIONS(${EXAMPLE_IOS_FW} "ExampleLibC")

# override some flags from ExampleFramework Lib
SET(CMAKE_C_FLAGS "-w -std=c++11")
SET(CMAKE_CXX_FLAGS "-w -std=c++11")

################################
# Define ExampleFramework Library
################################

# INCLUDE("${CMAKE_CURRENT_LIST_DIR}/../../cmake_modules/ios_10_3_config.cmake")
# INCLUDE("${CMAKE_CURRENT_LIST_DIR}/../../cmake_modules/xcode_framework_config.cmake")
# 
# ADD_LIBRARY(${EXAMPLE_IOS_FW} SHARED ${EFKIT_SOURCES})
# 
# # Configure build targets for iOS.
# # CONFIGURE_FOR_IOS_10_3(${DEPENDENCY_NAME})
# 
# 
# CONFIGURE_FOR_XCODE_FW(${EXAMPLE_IOS_FW} "${CMAKE_CURRENT_LIST_DIR}/rocket.h")
# 
# TARGET_LINK_LIBRARIES(${EXAMPLE_IOS_FW}
#   debug ${OPENMAPPER_LIB} optimized ${OPENMAPPER_LIB}
#   "-framework Accelerate"
#   "-framework AVFoundation"
#   "-framework AVKit"
#   "-framework CoreGraphics"
#   "-framework CoreMedia"
#   "-framework CoreVideo"
#   "-framework GLKit"
#   "-framework opencv2"
#   "-framework OpenGLES"
#   "-framework UIKit"
# )
# 
# SET_TARGET_PROPERTIES(${EXAMPLE_IOS_FW} PROPERTIES
#   DEBUG_POSTFIX "_d"
#   LIBRARY_OUTPUT_DIRECTORY ../lib/
#   LIBRARY_OUTPUT_DIRECTORY_DEBUG ../lib/
#   LIBRARY_OUTPUT_DIRECTORY_RELEASE ../lib/
#   LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ../lib/
#   ARCHIVE_OUTPUT_DIRECTORY ../lib/
#   ARCHIVE_OUTPUT_DIRECTORY_DEBUG ../lib/
#   ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ../lib/
#   ARCHIVE_OUTPUT_DIRECTORY_RELEASE ../lib/
# )
