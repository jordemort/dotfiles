#!/usr/bin/env bash

if ((BASH_VERSINFO[0] > 3)); then
	# shellcheck source=submodules/path/path.sh
	source "$HOME/.homesick/repos/dotfiles/submodules/path/path.sh"
else
	# shellcheck source=submodules/path/path-v3.sh
	source "$HOME/.homesick/repos/dotfiles/submodules/path/path-v3.sh"
fi

# add these to PATH if they exist
maybe_path=(
	"/opt/homebrew/opt/mysql-client/bin"
	"/opt/homebrew/opt/libpq/bin"
	"/opt/homebrew/bin"
	"/opt/homebrew/opt/coreutils/libexec/gnubin"
	"/opt/X11/bin"
)

for p in "${maybe_path[@]}"; do
	if [ -d "$p" ] && [ -x "$p" ]; then
		path PATH prepend "$p"
	fi
done

if [ -x /opt/homebrew/opt/ruby/bin/ruby ]; then
	path PATH prepend /opt/homebrew/opt/ruby/bin
fi

# add iterm2 stuff
path PATH prepend "$HOME/.homesick/repos/dotfiles/submodules/iTerm2-shell-integration/utilities"

# add dotfiles/bin
path PATH prepend "$HOME/.homesick/repos/dotfiles/bin"

# add (and create, if necessary) local bins
mkdir -p "$HOME/.local/bin" "$HOME/bin"
path PATH prepend "$HOME/.local/bin"
path PATH prepend "$HOME/bin"

# add updated git install on danger design box
if [ -x /data/git/latest/git ]; then
	path PATH prepend /data/git/latest
fi

# make sure things are tidy
path PATH clean --real
