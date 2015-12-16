# load git stuff
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=verbose
GIT_PS1_SHOWCOLORHINTS=1

source "$HOME/.homesick/repos/dotfiles/bin/git-prompt.sh"

echo hi
__git_ps1

# figure out if we're setting window titles
use_set_title=no
case $TERM in
	screen*|rxvt|*term|*term-256color)
		use_set_title=yes
	;;
esac

# fancy-ish prompt
in_set_prompt=no
last_git_dir='none'

function set_prompt()
{
	last_rc=$?
	in_set_prompt=yes

	# add a red ! to the beginning if the last command failed
	if [ "$last_rc" != "0" ] ; then
		PS1_BEFORE="\[${COLOR_LIGHT_RED}\]${last_rc}! "
	else
		PS1_BEFORE=""
	fi

	PS1_BEFORE="${PS1_BEFORE}\[${USER_COLOR}\]\u\[${COLOR_GRAY}\]@\[${HOST_COLOR}\]\h\[${COLOR_GRAY}\]:\[${COLOR_NONE}\]\w"

	# append le dolla
	PS1_AFTER="\[${COLOR_GRAY}\]\$\[${COLOR_NONE}\] "

	if [ "$use_set_title" == "yes" ] ; then
		# add proxy icon to title bar (for Terminal.app)
		PS1_AFTER="${PS1_AFTER}\[\033]7;file://${HOSTNAME}/$(pwd)/\007\]"
		# add host and cwd to window title
		PS1_AFTER="${PS1_AFTER}\[\033]0;\u@\h: \w\007\]"
	fi

	__git_ps1 "${PS1_BEFORE}" "${PS1_AFTER}"
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
	echo -ne "\033]0;${USER}@$(hostname -s): ${PREV_COMMAND}\007"
	export PREV_COMMAND=${PREV_COMMAND}' | '
}

if [ "$use_set_title" == "yes" ] ; then
	trap 'set_title "$BASH_COMMAND"' DEBUG
fi
