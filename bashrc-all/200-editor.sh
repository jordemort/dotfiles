#!/usr/bin/env bash
# no vi please
EDITOR="nano"

# Look for codium
zed=$(type -P zed)

if [ -x "$zed" ]; then
	# If we have it, alias everything over there
	EDITOR="zed -w"
	alias codium=zed
	alias code=zed
	alias nano=zed
	alias subl=zed
else
	# Otherwise, we want nano
	alias codium=nano
	alias code=nano
	alias subl=nano
	alias zed=nano
fi

VISUAL=$EDITOR

export EDITOR VISUAL
