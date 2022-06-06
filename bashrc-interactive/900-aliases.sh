#!/usr/bin/env bash
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

if [ -n "$(type -P lsd)" ] ; then
  # shellcheck disable=SC2262
  alias ls=lsd
else
  # shellcheck disable=SC2010,SC2263
  if ls --version 2>/dev/null | grep -q GNU ; then
    # colorize GNU ls
    alias ls='ls --color=auto'
  fi
fi

# load broot if available
if [ -n "$(type -P broot)" ] ; then
  eval "$(broot --print-shell-function bash)"
fi

# colorize GNU grep
if grep --version 2>/dev/null | grep -q GNU ; then
  alias grep='grep --color=auto'
fi
