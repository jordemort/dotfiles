# no vi please
export EDITOR="nano"

subl=$(type -P subl)

if [ -x "$subl" ] ; then
	export EDITOR="subl -w"
else
	[ -z "$RMATE_PORT" ] && export RMATE_PORT=52698

	if [ -z "$RMATE_HOST" ] && [ ! -z "$SSH_CONNECTION" ] ; then
		# try to discover rmate via direct connection
		ssh_host=${SSH_CONNECTION%% *}
		bash -c "head -c0 < /dev/tcp/$ssh_host/$RMATE_PORT" 2>/dev/null && export RMATE_HOST=$SSH_HOST
	fi

	if [ -z "$RMATE_HOST" ] ; then
		# try to discover rmate via localhost (presumably an SSH tunnel)
		bash -c "head -c0 < /dev/tcp/127.0.0.1/$RMATE_PORT" 2>/dev/null && export RMATE_HOST=127.0.0.1
	fi

	if [ ! -z "$RMATE_HOST" ] ; then
		export EDITOR="rmate -w"
		alias subl="rmate"
	fi
fi

export VISUAL=$EDITOR
