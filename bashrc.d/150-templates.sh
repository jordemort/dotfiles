#!bash

[ -e "$HOME/.ssh/config" ] && [ ! -f "$HOME/.ssh/config" ] && rm -f "$HOME/.ssh/config"
if [ ! -e "$HOME/.ssh/config" ] || [ "$DOTFILES/home/.ssh/config.sempl" -nt "$HOME/.ssh/config" ] ; then
  sempl "$DOTFILES/home/.ssh/config.sempl" "$HOME/.ssh/config"
fi
