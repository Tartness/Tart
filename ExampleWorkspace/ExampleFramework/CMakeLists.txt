CMAKE_MINIMUM_REQUIRED (VERSION 3.2)

# Include Tart Modules
INCLUDE("${CMAKE_CURRENT_LIST_DIR}/../../Modules/tart-include.cmake")

################################
# ExampleFramework
################################

PROJECT("EFKit")


ADD_TART_TARGET("ExampleFramework" "SHARED")

CONFIGURE_FOR_XCODE_FW("ExampleFramework" "${CMAKE_CURRENT_LIST_DIR}/rocket.h")
