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
  local last_rc=$? last_status="" window_title=""

  # append to history file so we never lose anything
  if [ -z "${MCFLY_SESSION_ID:-}" ] ; then
    history -a
  fi

  if [ "$__window_title_mode" = "host" ] ; then
    echo -ne "\033]0;$USER@$HOSTNAME: $PWD\007"
  fi

  if [ -z "${STARSHIP_SESSION_KEY:-}" ]; then
    # add a red ! to the beginning if the last command failed
    if [ "$last_rc" != "0" ] ; then
      last_status="\[${COLOR_LIGHT_RED}\]${last_rc}! "
    fi

    # gitify the prompt
    __git_ps1 "${last_status}${PS1_BEFORE}" "${PS1_AFTER}${window_title}"
  fi

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

  if [ -z "${NO_STARSHIP:-}" ] && [ -x "$(type -P starship)" ]; then
    eval "$(starship init bash)"
  else
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

    PS1_BEFORE="\[${COLOR_USER}\]\u\[${COLOR_GRAY}\]@\[${COLOR_HOST}\]\h\[${COLOR_GRAY}\]:\[${COLOR_NONE}\]\w"
    PS1_AFTER="\[${COLOR_GRAY}\]\$\[${COLOR_NONE}\] "
  fi
}

__configure_prompt
