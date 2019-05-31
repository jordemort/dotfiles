#!/usr/bin/env bash
pyenv=$(type -P pyenv)

if [ -x "$pyenv" ] ; then
  eval "$(pyenv init -)"
fi
