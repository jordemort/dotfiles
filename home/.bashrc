# get homeshick set up
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
homeshick -q -b refresh || homeshich -b refresh

# break the rest of bashrc out so any changes picked up
# by homeshick refresh above are effective immediately
for rc in "$HOME/.homesick/repos/dotfiles/bashrc.d/"*.sh ; do
	if [ -x $rc ] ; then
		source $rc
	fi
done

if [ -e "$HOME/.bashrc.local" ] ; then
	. $HOME/.bashrc.local
fi
