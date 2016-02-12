Jordan's dotfiles
=================

I know fish or zsh are supposed to be better but I work on a lot of weird machines
and bash is on pretty much all of them, so I stick with bash.

Various fun stuff. Includes:

- 256 color support
- git prompt
- username and hostname in prompt colored base on hash
    - unique predictable color for each username and host with no need for configuration
- titlebar:
    - displays working directory or currently executing command
    - proxy icon for Mac OS X Terminal.app
- autodetection of rmate availability, fallback to nano
- tmux (not currently using this but find it in the attic):
    - "get out of my way" tmux configuration
    - automatic tmux on SSH sessions
    - automatic reconnect to detached tmux sessions

Intended for use with [homeshick](https://github.com/andsens/homeshick)
