#!/usr/bin/env bash
set -euo pipefail

preferred_path="$HOME/.homesick/repos/dotfiles/setup.sh"
preferred_dir="$(dirname "$preferred_path")"

if [ "$(readlink -f "$0")" != "$preferred_path" ] ; then
  if [ ! -e "$preferred_path" ] ; then
    mkdir -p "$preferred_dir"
    cp -a "$(dirname "$0")" "$preferred_dir"
  fi
  exec "$preferred_path"
fi

if [ ! -d "$HOME/.homesick/repos/homeshick" ] ; then
  git clone git://github.com/andsens/homeshick.git "$HOME/.homesick/repos/homeshick"
fi

$HOME/.homesick/repos/homeshick/bin/homeshick link -f dotfiles
