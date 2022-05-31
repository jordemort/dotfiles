#!/usr/bin/env bash

if [ -n "$(type -P scutil)" ] && [ "$(scutil --get LocalHostName)" = "dot" ]; then
  gpg-connect-agent /bye || gpgconf --launch gpg-agent
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
