# if this is an ssh connection, and we're not in tmux, and we have tmux...
if [ ! -z "$SSH_CONNECTION" ] && [ -z "$TMUX" ] && [ ! -z "$(type -P tmux)" ] ; then
	if tmux list-sessions > /dev/null 2>&1; then
		for client in `tmux list-clients | cut -d':' -f1` ; do
			MESSAGE="Connected: ${SSH_CLIENT} $(tty)"
			tmux display-message -t $client "${MESSAGE}" &
		done
		FIRST=`tmux list-sessions | grep -v attached | cut -d: -f1 | head -n1`
		if [ ! -z "$FIRST" ] ; then
			# if there's an unattached tmux session, grab that
			exec tmux attach-session -t $FIRST
		else
			# otherwise, start a new tmux session
			exec tmux new-session
		fi
	else
		# otherwise, start a new tmux session
		exec tmux new-session
	fi
fi
