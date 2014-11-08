source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

#homeshick --quiet refresh

# build PATH
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
pre_path=("/opt/local/bin" "/opt/local/sbin" "$HOME/Library/Python/2.7/bin" "$HOME/bin")
post_path=("/usr/local/games /usr/games")

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

# immediately write and re-read history file every command
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# no vi please
subl=$(type -P subl)
if [ -x "$subl" ] ; then
	export VISUAL="subl -w"
else
	export VISUAL="nano"
fi

export EDITOR=$VISUAL
