#!bash

function cleanup_sockets() {
  [ -S "$RMATE_UNIX" ] && [ "$RMATE_UNIX" = "$HOME/.rmate.$$" ] && rm -f "$RMATE_UNIX"
  [ -S "$HOME/.gnupg/S.gpg-agent.remote.$$" ] && rm -f "$HOME/.gnupg/S.gpg-agent.$$"
  other_gpg_agent=$(ls --sort=t $HOME/.gnupg/S.gpg-agent.remote.* | head -n1)
  [ -n "$other_gpg_agent" ] && ln -sf "$other_gpg_agent" "$HOME/.gnupg/S.gpg-agent"
}

GPG_AGENT_UNIX=

if [ -n "$SSH_CONNECTION" ] ; then
  if [ -e "$HOME/.rmate.in" ] ; then
    mv "$HOME/.rmate.in" "$HOME/.rmate.$$"
    export RMATE_UNIX="$HOME/.rmate.$$"
  fi
  if [ -e "$HOME/.gnupg/S.gpg-agent.in" ] ; then
    GPG_AGENT_UNIX="$HOME/.gnupg/S.gpg-agent.remote.$$"
    GPG_AGENT_LINK="$HOME/.gnupg/S.gpg-agent"
    mv "$HOME/.gnupg/S.gpg-agent.in" "$GPG_AGENT_UNIX"
    [ -e "$GPG_AGENT_LINK" ] && [ ! -L "$GPG_AGENT_LINK" ] && rm -rf "$GPG_AGENT_LINK"
    ln -sf "$GPG_AGENT_UNIX" "$GPG_AGENT_LINK"
  fi
  trap cleanup_sockets EXIT
fi
