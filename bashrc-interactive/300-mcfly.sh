#!/usr/bin/env bash

if [ -x "$(type -P mcfly)" ]; then
  eval "$(mcfly init bash)"
  export MCFLY_FUZZY=2
fi
