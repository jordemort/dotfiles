if echo "$SSH_AUTH_SOCK" | grep -q 'com.apple.launchd' ; then
  export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
fi
