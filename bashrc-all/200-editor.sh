#!/usr/bin/env bash
# no vi please
EDITOR="nano"

# Detect VS Code remote and inject it into path
if [ "$(uname -s)" = "Linux" ] ; then
  ppid=$(ps -ho ppid "$$")
  parent_exe=$(readlink -f "/proc/${ppid//[[:space:]]/}/exe")

  if [[ $parent_exe = $HOME/.vscode-server/bin/* ]] ; then
    vscode_bin="$(dirname "$parent_exe")/bin"
    if [ -x "$vscode_bin/code" ] ; then
      export PATH="$vscode_bin:$PATH"
    fi
  fi
fi

# Look for VS Code
code=$(type -P code)

if [ -x "$code" ] ; then
  # If we have it, alias everything over there
  EDITOR="code -n -w"
  alias nano=code
  alias subl=code
else
  # Otherwise, we want nano
  alias code=nano
  alias subl=nano
fi

VISUAL=$EDITOR

export EDITOR VISUAL
