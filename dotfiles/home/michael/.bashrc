#!/bin/bash
# -*- coding: UTF-8 -*-
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, do nothing
if [ "$-" ]; then

    # check the window size after each command and update LINES and COLUMNS if necessary
    shopt -s checkwinsize

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color|*-256color) color_prompt=yes;;
    esac

    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi

    # Run prompt setup script
    # COLORTERM='truecolor' is non-standard, but fairly common
    if [ "$TERM" != "linux" ] && [[ "$COLORTERM" =~ "truecolor" ]]; then

        if [ -f "$HOME/.config/bash/bash_prompt.sh" ]; then
            source "$HOME/.config/bash/bash_prompt.sh"
        fi
    fi

    # Color support for directory list and *grep commands
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='command ls --color=auto'
        alias dir='command dir --color=auto'
        alias vdir='command vdir --color=auto'
        alias grep='command grep --color=auto'
        alias fgrep='command fgrep --color=auto'
        alias egrep='command egrep --color=auto'
    fi

    ## Run command alias scripts
    if [ -x "$HOME/.config/bash/aliases/command_aliases.sh" ]; then
        . "$HOME/.config/bash/aliases/command_aliases.sh"
    fi
    # Run notification alias scripts
    if [ -x "$HOME/.config/bash/aliases/notification_aliases.sh" ]; then
        . "$HOME/.config/bash/aliases/notification_aliases.sh"
    fi
    # ♫♪♫
    if [ -x "$HOME/.config/bash/aliases/beep_music_aliases.sh" ]; then
        . "$HOME/.config/bash/aliases/notification_aliases.sh"
    fi
    # Kitty config
    if [[ "$TERM" =~ "xterm-kitty" ]]; then
        source "$HOME/.config/bash/aliases/kitty_aliases.sh"
    fi

    # enable bash completion
    if ! shopt -oq posix; then
      if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
      elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
      fi
    fi

    # Editor
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

    # Required for fuck
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

        if test "$( renice -n $2 -p $pid )"; then
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
