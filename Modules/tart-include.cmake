# Include Tart Definitions
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../System/tart-definitions.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../System/tart-log.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../System/tart-system-variables.cmake")

# Include Tart Macros and Functions
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../Core/add-tart-dependency.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../Core/add-tart-target.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../PackageConfiguration/default-package-configuration.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../CompilerConfiguration/configure-xcode.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../PackageCheckout/git-tools.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../PackageConfiguration/inherit-target-properties.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../PackageCheckout/lib-checker.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../PreinstalledPackages/preinstalled-finder.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../PackageConfiguration/process-dependency-entry.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../PackageConfiguration/process-package-properties.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../PackageConfiguration/process-package-compile-definitions.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../PackageConfiguration/get-package-files.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../PackageConfiguration/set-default-configuration.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../YamlParser/tart-yaml-tools.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../YamlParser/yaml-parser-tools.cmake")
INCLUDE("${CMAKE_CURRENT_LIST_FILE}/../YamlParser/yaml-parser.cmake")



FIND_CURRENT_OS()
FIND_CURRENT_ARCH()
  
TART_TMP("#######################################################")
TART_TMP("Tart Dependency Management for C++/C/Objective-C")
TART_TMP("  Thanks for using Tart\n\n  (c) 2017 Tartness  www.github.com/Tartness/Tart")
TART_TMP("#######################################################")
TART_TMP("Using Dependencies:")
EXECUTE_PROCESS(COMMAND git --version)
EXECUTE_PROCESS(COMMAND cmake --version)
TART_TMP("#######################################################")
TART_TMP("\n")
