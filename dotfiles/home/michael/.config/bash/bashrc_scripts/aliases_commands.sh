#!/bin/bash
# -*- coding: UTF-8 -*-
###############################################################################
# aliases_commands.sh
# ===================
#
# Description:           Defines command-related aliases.
# Author:                Michael De Pasquale
# Creation Date:         2017-12-07
# Modification Date:     2018-03-03
# License:               MIT
#
###############################################################################

# cd
alias cd..='command cd ..'
alias ch='command cd ~'
alias ..='command cd ..'
alias ...='command cd ../..'
alias ....='command cd ../../..'
alias .....='command cd ../../../..'
alias ......='command cd ../../../../..'
alias .......='command cd ../../../../../..'
alias ........='command cd ../../../../../../..'

# git
alias ga='command git add'
alias gcl='command git clone'
alias gcm='command git commit'
alias gch='command git checkout'
alias gd='command git diff'
alias gi='command gitinspector -T -l'
alias gpl='command git pull'
alias gps='command git push'
alias gs='command git status -sb --show-stash'

# ls
alias ls='command ls -lFh --color=auto --group-directories-first'
alias la='command ls -AlFh --color=auto --group-directories-first'
alias lan='command ls -A1 --color=auto --group-directories-first'

# neovim

# terminal / shell
alias c='command clear'

# Filesystem
alias mkdir='mkdir -pv'
alias chown='chown -c --preserve-root'
alias chown='chown -c --preserve-root'

# Misc.

# Pattern matchiing
alias e='command echo'
alias gr='command grep -P --color=auto'
alias pr='command printf'

# System administration
alias sau="sudo apt update; sudo apt upgrade -y; notify-send -i \
    '/home/michael/.local/share/icons/material-design-icons/file/svg/\
    production/ic_file_download_48px.svg' 'apt' 'Upgrades complete.'"
alias disk-usage-viewer='ncdu'

# Applications
alias b=$FILEBROWSER
alias t='(cd "$HOME/.local/taskwarriorc2"; . run.sh)'
alias taskwarriorc2='(cd "$HOME/.local/taskwarriorc2"; . run.sh)'
alias color-picker='gpick'
alias calc='command wcalc -l --color --remember'
alias e=$EDITOR
alias vi=nvim
alias vim=nvim

# Hack to make aliases work for sudo
alias sudo='sudo '

# Replace rm with trash
alias rm='trash '
