if [ -e "$HOME/.bashrc" ] ; then
	. $HOME/.bashrc
fi

fortune=$(type -P fortune)

if [ -x "${fortune}" ] ; then
	fortune -a
	echo
fi
