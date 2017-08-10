#!bash
# load gpg agent environment

if [ -z $(type -P gpg2) ] ; then
  [ ! -e "$HOME/.shutup_about_gpg" ] && echo "WARNING: No gpg2, your agent fowarding isn't going to work"
else
  if ! gpg2 -k B7F9C8AAA8C113BA8FA60EFD26F41A1C158FACBF > /dev/null 2>&1 ; then
    gpg2 --import "$DOTFILES/pubkey.asc"
  fi
  alias gpg=gpg2
fi

if [ -z "$GPG_AGENT_UNIX" ] && [ -e "$HOME/.gpg-agent-info" ] ; then
  . $HOME/.gpg-agent-info
  export GPG_AGENT_INFO
fi
