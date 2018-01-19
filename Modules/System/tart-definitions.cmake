
# TART_CURRENT_WORKSPACE_DIR sets the path where all packages are searched and cloned to

GET_FILENAME_COMPONENT(TART_CURRENT_WORKSPACE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/.." REALPATH)

# TART_TARGET_OS will efine the current OS
SET(TART_TARGET_OS "UNDEF" CACHE STRING "Set current OS Tart identifier")

# TART_TARGET_ARCH will efine the current OS
SET(TART_TARGET_ARCH "UNDEF" CACHE STRING "Set current Architecture Tart identifier")
