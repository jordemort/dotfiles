#!bash
# load gpg agent environment

if [ -z "$GPG_AGENT_UNIX" ] && [ -e "$HOME/.gpg-agent-info" ] ; then
  . $HOME/.gpg-agent-info
  export GPG_AGENT_INFO
fi

alias gpg=gpg2
