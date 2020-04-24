#!/usr/bin/env bash
# load git stuff
# shellcheck disable=SC2034
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=verbose
GIT_PS1_SHOWCOLORHINTS=1

# shellcheck source=generated/git-prompt.sh
source "$HOME/.homesick/repos/dotfiles/generated/git-prompt.sh"

PS1_BEFORE="\[${COLOR_USER}\]\u\[${COLOR_GRAY}\]@\[${COLOR_HOST}\]\h\[${COLOR_GRAY}\]:\[${COLOR_NONE}\]\w"
PS1_AFTER="\[${COLOR_GRAY}\]\$\[${COLOR_NONE}\] "

# figure out if we're setting window titles
WINDOW_TITLE_MODE=
case $TERM in
  screen*|rxvt|xterm*)
    if [ "$TERM_PROGRAM" = "Apple_Terminal" ] ; then
      WINDOW_TITLE_MODE="file"
    else
      WINDOW_TITLE_MODE="host"
    fi
  ;;
esac

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

function jordemort_prompt()
{
  local last_rc=$? last_status="" window_title=""

  # append to history file so we never lose anything
  history -a

  # add a red ! to the beginning if the last command failed
  if [ "$last_rc" != "0" ] ; then
    last_status="\[${COLOR_LIGHT_RED}\]${last_rc}! "
  fi

  case $WINDOW_TITLE_MODE in
    file)
      window_title="\[\033]7;file://${HOSTNAME}/$(urlencode "$(pwd)")/\007\]\[\033]0;\007\]"
      ;;
    host)
      window_title="${PS1_AFTER}\[\033]0;\u@\h: \w\007\]"
      ;;
  esac

  # gitify the prompt
  __git_ps1 "${last_status}${PS1_BEFORE}" "${PS1_AFTER}${window_title}"

  return $last_rc
}

# update fancy prompt and append to history every command
PROMPT_COMMAND="jordemort_prompt${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
