#!/bin/bash -e

TART_LOCATION='/Users/nicolas/Developer/Tartness/Tart'
LINE='export PATH=$PATH:'$TART_LOCATION

if ! grep -qF "$LINE" ~/.bash_profile ; then 
  echo "$LINE" >> ~/.bash_profile;
  chmod +x $TART_LOCATION/tart
  source ~/.bash_profile
else
  echo "Already installed"
fi
