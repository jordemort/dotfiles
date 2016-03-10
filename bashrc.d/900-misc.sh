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

# save multi-line commands as one command
shopt -s cmdhist

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

# correct spelling on directory names
shopt -s dirspell
shopt -s cdspell

# save some time changing directories
export CDPATH=".:$HOME/Source:$HOME/GitHub"

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
