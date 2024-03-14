#!/usr/bin/env bash
# no vi please
EDITOR="nano"

# Look for VS Code
code=$(type -P code)

if [ -x "$code" ]; then
	# If we have it, alias everything over there
	EDITOR="code -w"
	alias nano=code
	alias subl=code
else
	# Otherwise, we want nano
	alias code=nano
	alias subl=nano
fi

VISUAL=$EDITOR

export EDITOR VISUAL
