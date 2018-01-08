#!bash
# no vi please
EDITOR="nano"

atom=$(type -P atom)

if [ -x "$atom" ] ; then
	export EDITOR="rmate -w"
	alias nano="atom"
	alias subl="atom"
fi

alias atom=$EDITOR
alias subl=$EDITOR

VISUAL=$EDITOR

export EDITOR VISUAL
