
just_ran_git=no
function git_with_author() {
	if git remote -v 2> /dev/null | grep -q -E 'cleversafe|192.168.15' ; then
		GIT_AUTHOR_NAME="Jordan Webb" GIT_AUTHOR_EMAIL="jwebb@cleversafe.com" $(type -P git) "$@"
	else
		$(type -P git) "$@"
	fi
	just_ran_git=yes
}

alias git=git_with_author
