#!/bin/bash

if [ ! -z "$1" ] ; then
	lexer=$(pygmentize -N "$1" 2>/dev/null)
	if [ ! -z $lexer ] && [ "$lexer" != "text" ] ; then
		exec pygmentize -l "$lexer" -f console256 -O style=solarized256 $1
	fi
fi

exec lesspipe "$1"
