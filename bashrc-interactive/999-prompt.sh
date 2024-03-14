#!/usr/bin/env bash

# figure out if we're setting window titles
__window_title_mode=
case $TERM in
  screen*|rxvt|xterm*)
    [ "$TERM_PROGRAM" = "Apple_Terminal" ] || __window_title_mode="host"
  ;;
esac

__my_prompt_command()
{
  local last_rc=$? last_status=""

  # append to history file so we never lose anything
  if [ -z "${MCFLY_SESSION_ID:-}" ] ; then
    history -a
  fi

  if [ "$__window_title_mode" = "host" ] ; then
    echo -ne "\033]0;$USER@$HOSTNAME: $PWD\007"
  fi

  # add a red ! to the beginning if the last command failed
  if [ "$last_rc" != "0" ] ; then
    last_status="\[${COLOR_LIGHT_RED}\]${last_rc}! "
  fi

  # gitify the prompt
  __git_ps1 "${last_status}${PS1_BEFORE}" "${PS1_AFTER}"

  return $last_rc
}

__configure_prompt() {
  if [ -z "$PROMPT_COMMAND" ]; then
    PROMPT_COMMAND="__my_prompt_command"
  else
    PROMPT_COMMAND="__my_prompt_command;${PROMPT_COMMAND#;}"
  fi

  # shellcheck source=submodules/iTerm2-shell-integration/shell_integration/bash
  source "$HOME/.homesick/repos/dotfiles/submodules/iTerm2-shell-integration/shell_integration/bash"

  # shellcheck disable=SC2034
  GIT_PS1_SHOWDIRTYSTATE=1
  # shellcheck disable=SC2034
  GIT_PS1_SHOWUNTRACKEDFILES=1
  # shellcheck disable=SC2034
  GIT_PS1_SHOWUPSTREAM=verbose
  # shellcheck disable=SC2034
  GIT_PS1_SHOWCOLORHINTS=1

  # shellcheck source=generated/git-prompt.sh
  source "$HOME/.homesick/repos/dotfiles/generated/git-prompt.sh"

  PS1_BEFORE="\[\033[7m${COLOR_HOST}\]"

  if [ -n "${SSH_CONNECTION:-}" ] ; then
    PS1_BEFORE="$PS1_BEFORE 🐚"
  fi

  PS1_BEFORE="$PS1_BEFORE \h \[${COLOR_NONE}\033[7m\] \w \[${COLOR_NONE}\]"

  if [ "$USER" != "jordan" ] ; then
    PS1_BEFORE="\[\033[7m${COLOR_USER}\] \u $PS1_BEFORE"
  fi

  PS1_AFTER="\n\[${COLOR_LIGHT_PURPLE}\]\$\[${COLOR_NONE}\] "
}

__configure_prompt

# shellcheck disable=SC1090
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path bash)"
