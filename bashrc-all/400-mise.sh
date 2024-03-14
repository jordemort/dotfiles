#!/usr/bin/env bash
# initialize mise
if [ -n "$(type -P mise)" ]; then
	eval "$(mise activate)"
	alias asdf=mise
fi
