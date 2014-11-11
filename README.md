Jordan's dotfiles
=================

Various fun stuff. Includes:

- 256 color support
- Solarized theme maximally applied (use of coreutils is recommended on Mac OS X)
- LESSOPEN: tries pygments first, then falls back to lesspipe
- PROMPT:
	- git branch and status (indicated by color)
	- username and hostname colored base on hash
		- unique predictable color for each username and host
- TITLEBAR:
	- displays working directory or currently executing command
	- proxy icon for Mac OS X Terminal.app
- EDITOR: Autodetection of rmate availability, fallback to nano
- TMUX:
	- "get out of my way" tmux configuration
	- automatic tmux on SSH sessions
	- automatic reconnect to detached tmux sessions
