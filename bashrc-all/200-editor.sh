#!/usr/bin/env bash
# no vi please
EDITOR="nano"

code=$(type -P code)

if [ -x "$code" ] ; then
  EDITOR="code -n -w"
  alias nano=code
  alias subl=code
else
  alias atom=nano
  alias code=nano
  alias subl=nano
fi

VISUAL=$EDITOR

export EDITOR VISUAL
