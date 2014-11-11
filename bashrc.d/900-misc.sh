# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# load last 1000 lines from history, never truncate, ignore dups
export HISTSIZE=1000
export HISTFILESIZE=
export HISTCONTROL=ignoredups

# timestamp history
export HISTTIMEFORMAT="%Y-%m-%d %T "

# append to history file, don't overwrite
shopt -s histappend

# make jobs output useful
alias jobs="jobs -l"

# give nslookup some line editing
if [ ! -z "$(type -P rlwrap)" ] ; then
	alias nslookup='rlwrap nslookup'
fi

# load bash_completion
if [ -f /etc/bash_completion ] ; then
	source /etc/bash_completion
fi

# load homeshick completions
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

# load less filter if available
export LESSOPEN="|$HOME/.homesick/repos/dotfiles/bin/pyg-lesspipe.sh %s"

# keep less from clearing the screen, display line numbers and ANSI colors
export LESS=-XMR

# set up boot2docker
if [ ! -z "$(type -P boot2docker)" ] ; then
	docker_status=$(boot2docker status)
	if [ "$docker_status" == "running" ] ; then
		eval $(boot2docker shellinit 2> /dev/null)
	fi
fi

# custom python libs
export PYTHONPATH="$HOME/.homesick/repos/dotfiles/python"

