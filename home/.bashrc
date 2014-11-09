# first, jump into tmux if this is ssh and it's available
if [ ! -z "$SSH_CONNECTION" ] && [ -z "$TMUX" ] && [ ! -z "$(type -P tmux)" ] ; then
	if tmux list-sessions > /dev/null 2>&1; then
		for client in `tmux list-clients | cut -d':' -f1` ; do
			MESSAGE="Login on"`tty`" ${SSH_CLIENT}"
			tmux display-message -t $client "${MESSAGE}"
		done
		FIRST=`tmux list-sessions | grep -v attached | cut -d: -f1 | head -n1`
		if [ ! -z "$FIRST" ] ; then
			# if there's an unattached tmux session, grab that
			exec tmux attach-session -t $FIRST
		else
			# otherwise, start a new tmux session
			exec tmux new-session
		fi
	else
		# otherwise, start a new tmux session
		exec tmux new-session
	fi
fi

# get homeshick set up
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

homeshick --quiet refresh

# build PATH
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

pre_path=(
	"/opt/X11/bin"
	"/opt/local/bin"
	"/opt/local/sbin"
	"$HOME/Library/Python/2.7/bin"
	"$HOME/.homesick/repos/dotfiles/bin"
	"$HOME/bin"
)

post_path=(
	"/usr/local/games"
	"/usr/games"
)

for p in "${pre_path[@]}" ; do
	if [ -d "$p" ] ; then
		PATH="$p:$PATH"
	fi
done

for p in "${post_path[@]}" ; do
	if [ -d "$p" ] ; then
		PATH="$PATH:$p"
	fi
done

export PATH

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

# no vi please
export VISUAL="nano"

subl=$(type -P subl)

if [ -x "$subl" ] ; then
	export VISUAL="subl -w"
elif [ ! -z "$SSH_CONNECTION" ] ; then
	if bash -c 'head -c0 < /dev/tcp/127.0.0.1/62859' 2>/dev/null ; then
		export VISUAL="rmate -p 62859 -w"
		alias subl="rmate -p 62859"
	fi
fi

export EDITOR=$VISUAL

# colors!
export CLICOLOR=1
export COLOR_RESET='\033[0m'
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'

# lists all the colors
alias colors="set | egrep 'COLOR_\w*' | sort"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# fancy-ish prompt
function set_prompt()
{
	last_rc=$?
	if [ "$last_rc" != "0" ] ; then
		PS1="\[${COLOR_LIGHT_RED}\]${last_rc}!\[${COLOR_RESET}\] "
	else
		PS1=""
	fi

	PS1="${PS1}\u@\h:\w"
	branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

	if [ ! -z "$branch" ] ; then
		status=$(git status -s | grep -v '^!!' 2>/dev/null)
		if [ -z "$status" ] ; then
			color=$COLOR_GREEN
		else
			status=$(echo "$status" | grep -v '^??')
			if [ -z "$status" ] ; then
				color=$COLOR_YELLOW
			else
				color=$COLOR_RED
			fi
		fi
		PS1="${PS1} \[${color}\]${branch}\[${COLOR_RESET}\]"
	fi
	PS1="${PS1}\$ "

	export PS1
}

# update fancy prompt and append to history every command
export PROMPT_COMMAND="set_prompt ; history -a"

# make jobs output useful
alias jobs="jobs -l"

# give nslookup some line editing
if which rlwrap > /dev/null 2>&1; then
        alias nslookup='rlwrap nslookup'
fi

if [ -f /etc/bash_completion ] ; then
        source /etc/bash_completion
fi
