# load gpg agent environment
if [ -e "$HOME/.gpg-agent-info" ] ; then
  . $HOME/.gpg-agent-info
  export GPG_AGENT_INFO
  if [ ! -L $HOME/.gitconfig ] ; then
    rm -f $HOME/.gitconfig
    ln -s $HOME/.homesick/repos/dotfiles/home/.gitconfig $HOME/.gitconfig
  fi
elif [ -L $HOME/.gitconfig ] || [ $HOME/.homesick/repos/dotfiles/home/.gitconfig -nt $HOME/.gitconfig ] ; then
  rm -f $HOME/.gitconfig
  cp $HOME/.homesick/repos/dotfiles/home/.gitconfig $HOME/.gitconfig
  git config --global commit.gpgsign false
fi
