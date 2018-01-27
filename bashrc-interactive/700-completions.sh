#!bash

# load bash_completion if it isn't already loaded for us
if [ -z "$BASH_COMPLETION" ] ; then
	if [ -e /usr/local/etc/bash_completion ] ; then
		# check for one installed by homebrew first
		source /usr/local/etc/bash_completion
	elif [ -e /etc/bash_completion ] ; then
		# otherwise maybe it's here?
		source /etc/bash_completion
	fi
fi

# always load these
# shellcheck source=../generated/git-completion.bash
source "$HOME/.homesick/repos/dotfiles/generated/git-completion.bash"
# shellcheck source=../../homeshick/completions/homeshick-completion.bash
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

# load these as appropriate
[ "$(type -P aws_completer)" ] && complete -C "$(which aws_completer)" aws
# shellcheck source=../submodules/open-bash-completion/open
[ "$UNAME" = "Darwin" ] && source "$HOME/.homesick/repos/dotfiles/submodules/open-bash-completion/open"
# shellcheck source=../submodules/vagrant-bash-completion/vagrant-bash-completion/etc/bash_completion.d/vagrant
[ "$(type -P vagrant)" ] && source "$HOME/.homesick/repos/dotfiles/submodules/vagrant-bash-completion/vagrant-bash-completion/etc/bash_completion.d/vagrant"
# shellcheck source=../submodules/vboxmanage-bash-completion/VBoxManage
[ "$(type -P vboxmanage)" ] && source "$HOME/.homesick/repos/dotfiles/submodules/vboxmanage-bash-completion/VBoxManage"
