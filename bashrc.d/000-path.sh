
# build PATH
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

pre_path=(
	"/opt/X11/bin"
	"/opt/local/bin"
	"/opt/local/sbin"
	"$HOME/Library/Python/2.7/bin"
	"$HOME/.homesick/repos/dotfiles/bin"
	"$HOME/bin"
)

post_path=(
	"/usr/local/games"
	"/usr/games"
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
