# Parasitizing bash-it for fun and profilt
BASH_IT=$HOME/.homesick/repos/dotfiles/bash-it

. $BASH_IT/lib/composure.bash
cite _about _param _example _group _author _version

. $BASH_IT/plugins/available/hub.plugin.bash
for c in awscli gem hub pip pip3 vagrant ; do
  . $BASH_IT/completion/available/$c.completion.bash
done
. $BASH_IT/plugins/available/alias-completion.plugin.bash
