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
    [ "$TERM_PROGRAM" = "Apple_Terminal" ] || WINDOW_TITLE_MODE="host"
  ;;
esac

function jordemort_prompt()
{
  local last_rc=$? last_status="" window_title=""

  # append to history file so we never lose anything
  history -a

  # add a red ! to the beginning if the last command failed
  if [ "$last_rc" != "0" ] ; then
    last_status="\[${COLOR_LIGHT_RED}\]${last_rc}! "
  fi

  if [ "$WINDOW_TITLE_MODE" = "host" ] ; then
    window_title="\[\033]0;\u@\h: \w\007\]"
  fi

  # gitify the prompt
  __git_ps1 "${last_status}${PS1_BEFORE}" "${PS1_AFTER}${window_title}"

  return $last_rc
}

# update fancy prompt and append to history every command
PROMPT_COMMAND="jordemort_prompt${PROMPT_COMMAND:+" ; $PROMPT_COMMAND"}"
