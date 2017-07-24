#!bash
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# load last 1000 lines from history, never truncate, ignore dups
HISTSIZE=1000
HISTFILESIZE=
HISTCONTROL=ignoredups

# timestamp history
HISTTIMEFORMAT="%Y-%m-%d %T "

# append to history file, don't overwrite
shopt -s histappend

# save multi-line commands as one command
shopt -s cmdhist

# make jobs output useful
alias jobs="jobs -l"

# use hub instead of git if we have it
if [ -n "$(type -P hub)" ] ; then
	eval "$(hub alias -s)"
fi

# give nslookup some line editing
if [ -n "$(type -P rlwrap)" ] ; then
	alias nslookup='rlwrap nslookup'
fi

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

# keep less from clearing the screen, display line numbers and ANSI colors
export LESS=-XMR

# use lessopen
export LESSOPEN="|lesspipe.sh %s"

if [ -n "$(type -P pygmentize)" ] ; then
	export LESSCOLORIZER=pygmentize
fi

# set debian env based on git
export DEBFULLNAME=$(git config --global user.name)
export DEBEMAIL=$(git config --global user.email)

# correct spelling on directory names
if [ "${BASH_VERSINFO[0]}" -gt "4" ] ; then
	shopt -s dirspell
fi
shopt -s cdspell

# save some time changing directories
CDPATH=".:$HOME/Source:$HOME/GitHub:$HOME/.homesick/repos"

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
		# check because c-n-f could've been removed in the meantime
		if [ -x /usr/lib/command-not-found ]; then
			/usr/lib/command-not-found -- "$1"
			return $?
		elif [ -x /usr/share/command-not-found/command-not-found ]; then
			/usr/share/command-not-found/command-not-found -- "$1"
			return $?
		else
			printf "%s: command not found\n" "$1" >&2
			return 127
		fi
	}
fi
