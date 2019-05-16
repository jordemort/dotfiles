#!/usr/bin/env bash
# load git stuff
# shellcheck disable=SC2034
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=verbose
GIT_PS1_SHOWCOLORHINTS=1

# shellcheck source=../generated/git-prompt.sh
source "$HOME/.homesick/repos/dotfiles/generated/git-prompt.sh"

if [[ $TERM =~ "256color" ]]; then
  # hand picked list of "readable" colors
  # shellcheck disable=SC2207
  dynamic_colors=($(seq 3 6) 10 $(seq 12 14) $(seq 22 45) $(seq 58 81) $(seq 99 112) $(seq 124 153) $(seq 160 187) $(seq 196 219))
  pre_dyanmic_color='38;5;'
else
  dynamic_colors=("0;33" "0;34" "0;35" "0;36" "1;32" "1;34" "1;35" "1;36")
  pre_dyanmic_color=''
fi

# generate unique colors for user and host
user_hash=$(echo $USER | cksum | cut -c2-5)
host_hash=$(hostname -s | cksum | cut -c2-5)
user_index=$(($user_hash % ${#dynamic_colors[@]}))
host_index=$(($host_hash % ${#dynamic_colors[@]}))
user_color='\033['${pre_dyanmic_color}${dynamic_colors[${user_index}]}'m'
host_color='\033['${pre_dyanmic_color}${dynamic_colors[${host_index}]}'m'

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

  PS1_BEFORE="${PS1_BEFORE}\[${user_color}\]\u\[${COLOR_GRAY}\]@\[${host_color}\]\h\[${COLOR_GRAY}\]:\[${COLOR_NONE}\]\w"
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
  # shellcheck disable=SC2198
  if [ "$use_set_title" != "yes" ] || [ "$in_set_prompt" == "yes" ] || [ "$@" == "set_prompt" ] || [ "$@" == "set_title" ] ; then
    return
  fi
  # shellcheck disable=SC2124
  PREV_COMMAND=${PREV_COMMAND}${@}
  if [ "$TERM_PROGRAM" = "Apple_Terminal" ] ; then
    echo -ne "\033]0;${PREV_COMMAND}\007"
  else
    echo -ne "\033]0;${USER}@$(hostname -s): ${PREV_COMMAND}\007"
  fi
  PREV_COMMAND=${PREV_COMMAND}' | '
}

trap 'set_title "$BASH_COMMAND"' DEBUG
