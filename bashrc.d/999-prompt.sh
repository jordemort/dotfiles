#!bash
# load git stuff
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=verbose
GIT_PS1_SHOWCOLORHINTS=1

source "$HOME/.homesick/repos/dotfiles/bin/git-prompt.sh"

# figure out if we're setting window titles
use_set_title=no
case $TERM in
	screen*|rxvt|xterm*)
		use_set_title=yes
	;;
esac

# fancy-ish prompt
in_set_prompt=no

function urlencode()
{
  # urlencode <string>
  old_lc_collate=$LC_COLLATE
  LC_COLLATE=C

  local length="${#1}"
  for (( i = 0; i < length; i++ )); do
    local c="${1:i:1}"
    case $c in
      [a-zA-Z0-9.~_-]) printf "$c" ;;
      *) printf '%%%02X' "'$c" ;;
    esac
  done

  LC_COLLATE=$old_lc_collate
}

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
	PS1_AFTER="\[${COLOR_GRAY}\]\$\[${COLOR_NONE}\] "

	if [ "$use_set_title" == "yes" ] ; then
		if [ "$TERM_PROGRAM" = "Apple_Terminal" ] ; then
			# add proxy icon to title bar (for Terminal.app)
			PS1_AFTER="${PS1_AFTER}\[\033]7;file://${HOSTNAME}/$(urlencode "$(pwd)")/\007\]\[\033]0;\007\]"
		else
			# add host and cwd to window title
			PS1_AFTER="${PS1_AFTER}\[\033]0;\u@\h: \w\007\]"
		fi
	fi

	# gitify the prompt
	__git_ps1 "${PS1_BEFORE}" "${PS1_AFTER}"

	# reset
	PREV_COMMAND=""

	# append to history file so we never lose anything, and then we're done
	history -a
	in_set_prompt=no
}

# update fancy prompt and append to history every command
PROMPT_COMMAND="set_prompt"

# set window title to currently running command
function set_title()
{
	if [ "$use_set_title" != "yes" ] || [ "$in_set_prompt" == "yes" ] || [ "$@" == "set_prompt" ] || [ "$@" == "set_title" ] ; then
		return
	fi
	PREV_COMMAND=${PREV_COMMAND}${@}
	if [ "$TERM_PROGRAM" = "Apple_Terminal" ] ; then
		echo -ne "\033]0;${PREV_COMMAND}\007"
	else
		echo -ne "\033]0;${USER}@$(hostname -s): ${PREV_COMMAND}\007"
	fi
	PREV_COMMAND=${PREV_COMMAND}' | '
}

trap 'set_title "$BASH_COMMAND"' DEBUG
