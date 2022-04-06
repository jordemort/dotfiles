GIT_URL = https://raw.githubusercontent.com/git/git/master/contrib/completion/
SHELL = /usr/bin/env bash

all: brew-command-not-found.sh Brewfile git-prompt.sh git-completion.bash iterm2_shell_integration.bash

git: git-prompt.sh git-completion.bash

brew-command-not-found.sh:
	brew command-not-found-init > $@

Brewfile:
	brew bundle dump

git-prompt.sh:
	curl -L $(GIT_URL)/git-prompt.sh > $@

git-completion.bash:
	curl -L $(GIT_URL)/git-completion.bash > $@

it2check:
	curl -L https://iterm2.com/utilities/it2check > $@
	chmod 755 $@

iterm2_shell_integration.bash:
	curl -L https://iterm2.com/shell_integration/bash > $@

clean:
	rm -f brew-command-not-found.sh Brewfile git-prompt.sh git-completion.bash iterm2_shell_integration.bash
