#!/usr/bin/env bash
set -euo pipefail

if [ -z "${LOGGING_DOTFILES_SETUP:-}" ] ; then
  echo "# $(date)" > "$HOME/.dotfiles-setup.log"
  LOGGING_DOTFILES_SETUP=1 exec "$0" >> "$HOME/.dotfiles-setup.log" 2>&1
fi

set -x

preferred_path="$HOME/.homesick/repos/dotfiles/setup.sh"
preferred_dir="$(dirname "$preferred_path")"

if [ "$(readlink -f "$0")" != "$preferred_path" ] ; then
  current_dir=$(dirname "$(readlink -f "$0")")
  mv "$current_dir" "$preferred_dir"
fi

cd "$(dirname "$preferred_path")"
git submodule init
git submodule update

if [ ! -d "$HOME/.homesick/repos/homeshick" ] ; then
  git clone git://github.com/andsens/homeshick.git "$HOME/.homesick/repos/homeshick"
fi

$HOME/.homesick/repos/homeshick/bin/homeshick link -f dotfiles

if [ ! -e "$HOME/.gnupg/pubring.kbx" ] ; then
  mkdir -p "$HOME/.gnupg"
  chmod 700 "$HOME/.gnupg"
  gpg --import < "$HOME/.homesick/repos/dotfiles/misc/key.pub"
  echo "304E3D8D4A14C451DBA5582AC341950C47B6CE14:6:" | gpg --import-ownertrust
fi
