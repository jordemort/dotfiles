GIT_URL = https://raw.githubusercontent.com/git/git/master/contrib/completion/

all: git-prompt.sh git-completion.bash

git-prompt.sh:
	curl $(GIT_URL)/git-prompt.sh > git-prompt.sh

git-completion.bash:
	curl $(GIT_URL)/git-completion.bash > git-completion.bash

brew-packages:
	find /usr/local/Cellar -depth 2 | sort | cut -d'/' -f5,6 > brew-packages
