#!/usr/bin/env bash

gpgconf --launch gpg-agent
export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"

if [ ! -e "$HOME/.gnupg/pubring.kbx" ] ; then
  mkdir -p "$HOME/.gnupg"
  chmod 700 "$HOME/.gnupg"
  gpg --import < "$HOME/.homesick/repos/dotfiles/misc/key.pub"
  echo "304E3D8D4A14C451DBA5582AC341950C47B6CE14:6:" | gpg --import-ownertrust
fi
