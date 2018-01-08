#!bash
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# keep less from clearing the screen, display line numbers and ANSI colors
export LESS=-XMR

# use lessopen
export LESSOPEN="|lesspipe.sh %s"

if [ -n "$(type -P pygmentize)" ] ; then
	export LESSCOLORIZER=pygmentize
fi

# set debian env based on git
export DEBFULLNAME=$(git config --global user.name)
export DEBEMAIL=$(git config --global user.email)
