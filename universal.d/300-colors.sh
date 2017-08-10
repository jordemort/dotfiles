#!bash
# pour le Mac
export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# colors!
COLOR_NONE='\033[0m'
COLOR_BLACK='\033[0;30m'
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_BROWN='\033[0;33m'
COLOR_BLUE='\033[0;34m'
COLOR_PURPLE='\033[0;35m'
COLOR_CYAN='\033[0;36m'
COLOR_LIGHT_GRAY='\033[0;37m'
COLOR_GRAY='\033[1;30m'
COLOR_LIGHT_RED='\033[1;31m'
COLOR_LIGHT_GREEN='\033[1;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_LIGHT_BLUE='\033[1;34m'
COLOR_LIGHT_PURPLE='\033[1;35m'
COLOR_LIGHT_CYAN='\033[1;36m'
COLOR_WHITE='\033[1;37m'

# lists all the colors
alias colors="set | grep '^COLOR_' | sort"

# enable color support of ls and also add handy aliases
dircolors=$(type -P dircolors)
if [ ! -z "$dircolors" ] ; then
	eval "$(dircolors -b)"
fi
