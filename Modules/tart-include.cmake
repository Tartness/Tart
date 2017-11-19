# Include Tart Definitions
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../tart-definitions.cmake")

# Include Tart Macros and Functions
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../add-tart-dependency.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../add-tart-target.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../configure-tart-default.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../configure-xcode.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../git-tools.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../inherit-target-properties.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../lib-checker.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../preinstalled-finder.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../process-dependency-entry.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../process-package-properties.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../tart-log.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../tart-yaml-tools.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../yaml-parser-tools.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../yaml-parser.cmake")

TART_TMP("######################################################\n  Tart Dependency Management for C++/C/Objective-C")
TART_TMP("     Thank for using Tart\n     (c) 2017 Tartness  www.github.com/Tartness/Tart")
TART_TMP("######################################################")