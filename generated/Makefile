GIT_URL = https://raw.githubusercontent.com/git/git/master/contrib/completion/
SHELL = /usr/bin/env bash

all: brew-command-not-found.sh Brewfile git-prompt.sh git-completion.bash

git: git-prompt.sh git-completion.bash

brew-command-not-found.sh:
	brew command-not-found-init > $@

Brewfile:
	brew bundle dump

git-prompt.sh:
	curl -L $(GIT_URL)/git-prompt.sh > $@

git-completion.bash:
	curl -L $(GIT_URL)/git-completion.bash > $@

clean:
	rm -f brew-command-not-found.sh Brewfile git-prompt.sh git-completion.bash
