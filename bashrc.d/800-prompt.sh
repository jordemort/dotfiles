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
		PS1="${PS1} \[${color}\]${branch}"
	fi
	PS1="${PS1}\[${COLOR_GRAY}\]\$\[${COLOR_NONE}\] "

	# add host and cwd to window title
	if [ "$use_set_title" == "yes" ] ; then
		PS1="${PS1}\033]0;\h: \w\007"
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
