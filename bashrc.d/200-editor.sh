# no vi please
export EDITOR="nano"

subl=$(type -P subl)

if [ -x "$subl" ] ; then
	export EDITOR="subl -w"
elif [ ! -z "$SSH_CONNECTION" ] ; then
	if bash -c 'head -c0 < /dev/tcp/127.0.0.1/52698' 2>/dev/null ; then
		export EDITOR="rmate -w"
		alias subl="rmate"
	fi
fi

export VISUAL=$EDITOR
