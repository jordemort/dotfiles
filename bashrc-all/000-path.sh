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
  "/opt/X11/bin"
  "/usr/local/MacGPG2/bin"
)

for p in "${maybe_path[@]}" ; do
  if [ -d "$p" ] && [ -x "$p" ] ; then
    path PATH prepend "$p"
  fi
done

# source asdf
# shellcheck source=submodules/asdf/asdf.sh
source "$HOME/.homesick/repos/dotfiles/submodules/asdf/asdf.sh"

# allow a globally configured rbenv to override asdf
if path PATH in /usr/share/rbenv/shims 2>/dev/null ; then
  path PATH prepend /usr/share/rbenv/shims
fi

# always add dotfiles/bin
path PATH prepend "$HOME/.homesick/repos/dotfiles/bin"

# always add $HOME/bin, even if it doesn't exist yet
path PATH prepend "$HOME/bin"

# make sure things are tidy
path PATH clean --real
