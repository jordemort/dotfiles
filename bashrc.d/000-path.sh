# build PATH
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

pre_path=(
	"/usr/local/opt/coreutils/libexec/gnubin"
	"/opt/X11/bin"
	"/var/lib/gems/1.8/bin"
	"/data/github/current/bin"
	"/data/github/shell/bin"
	"/data/ccql/current/bin"
	"/data/orchestrator/current/bin"
	"$HOME/Library/Python/*/bin"
	"$HOME/.local/bin"
	"$HOME/.homesick/repos/dotfiles/bin"
	"$HOME/bin"
)

post_path=(
	"/usr/local/games"
	"/usr/games"
	"/opt/puppetlabs/bin"
	"/opt/dell/srvadmin/bin"
)

for p in "${pre_path[@]}" ; do
	if [ -d "$p" ] ; then
		PATH="$p:$PATH"
	fi
done

for p in "${post_path[@]}" ; do
	if [ -d "$p" ] ; then
		PATH="$PATH:$p"
	fi
done

export PATH
