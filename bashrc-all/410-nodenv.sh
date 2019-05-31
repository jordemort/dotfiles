#!/usr/bin/env bash
nodenv=$(type -P nodenv)

if [ -x "$nodenv" ] ; then
  eval "$(nodenv init -)"
fi
