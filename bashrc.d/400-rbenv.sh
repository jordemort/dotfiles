rbenv=$(type -P rbenv)

if [ -x "$rbenv" ] ; then
  eval "$(rbenv init -)"
fi
