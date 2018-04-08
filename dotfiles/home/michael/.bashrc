#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# .bashrc
# =======
#
# Description:           Configures interactive, non-login bash shells.
# Author:                Michael De Pasquale shaggyrogers
# Creation Date:         2017-08-10
# Modification Date:     2018-03-03
# License:               MIT
#
###############################################################################

# interactive shells only.
if [ "${-/i}" == "$-" ]; then return; fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Color support for directory list and *grep commands
if [ -x /usr/bin/dircolors ] && [ -n color_prompt ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='command ls --color=auto'
    alias dir='command dir --color=auto'
    alias vdir='command vdir --color=auto'
    alias grep='command grep --color=auto'
    alias fgrep='command fgrep --color=auto'
    alias egrep='command egrep --color=auto'
fi

# Disable stop and start signals, set delete word/line shortcuts
stty werase '^w'
stty kill '^e'
stty start undef
stty stop undef

# History options
HISTCONTROL=ignoreboth
HISTSIZE=8000
HISTFILESIZE=8000
HISTIGNORE='&:ls:ll:la:pwd:exit:clear:history'
set cmdhist

shopt -s checkwinsize
shopt -s cdspell
shopt -s histappend


# Run all scripts in .config/bash/profile_scripts
for i in $(find "$HOME/.config/bash/bashrc_scripts/" -maxdepth 1 -type f); do
. $i
done

# enable bash completion
if ! shopt -oq posix; then
if [ -f /usr/share/bash-completion/bash_completion ]; then
. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi
fi

# Startup message {{{

# Display image logo for kitty, ascii logo for everything else
if [ "$TERM" == "xterm-kitty" ]; then
    source $HOME/.config/kitty/kitty_init.sh
else
    neofetch
fi

# Display fortune
# Note: After editing, safe the fortune files with 'sudo strfile oblique'
printf "\033[34m\033[1m"
fortune oblique | fmt -u -w$(($COLUMNS*8/10))| sed 's/^.*$/        \0/g'
printf "\033[0m"
# }}}

# vim: set ts=4 sw=4 tw=79 fdm=marker et :
