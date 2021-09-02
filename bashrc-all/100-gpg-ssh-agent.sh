#!/usr/bin/env bash

if [ "$HOSTNAME" = "betsy.webb.haus" ]; then
  gpg-connect-agent /bye || gpgconf --launch gpg-agent
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
