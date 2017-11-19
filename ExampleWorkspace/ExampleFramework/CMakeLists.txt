CMAKE_MINIMUM_REQUIRED (VERSION 3.2)

# Include Tart Modules
INCLUDE("${CMAKE_CURRENT_LIST_DIR}/../../Modules/tart-include.cmake")

################################
# ExampleFramework
################################

PROJECT("EFKit")


ADD_TART_TARGET("ExampleFramework" "SHARED")


# CONFIGURE_FOR_XCODE_FW(${EXAMPLE_IOS_FW} "${CMAKE_CURRENT_LIST_DIR}/rocket.h")
# CONFIGURE_FOR_IOS(${EXAMPLE_IOS_FW})

################################
# Define Dependencies
################################

# ADD_TART_DEPENDENCY(${EXAMPLE_IOS_FW} "ExampleLibB")
# INHERIT_XCODE_COMPILATION_OPTIONS(${EXAMPLE_IOS_FW} "ExampleLibB")
# INHERIT_XCODE_COMPILATION_OPTIONS(${EXAMPLE_IOS_FW} "ExampleLibC")
