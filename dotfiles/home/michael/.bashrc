#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# .bashrc
# =======
#
# Author:                Michael De Pasquale
# Creation Date:         2017-08-10
# License:               None
#
# Description
# -----------
# Configures non-login bash shells.
#
###############################################################################

# interactive shells only.
if [ "$-" ]; then
    # check the window size after each command and update LINES and COLUMNS.
    shopt -s checkwinsize

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # Run prompt setup script. Note: 'truecolor' is nonstandard.
    if [ "$TERM" != "linux" ] && [[ "$COLORTERM" =~ "truecolor" ]]; then
        color_prompt=yes

        if [ -f "$HOME/.config/bash/bash_prompt.sh" ]; then
            source "$HOME/.config/bash/bash_prompt.sh"
        fi
    fi

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

    ## Run all scripts in .config/bash/profile_scripts
    for i in $(find "$HOME/.config/bash/profile_scripts/" -maxdepth 1 -type f); do
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

    # Editor environment variable
    export EDITOR=nvim

    # Delete a word with ctrl + w, and the entire line with ctrl + e
    stty werase '^w'
    stty kill '^e'

    # Disable stop and start signals
    stty start undef
    stty stop undef

    # Correct minor cd spelling mistakes
    shopt -s cdspell

    # History options
    HISTCONTROL=ignoreboth
    HISTSIZE=8000
    HISTFILESIZE=8000
    HISTIGNORE='&:ls:ll:la:pwd:exit:clear:history'
    shopt -s histappend
    set cmdhist

    # Required for thefuck
    PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

    # Define "prenice" = pgrep + renice
    function prenice (){
        if [[ -z "$1" || -z "$2" ]]; then
            echo "prenice: invalid number of arguments."
            echo "Usage: prenice <pattern> <priority>"
            return 1
        fi

        pid=$(pgrep $1)

        if [ -z "$pid" ]; then
            echo "prenice: couldn't find process \""$1"\"."
            echo "Usage: prenice <pattern> <priority>"
            return 2
        fi
    
        if test "$(sudo renice -n $2 -p $pid )"; then
            return 0
        fi

        echo "Usage: prenice <pattern> <priority>"
        return 0
    }

    # Display image logo for kitty, ascii logo for everything else
    if [ "$TERM" == "xterm-kitty" ]; then
        source $HOME/.config/kitty/kitty_init.sh
    else
        neofetch
    fi

    # Display fortune
    $HOME/.config/bash/myFortune.py
fi
