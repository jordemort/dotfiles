#!bash
# make jobs output useful
alias jobs="jobs -l"

# use hub instead of git if we have it
if [ -n "$(type -P hub)" ] ; then
  eval "$(hub alias -s)"
fi

# give nslookup some line editing
if [ -n "$(type -P rlwrap)" ] ; then
  alias nslookup='rlwrap nslookup'
fi

# colorize GNU ls
# shellcheck disable=SC2010
if ls --version 2>/dev/null | grep -q GNU ; then
  alias ls='ls --color=auto'
fi

# colorize GNU grep
if grep --version 2>/dev/null | grep -q GNU ; then
  alias grep='grep --color=auto'
fi
