# fancy-ish prompt
function set_prompt()
{
	last_rc=$?
	if [ "$last_rc" != "0" ] ; then
		PS1="\[${COLOR_LIGHT_RED}\]${last_rc}!\[${COLOR_NONE}\] "
	else
		PS1=""
	fi

	PS1="${PS1}\u\[${COLOR_GRAY}\]@\[${COLOR_NONE}\]\h\[${COLOR_GRAY}\]:\[${COLOR_NONE}\]\w"
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

	export PS1
}

# update fancy prompt and append to history every command
export PROMPT_COMMAND="set_prompt ; history -a"
