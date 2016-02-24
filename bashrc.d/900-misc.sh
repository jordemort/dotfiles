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

# load misc completions
source "$HOME/.homesick/repos/dotfiles/bash-completion/bash_completion"

# load homeshick completions
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

# load git completions
source "$HOME/.homesick/repos/dotfiles/bin/git-completion.bash"

# keep less from clearing the screen, display line numbers and ANSI colors
export LESS=-XMR

# use lessopen
export LESSOPEN="|$HOME/.homesick/repos/dotfiles/bin/./lesspipe.sh %s"

# set debian env based on git
export DEBFULLNAME=$(git config --global user.name)
export DEBEMAIL=$(git config --global user.email)

