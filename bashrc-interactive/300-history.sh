#!/usr/bin/env bash

if [ -x "$(type -P mcfly)" ]; then
	export MCFLY_FUZZY=2
	eval "$(mcfly init bash)"
fi

if [ -z "${MCFLY_SESSION_ID:-}" ]; then
	# load last 1000 lines from history, never truncate, ignore dups
	HISTSIZE=1000
	HISTFILESIZE=
	HISTCONTROL=ignoredups

	# timestamp history
	HISTTIMEFORMAT="%Y-%m-%d %T "

	# append to history file, don't overwrite
	shopt -s histappend

	# save multi-line commands as one command
	shopt -s cmdhist
fi
