#!/usr/bin/env bash
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

if [[ $TERM =~ "256color" ]]; then
  # hand picked list of "readable" colors
  # shellcheck disable=SC2207
  DYNAMIC_COLORS=($(seq 3 6) 10 $(seq 12 14) $(seq 22 45) $(seq 58 81) $(seq 99 112) $(seq 124 153) $(seq 160 187) $(seq 196 219))
  BEFORE_DYNAMIC_COLOR='38;5;'
else
  DYNAMIC_COLORS=("0;33" "0;34" "0;35" "0;36" "1;32" "1;34" "1;35" "1;36")
  BEFORE_DYNAMIC_COLOR=''
fi

# generate unique colors for user and host
function color_for_string()
{
  local checksum index
  checksum=$(cksum <<< "$1" | cut -c2-5 | sed s/^0//)
  index=$((checksum % ${#DYNAMIC_COLORS[@]}))
  echo '\033['${BEFORE_DYNAMIC_COLOR}${DYNAMIC_COLORS[${index}]}'m'
}

COLOR_USER=$(color_for_string "$USER")
COLOR_HOST=$(color_for_string "$(hostname -s)")

# lists all the colors
alias colors="set | grep '^COLOR_' | sort"

# enable color support of ls and also add handy aliases
dircolors=$(type -P dircolors)
if [ ! -z "$dircolors" ] ; then
  eval "$(dircolors -b)"
fi
