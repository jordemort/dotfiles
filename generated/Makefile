GIT_URL = https://raw.githubusercontent.com/git/git/master/contrib/completion/

all: git

git: git-prompt.sh git-completion.bash

git-prompt.sh:
	curl $(GIT_URL)/git-prompt.sh > git-prompt.sh

git-completion.bash:
	curl $(GIT_URL)/git-completion.bash > git-completion.bash

Brewfile:
	brew bundle dump

clean:
	rm -f git-prompt.sh git-completion.bash Brewfile
