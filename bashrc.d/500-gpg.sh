#!bash
# load gpg agent environment
if [ -e "$HOME/.gpg-agent-info" ] ; then
  . $HOME/.gpg-agent-info
  export GPG_AGENT_INFO
  if [ ! -L $HOME/.gitconfig ] ; then
    rm -f $HOME/.gitconfig
    ln -s $HOME/.homesick/repos/dotfiles/home/.gitconfig $HOME/.gitconfig
  fi
elif [ -e $HOME/.gnupg/S.remote-gpg-agent ] ; then
  export GPG_AGENT_INFO=$HOME/.gnupg/S.remote-gpg-agent.$$
  rm -f $GPG_AGENT_INFO
  mv $HOME/.gnupg/S.remote-gpg-agent $GPG_AGENT_INFO
fi

if [ -z "$GPG_AGENT_INFO" ] ; then
  if [ -L $HOME/.gitconfig ] || [ $HOME/.homesick/repos/dotfiles/home/.gitconfig -nt $HOME/.gitconfig ] ; then
    rm -f $HOME/.gitconfig
    cp $HOME/.homesick/repos/dotfiles/home/.gitconfig $HOME/.gitconfig
    git config --global commit.gpgsign false
  fi
fi
