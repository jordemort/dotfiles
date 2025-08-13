#!/usr/bin/env bash

update_terminal_cwd() {
    # Identify the directory using a "file:" scheme URL, including
    # the host name to disambiguate local vs. remote paths.

    # Percent-encode the pathname.
    local url_path=''
    {
        # Use LC_CTYPE=C to process text byte-by-byte and
        # LC_COLLATE=C to compare byte-for-byte. Ensure that
        # LC_ALL and LANG are not set so they don't interfere.
        local i ch hexch LC_CTYPE=C LC_COLLATE=C LC_ALL= LANG=
        for ((i = 0; i < ${#PWD}; ++i)); do
            ch="${PWD:i:1}"
            if [[ "$ch" =~ [/._~A-Za-z0-9-] ]]; then
                url_path+="$ch"
            else
                printf -v hexch "%02X" "'$ch"
                # printf treats values greater than 127 as
                # negative and pads with "FF", so truncate.
                url_path+="%${hexch: -2:2}"
            fi
        done
    }

	echo -ne "\033]0;$USER@$HOSTNAME: $PWD\007"
	echo -ne "\033]1337;CurrentDir=$PWD\007"
    printf '\e]7;%s\a' "file://$HOSTNAME$url_path"
}

#set_window_title() {
#}

if [ -z "$PROMPT_COMMAND" ]; then
	PROMPT_COMMAND="update_terminal_cwd"
else
	PROMPT_COMMAND="update_terminal_cwd;${PROMPT_COMMAND#;}"
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
