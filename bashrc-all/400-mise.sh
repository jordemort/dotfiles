#!/usr/bin/env bash
# initialize mise
if [ -n "$(type -P mise)" ]; then
	eval "$(mise activate bash)"
	eval "$(mise hook-env -s bash)"
	alias asdf=mise
fi
