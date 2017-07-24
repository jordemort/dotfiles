#!bash
# load misc completions
if [ "${BASH_VERSINFO[0]}" -gt "4" ] || [ "${BASH_VERSINFO[0]}" -eq "4" -a "${BASH_VERSINFO[1]}" -ge "1" ] ; then
	BASH_COMPLETION_USER_DIR="$HOME/.homesick/repos/dotfiles/bash-completion/completions"
fi

if [ "${BASH_VERSINFO[0]}" -gt "4" ] || [ "${BASH_VERSINFO[0]}" -eq "4" -a "${BASH_VERSINFO[1]}" -ge "1" ] ; then
	[ -z "$BASH_COMPLETION" ] && source "$HOME/.homesick/repos/dotfiles/bash-completion/bash_completion"
elif [ -e "/etc/bash_completion" ] ; then
	[ -z "$BASH_COMPLETION" ] && source "/etc/bash_completion"
fi

# load extra completions
[[ -x "$(which aws_completer)" ]] && complete -C "$(which aws_completer)" aws
source "$HOME/.homesick/repos/dotfiles/bin/git-completion.bash"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
source "$HOME/.homesick/repos/dotfiles/open-bash-completion/open"
source "$HOME/.homesick/repos/dotfiles/pip-bash-completion/pip"
source "$HOME/.homesick/repos/dotfiles/vagrant-bash-completion/vagrant-bash-completion/etc/bash_completion.d/vagrant"
source "$HOME/.homesick/repos/dotfiles/vboxmanage-bash-completion/VBoxManage"
