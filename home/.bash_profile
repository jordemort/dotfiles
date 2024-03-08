#!/usr/bin/env bash

if [ -e "$HOME/.bashrc" ] ; then
  # shellcheck source=home/.bashrc
  . "$HOME/.bashrc"
fi

fortune=$(type -P fortune)

if [ -x "${fortune}" ] ; then
  fortune
  echo
fi
