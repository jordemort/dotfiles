#!/usr/bin/env bash
set -euo pipefail

if [ "$(readlink -f "$0")" != "$HOME/.homesick/repos/dotfiles/setup.sh" ] ; then
  mkdir -p "$HOME/.homesick/repos"
  cp -a "$(dirname "$0")" "$HOME/.homesick/repos/dotfiles"
  exec "$HOME/.homesick/repos/dotfiles/setup.sh"
fi

if [ ! -d "$HOME/.homesick/repos/homeshick" ] ; then
  git clone git://github.com/andsens/homeshick.git "$HOME/.homesick/repos/homeshick"
fi

$HOME/.homesick/repos/homeshick/bin/homeshick link -b dotfiles
