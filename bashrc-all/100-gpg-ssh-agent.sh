#!/usr/bin/env bash

if [ "$(uname -o)" = "Darwin" ] ; then
  gpgconf --launch gpg-agent
  export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
fi
