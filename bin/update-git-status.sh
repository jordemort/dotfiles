#!/usr/bin/env bash
git_dir=$1
status_dir=$2

if [ -e "$status_dir/working" ] ; then
	exit 0
fi

touch "$status_dir/working"

cd $git_dir

branch=$($(type -P git) rev-parse --abbrev-ref HEAD 2>/dev/null)
status=$($(type -P git) status -s | grep -v '^!!' 2>/dev/null)

if [ -z "$status" ] ; then
	color=$COLOR_GREEN
else
	status=$(echo "$status" | grep -v '^??')
	if [ -z "$status" ] ; then
		color=$COLOR_YELLOW
	else
		color=$COLOR_RED
	fi
fi

echo "\[${color}\]${branch}" >> "$status_dir/working"
mv "$status_dir/working" "$status_dir/current"

