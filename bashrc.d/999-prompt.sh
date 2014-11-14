# figure out if we're setting window titles
use_set_title=no
case $TERM in
	screen*|rxvt|*term|*term-256color)
		use_set_title=yes
	;;
esac

# fancy-ish prompt
in_set_prompt=no
function set_prompt()
{
	last_rc=$?
	in_set_prompt=yes

	# add a red ! to the beginning if the last command failed
	if [ "$last_rc" != "0" ] ; then
		PS1="\[${COLOR_LIGHT_RED}\]${last_rc}! "
	else
		PS1=""
	fi

	PS1="${PS1}\[${USER_COLOR}\]\u\[${COLOR_GRAY}\]@\[${HOST_COLOR}\]\h\[${COLOR_GRAY}\]:\[${COLOR_NONE}\]\w"

	# add the git branch
	git_dir=$(git rev-parse --show-toplevel 2> /dev/null)
	if [ ! -z "$git_dir" ] ; then
		status_dir="$HOME/.git-prompt-status${git_dir}"
		mkdir -p "$status_dir"
		# do this asynchronously so it doesn't delay the prompt too much on slow remote FS
		(update-git-status.sh "$git_dir" "$status_dir" &)
		if [ -e "$status_dir/current" ] ; then
			PS1="${PS1} $(cat $status_dir/current)"
		else
			PS1="${PS1} \[${COLOR_NONE}\]..."
		fi
	fi
	PS1="${PS1}\[${COLOR_GRAY}\]\$\[${COLOR_NONE}\] "

	if [ "$use_set_title" == "yes" ] ; then
		# add proxy icon to title bar (for Terminal.app)
		PS1="${PS1}\[\033]7;file://${HOSTNAME}/$(pwd)/\007\]"
		# add host and cwd to window title
		PS1="${PS1}\[\033]0;\u@\h: \w\007\]"
	fi

	export PS1
	export PREV_COMMAND=""
	history -a
	in_set_prompt=no
}

# update fancy prompt and append to history every command
export PROMPT_COMMAND="set_prompt"

# set window title to currently running command
function set_title()
{
	if [ "$in_set_prompt" == "yes" ] || [ "$@" == "set_prompt" ] || [ "$@" == "set_title" ] ; then
		return
	fi

	export PREV_COMMAND=${PREV_COMMAND}${@}
	echo -ne "\033]0;$(hostname -s): ${PREV_COMMAND}\007"
	export PREV_COMMAND=${PREV_COMMAND}' | '
}

if [ "$use_set_title" == "yes" ] ; then
	trap 'set_title "$BASH_COMMAND"' DEBUG
fi
