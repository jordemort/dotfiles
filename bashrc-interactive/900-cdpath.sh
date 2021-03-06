#!/usr/bin/env bash

# save some time changing directories
CDPATH=".:$HOME:$HOME/Source:$HOME/GitHub:$HOME/.homesick/repos"

# correct spelling on directory names
if (( BASH_VERSINFO[0] > 3 )) ; then
  shopt -s dirspell
fi

# correct spelling when changing directories
shopt -s cdspell
