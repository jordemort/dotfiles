# no vi please
export EDITOR="nano"

subl=$(type -P subl)

if [ -x "$subl" ] ; then
	export EDITOR="subl -w"
elif [ ! -z "$SSH_CONNECTION" ] ; then
	export RMATE_PORT=62698
	if bash -c "head -c0 < /dev/tcp/127.0.0.1/$RMATE_PORT" 2>/dev/null ; then
		export EDITOR="rmate -w"
		alias subl="rmate"
	fi
fi

export VISUAL=$EDITOR
