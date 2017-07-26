# get homeshick set up
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
homeshick -q -b refresh || homeshick -b refresh

# break the rest of bashrc out so any changes picked up
# by homeshick refresh above are effective immediately
DOTFILES="$HOME/.homesick/repos/dotfiles"
for rc in "$DOTFILES/bashrc.d/"*.sh ; do
	if [ -x $rc ] ; then
		source $rc
	fi
done

if [ -e "$HOME/.bashrc.local" ] ; then
	. $HOME/.bashrc.local
fi
