#!bash
# no vi please
export EDITOR="nano"

atom=$(type -P atom)

if [ -x "$atom" ] ; then
	export EDITOR="atom -w"
	alias nano="atom"
	alias subl="atom"
else
	alias atom=$EDITOR
	alias subl=$EDITOR
fi

export VISUAL=$EDITOR
