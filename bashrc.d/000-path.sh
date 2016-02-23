
# build PATH
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

pre_path=(
	"$HOME/.homesick/repos/dotfiles/bin"
	"$HOME/bin"
	"$HOME/Library/Python/2.7/bin"
	"$HOME/Library/Python/3.5/bin"
    "$HOME/.local/bin"
	"/opt/X11/bin"
	"/opt/local/libexec/gnubin"
	"/usr/local/opt/coreutils/libexec/gnubin"
	"/opt/local/bin"
	"/opt/local/sbin"
	"/var/lib/gems/1.8/bin"
)

post_path=(
	"/usr/local/games"
	"/usr/games"
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
