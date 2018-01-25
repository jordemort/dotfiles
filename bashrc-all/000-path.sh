#!bash
# build PATH
new_path="$HOME/.homesick/repos/dotfiles/bin"
maybe_path=(
	"$HOME/bin"
	"$HOME/.local/bin"
	"PYTHON"
	"/usr/local/MacGPG2/bin"
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
	"/Applications/VMware Fusion.app/Contents/Public"
	"/usr/local/munki"
)

for p in "${maybe_path[@]}" ; do
	if [ "$p" = "PYTHON" ] && [ -d "$HOME/Library/Python" ] ; then
		# shellcheck disable=SC2045
		for python in $(ls -r "$HOME/Library/Python") ; do
			if [ -d "$HOME/Library/Python/$python/bin" ] && [ -x "$HOME/Library/Python/$python/bin" ] ; then
				new_path="$new_path:$HOME/Library/Python/$python/bin"
			fi
		done
	elif [ -d "$p" ] ; then
		new_path="$new_path:$p"
	fi
done

export PATH="$new_path"
