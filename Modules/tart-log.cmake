# Colourisation are taken from https://stackoverflow.com/questions/18968979/how-to-get-colorized-output-with-cmake

# ANSI Color escape codes:

# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

IF(NOT WIN32)
  STRING(ASCII 27 Esc)
  SET(ColourReset "${Esc}[m")
  SET(ColourBold  "${Esc}[1m")
  SET(Black       "${Esc}[30m")
  SET(Red         "${Esc}[31m")
  SET(Green       "${Esc}[32m")
  SET(Yellow      "${Esc}[33m")
  SET(Blue        "${Esc}[34m")
  SET(Magenta     "${Esc}[35m")
  SET(Cyan        "${Esc}[36m")
  SET(White       "${Esc}[37m")
  
  SET(BoldGray    "${Esc}[1;30m")
  SET(BoldRed     "${Esc}[1;31m")
  SET(BoldGreen   "${Esc}[1;32m")
  SET(BoldYellow  "${Esc}[1;33m")
  SET(BoldBlue    "${Esc}[1;34m")
  SET(BoldMagenta "${Esc}[1;35m")
  SET(BoldCyan    "${Esc}[1;36m")
  SET(BoldWhite   "${Esc}[1;37m")
  
  SET(UBlack      "${Esc}[4;30m")
  SET(URed        "${Esc}[4;31m")
  SET(UGreen      "${Esc}[4;32m")
  SET(UYellow     "${Esc}[4;33m")
  SET(UBlue       "${Esc}[4;34m")
  SET(UMagenta    "${Esc}[4;35m")
  SET(UCyan       "${Esc}[4;36m")
  SET(UWhite      "${Esc}[4;37m")
  
ENDIF()

# MESSAGE("This is normal")
# MESSAGE("${Red}This is Red${ColourReset}")
# MESSAGE("${Green}This is Green${ColourReset}")
# MESSAGE("${Yellow}This is Yellow${ColourReset}")
# MESSAGE("${Blue}This is Blue${ColourReset}")
# MESSAGE("${Magenta}This is Magenta${ColourReset}")
# MESSAGE("${Cyan}This is Cyan${ColourReset}")
# MESSAGE("${White}This is White${ColourReset}")
# MESSAGE("${BoldRed}This is BoldRed${ColourReset}")
# MESSAGE("${BoldGreen}This is BoldGreen${ColourReset}")
# MESSAGE("${BoldYellow}This is BoldYellow${ColourReset}")
# MESSAGE("${BoldBlue}This is BoldBlue${ColourReset}")
# MESSAGE("${BoldMagenta}This is BoldMagenta${ColourReset}")
# MESSAGE("${BoldCyan}This is BoldCyan${ColourReset}")
# MESSAGE("${BoldWhite}This is BoldWhite\n\n${ColourReset}")

FUNCTION(MESSAGE)
  LIST(GET ARGV 0 MESSAGE_TYPE)
  IF(MESSAGE_TYPE STREQUAL FATAL_ERROR OR MESSAGE_TYPE STREQUAL SEND_ERROR)
    LIST(REMOVE_AT ARGV 0)
    _MESSAGE(${MESSAGE_TYPE} "${BoldRed}${ARGV}${ColourReset}")
  ELSEIF(MESSAGE_TYPE STREQUAL WARNING)
    LIST(REMOVE_AT ARGV 0)
    _MESSAGE(${MESSAGE_TYPE} "${BoldYellow}${ARGV}${ColourReset}")
  ELSEIF(MESSAGE_TYPE STREQUAL AUTHOR_WARNING)
    LIST(REMOVE_AT ARGV 0)
    _MESSAGE(${MESSAGE_TYPE} "${BoldCyan}${ARGV}${ColourReset}")
  ELSEIF(MESSAGE_TYPE STREQUAL STATUS)
    LIST(REMOVE_AT ARGV 0)
    _MESSAGE(${MESSAGE_TYPE} "${Green}${ARGV}${ColourReset}")
  ELSE()
    _MESSAGE("${ARGV}")
  ENDIF()
ENDFUNCTION()

# MESSAGE("No colour at all.")
# MESSAGE(STATUS "\"Colour\" is spelled correctly.")
# MESSAGE(AUTHOR_WARNING "\"Color\" is misspelled.")
# MESSAGE(WARNING "Final warning: spell \"color\" correctly.")
# MESSAGE(SEND_ERROR "Game over.  It's \"colour\", not \"color\".")
# MESSAGE(FATAL_ERROR "And there's no \"z\" in \"colourise\" either.")

# Seitchable Log Message
FUNCTION(TART_TMP MESSAGE)
  IF(TRUE)
    MESSAGE(${BoldMagenta}${MESSAGE}${ColourReset})
  ENDIF()
ENDFUNCTION(TART_TMP)

FUNCTION(TART_DEBUG MESSAGE)
  IF(FALSE)
    MESSAGE(${Cyan}${MESSAGE}${ColourReset})
  ENDIF()
ENDFUNCTION(TART_DEBUG)

FUNCTION(TART_INFO MESSAGE)
  IF(FALSE)
    MESSAGE(${BoldBlue}${MESSAGE}${ColourReset})
  ENDIF()
ENDFUNCTION(TART_INFO)

FUNCTION(TART_WARNING MESSAGE)
  IF(TRUE)
    MESSAGE("${BoldYellow}[!] Warning ${ColourReset}${MESSAGE}")
  ENDIF()
ENDFUNCTION(TART_WARNING)

FUNCTION(TART_ERROR MESSAGE)
  IF(TRUE)
    MESSAGE(FATAL_ERROR "${BoldRed}[!] Error ${ColourReset}${MESSAGE}")
  ENDIF()
ENDFUNCTION(TART_ERROR)

FUNCTION(TART_PUBLIC MESSAGE)
  IF(TRUE)
    MESSAGE(${Green}${MESSAGE}${ColourReset})
  ENDIF()
ENDFUNCTION(TART_PUBLIC)
