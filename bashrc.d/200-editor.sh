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
	if [ -z $(type -P nc) ] ; then
		[ ! -e "$HOME/.shutup_about_nc" ] && echo "WARNING: No nc, rmate isn't going to work"
	else
		export EDITOR="rmate -w"
		alias nano="rmate"
		alias subl="rmate"
	fi
fi

export VISUAL=$EDITOR
