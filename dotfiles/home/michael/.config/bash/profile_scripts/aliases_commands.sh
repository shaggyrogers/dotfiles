#!/bin/bash
# -*- coding: UTF-8 -*-
###############################################################################
# aliases_commands.sh
# ===================
#
# Version:               1.0.0
# Author:                Michael De Pasquale
# Creation Date:         2017-12-07
# License:               None
#
# Description
# -----------
# Defines command-related aliases.
#
###############################################################################

# enable thefuck
eval $(thefuck --alias --enable-experimental-instant-mode)
alias FUCK='fuck'
alias cunt='fuck'
alias CUNT='fuck'

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

# neovim
alias v=nvim
alias vi=nvim
alias vim=nvim

# Misc.
alias c='command clear'
alias color-picker='gpick'
alias calc='command wcalc -l --color'
alias disk-usage-viewer='ncdu'
alias e='command echo'
alias g='command grep -P --color=auto'
alias l='command ls -lFh --color=auto --group-directories-first'
alias la='command ls -AlFh --color=auto --group-directories-first'
alias lan='command ls -A1 --color=auto --group-directories-first'
alias p='command printf'
alias sau="sudo apt update; sudo apt upgrade -y; notify-send -i '/home/michael/.local/share/icons/material-design-icons/file/svg/production/ic_file_download_48px.svg' 'apt' 'Upgrades complete.'"
alias r='command ranger'

# Hack to make aliases work for sudo
alias sudo='sudo '

# Replace rm with trash
alias rm='trash '
