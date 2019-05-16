#!/usr/bin/env bash

# for local config, secrets, etc
if [ -e "$HOME/.bashrc.local" ] ; then
  # shellcheck disable=SC1090
  . "$HOME/.bashrc.local"
fi

DOTFILES="$HOME/.homesick/repos/dotfiles"
for rc in "$DOTFILES/bashrc-all/"*.sh ; do
  if [ -x "$rc" ] ; then
    # shellcheck disable=SC1090
    source "$rc"
  fi
done

if [ -n "$PS1" ] ; then
  for rc in "$DOTFILES/bashrc-interactive/"*.sh ; do
    if [ -x "$rc" ] ; then
      # shellcheck disable=SC1090
      source "$rc"
    fi
  done
fi
