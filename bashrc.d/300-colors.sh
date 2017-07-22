# pour le Mac
export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# colors!
export COLOR_NONE='\033[0m'
export COLOR_BLACK='\033[0;30m'
export COLOR_RED='\033[0;31m'
export COLOR_GREEN='\033[0;32m'
export COLOR_BROWN='\033[0;33m'
export COLOR_BLUE='\033[0;34m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_GRAY='\033[0;37m'
export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_WHITE='\033[1;37m'

# lists all the colors
alias colors="set | grep '^COLOR_' | sort"

# enable color support of ls and also add handy aliases
dircolors=$(type -P dircolors)
if [ ! -z "$dircolors" ] ; then
	eval "$(dircolors -b)"
fi

if ls --version 2>/dev/null | grep -q GNU ; then
	alias ls='ls --color=auto'
fi

if grep --version 2>/dev/null | grep -q GNU ; then
	alias grep='grep --color=auto'
fi

# generate unique colors for user and host
user_hash=$(echo $USER | cksum | cut -c1-4)
host_hash=$(hostname -f | cksum | cut -c1-4)

if [[ $TERM =~ "256color" ]]; then
	user_index=$(($user_hash % ${#COLORS_256[@]}))
	host_index=$(($host_hash % ${#COLORS_256[@]}))
	export USER_COLOR='\033[38;5;'${COLORS_256[${user_index}]}'m'
	export HOST_COLOR='\033[38;5;'${COLORS_256[${host_index}]}'m'
else
	user_index=$(($user_hash % ${#COLORS_16[@]}))
	host_index=$(($host_hash % ${#COLORS_16[@]}))
	export USER_COLOR='\033['${COLORS_16[${user_index}]}'m'
	export HOST_COLOR='\033['${COLORS_16[${host_index}]}'m'
fi
