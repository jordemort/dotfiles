#!bash
# get homeshick set up
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# break the rest of bashrc out so any changes picked up
# by homeshick refresh above are effective immediately
DOTFILES="$HOME/.homesick/repos/dotfiles"
for rc in "$DOTFILES/universal.d/"*.sh ; do
	if [ -x $rc ] ; then
		source $rc
	fi
done

if [ -n "$PS1" ] ; then
	homeshick -q -b refresh || homeshick -b refresh
	for rc in "$DOTFILES/interactive.d/"*.sh ; do
		if [ -x $rc ] ; then
			source $rc
		fi
	done
fi

if [ -e "$HOME/.bashrc.local" ] ; then
	. $HOME/.bashrc.local
fi
