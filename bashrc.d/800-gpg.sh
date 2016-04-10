# load gpg agent environment
if [ -e "$HOME/.gpg-agent-info" ] ; then
    . $HOME/.gpg-agent-info
    export GPG_AGENT_INFO
fi
