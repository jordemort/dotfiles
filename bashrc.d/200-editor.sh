#!bash
# no vi please
export EDITOR="nano"

alias atom=$EDITOR
alias subl=$EDITOR

atom=$(type -P atom)

if [ -x "$atom" ] ; then
	export EDITOR="rmate -w"
	alias nano="atom"
	alias subl="atom"
elif [ -n "$RMATE_UNIX" ] ; then
	export EDITOR="rmate -w"
	alias nano="rmate"
	alias subl="rmate"
fi

export VISUAL=$EDITOR
