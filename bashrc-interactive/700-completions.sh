#!/usr/bin/env bash

# load bash_completion if it isn't already loaded for us
if [ -z "$BASH_COMPLETION" ] ; then
  if (( BASH_VERSINFO[0] > 3 )) ; then
    # check for one installed by homebrew first
    if [ -e /usr/local/etc/bash_completion ] ; then
      source /usr/local/etc/bash_completion
    elif [ -e /opt/homebrew/etc/profile.d/bash_completion.sh ] ; then
      source /opt/homebrew/etc/profile.d/bash_completion.sh
    fi
  elif [ -e /etc/bash_completion ] ; then
    # otherwise maybe it's here?
    source /etc/bash_completion
  fi
fi

# always load these
# shellcheck disable=SC1090,SC1091
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
# shellcheck source=submodules/asdf/completions/asdf.bash
source "$HOME/.homesick/repos/dotfiles/submodules/asdf/completions/asdf.bash"
# shellcheck source=generated/git-completion.bash
source "$HOME/.homesick/repos/dotfiles/generated/git-completion.bash"

# load these as appropriate
[ "$(type -P aws_completer)" ] && complete -C "$(which aws_completer)" aws
# shellcheck source=submodules/open-bash-completion/open
[ "$UNAME" = "Darwin" ] && source "$HOME/.homesick/repos/dotfiles/submodules/open-bash-completion/open"
# shellcheck source=submodules/vboxmanage-bash-completion/VBoxManage
[ "$(type -P vboxmanage)" ] && source "$HOME/.homesick/repos/dotfiles/submodules/vboxmanage-bash-completion/VBoxManage"
