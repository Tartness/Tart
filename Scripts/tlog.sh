#!/bin/bash -e

RESTORE=$(echo '\033[0m')
RED=$(echo '\033[00;31m')
GREEN=$(echo '\033[00;32m')
YELLOW=$(echo '\033[00;33m')
BLUE=$(echo '\033[00;34m')
MAGENTA=$(echo '\033[00;35m')
PURPLE=$(echo '\033[00;35m')
CYAN=$(echo '\033[00;36m')
LIGHTGRAY=$(echo '\033[00;37m')
LRED=$(echo '\033[01;31m')
LGREEN=$(echo '\033[01;32m')
LYELLOW=$(echo '\033[01;33m')
LBLUE=$(echo '\033[01;34m')
LMAGENTA=$(echo '\033[01;35m')
LPURPLE=$(echo '\033[01;35m')
LCYAN=$(echo '\033[01;36m')
WHITE=$(echo '\033[01;37m')

function tlogTemp {
  if [[ false = true ]]; then
    echo "${LGREEN}$1${RESTORE}"
  fi
}

function tlogDebug {
  if [[ false = true ]]; then
    echo "${CYAN}$1${RESTORE}"
  fi
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
