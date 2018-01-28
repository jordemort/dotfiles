#!bash
# no vi please
EDITOR="nano"

atom=$(type -P atom)

if [ -x "$atom" ] ; then
  EDITOR="rmate -w"
  alias nano="atom"
  alias subl="atom"
else
  alias atom=$EDITOR
  alias subl=$EDITOR
fi

VISUAL=$EDITOR

export EDITOR VISUAL
