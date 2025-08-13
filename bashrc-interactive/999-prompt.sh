#!/usr/bin/env bash

set_window_title() {
	echo -ne "\033]0;$USER@$HOSTNAME: $PWD\007"
	echo -ne "\033]1337;CurrentDir=$PWD\007"
}

if [ -z "$PROMPT_COMMAND" ]; then
	PROMPT_COMMAND="set_window_title"
else
	PROMPT_COMMAND="set_window_title;${PROMPT_COMMAND#;}"
fi

if [ -n "$(type -P starship)" ]; then
    eval "$(starship init bash)"
else
    export PS1="$COLOR_USER\u$COLOR_NONE@$COLOR_HOST\h$COLOR_NONE:$COLOR_LIGHT_GREEN\w$COLOR_NONE\$ "
fi

source "$HOME/.homesick/repos/dotfiles/submodules/iTerm2-shell-integration/shell_integration/bash"

echo -ne "\033]1337;RemoteHost=$USER@$HOSTNAME\007"
trap 'echo -ne "\033]0;$USER@$HOSTNAME: $PWD (${BASH_COMMAND})\007"' DEBUG

if [ -z "$(type -P pbcopy)" ]; then
    alias pbcopy=it2copy
fi
