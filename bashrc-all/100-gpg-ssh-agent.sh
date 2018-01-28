#!bash

if grep -q 'com.apple.launchd' <<< "$SSH_AUTH_SOCK" ; then
  export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
fi
