#!bash
# load misc completions
if [ "${BASH_VERSINFO[0]}" -gt "4" ] || [ "${BASH_VERSINFO[0]}" -eq "4" -a "${BASH_VERSINFO[1]}" -ge "1" ] ; then
	BASH_COMPLETION_USER_DIR="$HOME/.homesick/repos/dotfiles/bash-completion/completions"
fi

# old bash_completion versions set these vars, and if we try and load system
# completions from one of those versions with our carpetbagged version we'll
# get errors if we don't set this
UNAME=$(uname -s)
case ${UNAME} in
    Linux|GNU|GNU/*) USERLAND=GNU ;;
    *) USERLAND=${UNAME} ;;
esac

# if bash is new
if [ -z "$BASH_COMPLETION" ] ; then
	if [ "${BASH_VERSINFO[0]}" -gt "4" ] || [ "${BASH_VERSINFO[0]}" -eq "4" -a "${BASH_VERSINFO[1]}" -ge "1" ] ; then
		source "$HOME/.homesick/repos/dotfiles/bash-completion/bash_completion"
	elif [ -e "/etc/bash_completion" ] ; then
		source "/etc/bash_completion"
	fi
fi

# always load these
source "$HOME/.homesick/repos/dotfiles/bin/git-completion.bash"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
source "$HOME/.homesick/repos/dotfiles/pip-bash-completion/pip"

# load these as appropriate
[ "$(type -P aws_completer)" ] && complete -C "$(which aws_completer)" aws
[ "$UNAME" = "Darwin" ] && source "$HOME/.homesick/repos/dotfiles/open-bash-completion/open"
[ "$(type -P vagrant)" ] && source "$HOME/.homesick/repos/dotfiles/vagrant-bash-completion/vagrant-bash-completion/etc/bash_completion.d/vagrant"
[ "$(type -P vboxmanage)" ] && source "$HOME/.homesick/repos/dotfiles/vboxmanage-bash-completion/VBoxManage"
