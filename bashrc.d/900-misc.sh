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
if which rlwrap > /dev/null 2>&1; then
        alias nslookup='rlwrap nslookup'
fi

# load bash_completion
if [ -f /etc/bash_completion ] ; then
        source /etc/bash_completion
fi

# load homeshick completions
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
