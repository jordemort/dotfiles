#!/usr/bin/env bash
set -euo pipefail

if [ -z "${LOGGING_DOTFILES_SETUP:-}" ] ; then
  echo "# $(date)" > "$HOME/.dotfiles-setup.log"
  LOGGING_DOTFILES_SETUP=1 exec "$0" >> "$HOME/.dotfiles-setup.log" 2>&1
fi

set -x

homesick_repos="$HOME/.homesick/repos"
preferred_dir="$homesick_repos/dotfiles"
homeshick_dir="$homesick_repos/homeshick"
current_dir=$(dirname "$(readlink -f "$0")")

if [ "$current_dir" != "$preferred_dir" ] ; then
  mkdir -p "$(dirname "$preferred_dir")"
  mv "$current_dir" "$preferred_dir"
fi

cd "$preferred_dir"
git submodule init
git submodule update

if [ ! -d "$homeshick_dir" ] ; then
  git clone git://github.com/andsens/homeshick.git "$homeshick_dir"
fi

"$homeshick_dir/bin/homeshick" link -f dotfiles

if [ ! -e "$HOME/.gnupg/pubring.kbx" ] ; then
  mkdir -p "$HOME/.gnupg"
  chmod 700 "$HOME/.gnupg"
  gpg --import < "$preferred_dir/misc/key.pub"
  echo "304E3D8D4A14C451DBA5582AC341950C47B6CE14:6:" | gpg --import-ownertrust
fi
