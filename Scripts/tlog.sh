#!/bin/bash -e

RESTORE=$(echo -en '\033[0m')
RED=$(echo -en '\033[00;31m')
GREEN=$(echo -en '\033[00;32m')
YELLOW=$(echo -en '\033[00;33m')
BLUE=$(echo -en '\033[00;34m')
MAGENTA=$(echo -en '\033[00;35m')
PURPLE=$(echo -en '\033[00;35m')
CYAN=$(echo -en '\033[00;36m')
LIGHTGRAY=$(echo -en '\033[00;37m')
LRED=$(echo -en '\033[01;31m')
LGREEN=$(echo -en '\033[01;32m')
LYELLOW=$(echo -en '\033[01;33m')
LBLUE=$(echo -en '\033[01;34m')
LMAGENTA=$(echo -en '\033[01;35m')
LPURPLE=$(echo -en '\033[01;35m')
LCYAN=$(echo -en '\033[01;36m')
WHITE=$(echo -en '\033[01;37m')

function tlogTemp {
  if [[ false ]]; then
    return
  fi
  echo "${LGREEN}$1${RESTORE}"
}

function tlogDebug {
  if [[ true ]]; then
    return
  fi
  echo "${CYAN}$1${RESTORE}"
}

function tlogInfo {
  echo "${LBLUE}‣ ${BLUE}$1${RESTORE}"
}

function tlogWarning {
  echo "${LYELLOW}[!] ${YELLOW}$1${RESTORE}"
}

function tlogError {
  echo "${LRED}[X] ${RED}$1${RESTORE}"
}
