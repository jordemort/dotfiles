#!bash

function cleanup_sockets() {
  [ -e "$RMATE_UNIX" ] && [ "$RMATE_UNIX" = "$HOME/.rmate.$$" ] && rm -f "$RMATE_UNIX"
  other_rmate=$(ls --sort=t $HOME/.rmate.[0-9]* 2>/dev/null | head -n1)
  [ -n "$other_rmate" ] && ln -sf "$other_rmate" "$HOME/.rmate.default"
  
  [ -e "$HOME/.gnupg/S.gpg-agent.remote.$$" ] && rm -f "$HOME/.gnupg/S.gpg-agent.remote.$$"
  other_gpg_agent=$(ls --sort=t $HOME/.gnupg/S.gpg-agent.remote.* 2>/dev/null | head -n1)
  [ -n "$other_gpg_agent" ] && ln -sf "$other_gpg_agent" "$HOME/.gnupg/S.gpg-agent"
}

GPG_AGENT_UNIX=

if [ -n "$SSH_CONNECTION" ] ; then
  if [ -e "$HOME/.rmate.in" ] ; then
    mv "$HOME/.rmate.in" "$HOME/.rmate.$$"
    ln -sf "$HOME/.rmate.$$" "$HOME/.rmate.default"
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
