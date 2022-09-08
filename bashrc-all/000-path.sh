#!/usr/bin/env bash

if (( BASH_VERSINFO[0] > 3 )) ; then
  # shellcheck source=submodules/path/path.sh
  source "$HOME/.homesick/repos/dotfiles/submodules/path/path.sh"
else
  # shellcheck source=submodules/path/path-v3.sh
  source "$HOME/.homesick/repos/dotfiles/submodules/path/path-v3.sh"
fi

# add these to PATH if they exist
maybe_path=(
  "/usr/local/opt/coreutils/libexec/gnubin"
  "/opt/homebrew/opt/coreutils/libexec/gnubin"
  "/opt/X11/bin"
  "/usr/local/MacGPG2/bin"
  "/opt/homebrew/opt/mysql-client/bin"
  "/opt/homebrew/opt/libpq/bin"
  "/opt/homebrew/bin"
  "/opt/homebrew/opt/ruby/bin"
  "/opt/homebrew/lib/ruby/gems/3.1.0/bin"
)

for p in "${maybe_path[@]}" ; do
  if [ -d "$p" ] && [ -x "$p" ] ; then
    path PATH prepend "$p"
  fi
done

# source asdf
# shellcheck source=submodules/asdf/asdf.sh
source "$HOME/.homesick/repos/dotfiles/submodules/asdf/asdf.sh"

# add iterm2 stuff
path PATH prepend "$HOME/.homesick/repos/dotfiles/submodules/iTerm2-shell-integration/utilities"

# add dotfiles/bin
path PATH prepend "$HOME/.homesick/repos/dotfiles/bin"

# add (and create, if necessary) local bins
mkdir -p "$HOME/.local/bin" "$HOME/bin"
path PATH prepend "$HOME/.local/bin"
path PATH prepend "$HOME/bin"

# if ~/.venv is a thing put it in path
if [ -d "$HOME/.venv/bin" ]; then
  path PATH prepend "$HOME/.venv/bin"
fi

# make sure things are tidy
path PATH clean --real
