# get homeshick set up
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
homeshick --quiet refresh

# break the rest of bashrc out so any changes picked up
# by homeshick refresh above are effective immediately
for rc in "$HOME/.homesick/repos/dotfiles/bashrc.d/"* ; do
	source $rc
done
