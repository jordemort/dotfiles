# no vi please
export EDITOR="nano"

atom=$(type -P atom)

if [ -x "$atom" ] ; then
	export EDITOR="atom -w"
	alias nano="atom"
	alias subl="atom"
fi

export VISUAL=$EDITOR
