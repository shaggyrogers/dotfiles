#!/usr/bin/env zsh
# -*- coding: UTF-8 -*-
###############################################################################
# .zshrc
# ======
#
# Description:           Configuration for interactive zsh shell
# Author:                oh-my-zsh team
#                        Michael De Pasquale <shaggyrogers>
# Creation Date:         2018-03-04
# Modification Date:     2018-03-04
# License:               MIT
#
###############################################################################

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# History options
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=8192
SAVEHIST=8192
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt histignorealldups
setopt histignorespace

# Misc. options
setopt autocd
setopt autopushd
setopt pushdignoredups
setopt pushdminus

# Use modern completion system
autoload -Uz compinit
compinit

# Completion options
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Path to your oh-my-zsh installation.
export ZSH=$ZDOTDIR/.oh-my-zsh

COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
ENABLE_CORRECTION="true"
HIST_STAMPS="yyyy-mm-dd"
export KEYTIMEOUT=1

# Load plugins
# plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  vi-mode
  history-substring-search
  python
  aliases
  lscolors
  micktitle

  bgnotify
  sudo
  python_shell
)

# Theme
ZSH_THEME="mickprompt"
export PIPENV_SHELL_FANCY=1

source $ZSH/oh-my-zsh.sh

# Enable kitty completion - this needs to come after sourcing oh-my-zsh.sh,
# or it won't work.
kitty + complete setup zsh | source /dev/stdin

# Startup message {{{
# Display image logo for kitty, ascii logo for everything else
if [ "$TERM" = "xterm-kitty" ]; then
    source $HOME/.config/kitty/kitty_init.zsh
else
    neofetch
fi

# Display fortune
# Note: After editing a fortune fils, compile with 'sudo strfile <file>'
printf "\033[34m\033[1m" 
fortune oblique | fmt -u -w$(($COLUMNS*8/10))| sed 's/^.*$/        \0/g'
printf "\033[0m\n" 
# }}}

# vim: set ts=4 sw=4 tw=79 fdm=marker et :
