#!/usr/bin/env bash
# no vi please
EDITOR="nano"

# Look for codium
codium=$(type -P codium)

if [ -x "$codium" ] && [ -n "${SSH_CONNECTION:-}" ]; then
	codium_dir=$(cd "$(dirname "$(which codium)")" && echo $(basename $(pwd)))
	if [ "$codium_dir" != "remote-cli" ]; then
		# Avoid using codium installed on remote system over SSH
		codium=""
	fi
fi

if [ -x "$codium" ]; then
	# If we have it, alias everything over there
	EDITOR="codium -w"
	alias code=codium
	alias nano=codium
	alias subl=codium
else
	# Otherwise, we want nano
	alias codium=nano
	alias code=nano
	alias subl=nano
fi

VISUAL=$EDITOR

export EDITOR VISUAL
