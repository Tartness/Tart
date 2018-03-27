#!/bin/bash -e
export TART_PATH="$HOME/Developer/Tartness/Tart/"
if hash tart 2>/dev/null; then
  # fix this first
  echo export PATH="$PATH":"$HOME/Developer/Tartness/Tart/tart" >> ~/.bash_profile
else
  echo "Already installed"
fi
source ~/.bash_profile
