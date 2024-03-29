#!/usr/bin/env bash

# if the command-not-found package is installed, use it
if [ -n "$(type -P brew)" ]; then
	# shellcheck source=generated/brew-command-not-found.sh
	source "$HOME/.homesick/repos/dotfiles/generated/brew-command-not-found.sh"
else
	if [ -x /usr/lib/command-not-found ]; then
		command_not_found=/usr/lib/command-not-found
	elif [ -x /usr/share/command-not-found/command-not-found ]; then
		command_not_found=/usr/share/command-not-found/command-not-found
	else
		return
	fi

	function command_not_found_handle {
		# check because c-n-f could've been removed in the meantime
		if [ -x "$command_not_found" ]; then
			"$command_not_found" -- "$1"
		else
			printf "%s: command not found\n" "$1" >&2
		fi
		return 127
	}
fi
