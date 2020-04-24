#!/usr/bin/env bash

if [ "$(uname -s)" = "Darwin" ] ; then
  gpg-connect-agent /bye || gpgconf --launch gpg-agent
fi

export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
