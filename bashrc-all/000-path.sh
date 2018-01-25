#!bash
# build PATH
PATH=""

maybe_path=(
	"$HOME/bin"
	"$HOME/.local/bin"
	"$HOME/.homesick/repos/dotfiles/bin"
	"/data/orchestrator/current/bin"
	"/data/ccql/current/bin"
	"/data/github/shell/bin"
	"/data/github/current/bin"
	"/var/lib/gems/1.8/bin"
	"/opt/X11/bin"
	"/usr/local/opt/coreutils/libexec/gnubin"
	"/usr/local/sbin"
	"/usr/local/bin"
	"/usr/sbin"
	"/usr/bin"
	"/sbin"
	"/bin"
	"/usr/local/games"
	"/usr/games"
	"/opt/puppetlabs/bin"
	"/opt/dell/srvadmin/bin"
)

for p in "${maybe_path[@]}" ; do
	if [ -d "$p" ] ; then
		PATH="$PATH:$p"
	fi
done

export PATH
