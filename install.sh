#!/bin/bash -e

TART_LOCATION=$(pwd)
LINE='export PATH=$PATH:'$TART_LOCATION

if ! grep -qF "$LINE" ~/.bash_profile ; then 
  echo "$LINE" >> ~/.bash_profile;
  chmod +x $TART_LOCATION/tart
  source ~/.bash_profile
else
  echo "Already installed"
fi
