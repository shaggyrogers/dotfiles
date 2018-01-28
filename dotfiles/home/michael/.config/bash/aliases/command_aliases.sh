#!/bin/bash
# -*- coding: UTF-8 -*-
###############################################################################
# command_aliases.sh                                                          
# ==================                                                          
#                                                                             
# Version:               1.0.0                                                
# Author:                Michael De Pasquale                                  
# Creation Date:         2017-12-07                                           
# License:               None                                                 
#                                                                             
# Description                                                                 
# -----------                                                                 
# Defines bash aliases in order to shorten frequently used commands, set      
# frequently used arguments as default or replace one application/command     
# with another.                                                               
#                                                                             
# Usage                                                                       
# -----                                                                       
# Define aliases only if they are worth the time and effort needed to learn   
# them and aren't likely to cause issues or confusion later on.               
#                                                                             
###############################################################################

# cli (CALC)ulator
alias calc='command wcalc -l --color'

# Make it easier to remember that gpick is a (COLOR-PICKER)
alias color-picker=gpick

# cd shortcuts
# * fix cd.. typo
# * (C)d to (H)ome directory
# * cd (..) - each additional (.) is one extra directory up
alias cd..='command cd ..'
alias ch='command cd ~'
alias ..='command cd ..'
alias ...='command cd ../..'
alias ....='command cd ../../..'
alias .....='command cd ../../../..'
alias ......='command cd ../../../../..'
alias .......='command cd ../../../../../..'
alias ........='command cd ../../../../../../..'

# (C)lear screen
alias c='command clear'

# (D)isk usage
alias d='command df -hT --total'

# (E)cho
alias e='command echo'

# (FREE) memory
alias free='command free -m'

# fuck
eval $(thefuck --alias --enable-experimental-instant-mode)
alias FUCK='fuck'
alias cunt='fuck'
alias CUNT='fuck'

# (G)rep
alias g='command grep -P --color=auto'

# (G)it (C)lone
alias gc='command git clone'

# (L)ist, (L)ist (A)ll, (L)ist (A)ll, (N)ames only
alias l='command ls -lFh --color=auto --group-directories-first'
alias la='command ls -AlFh --color=auto --group-directories-first'
alias lan='command ls -A1 --color=auto --group-directories-first'

# (M)an
alias m='command man'

# (MD5)
alias md5='command openssl md5'

# Install in all python versions
function pips-install-user() {
    if [ -z $1 ]; then return 1; fi
    python -m pip install --user $1
    python3 -m pip install --user $1
    python3.6 -m pip install --user $1
}

# (S)udo, (S)udo (A)pt
alias s='command sudo '
alias sa='command sudo apt '

# (SHA1)
alias sha1='command openssl sha1'

# (S)ou(R)c(E)
alias src='command source'

# file (ST)at[us]
alias st='command stat'

# n(Vim) aliases
alias v=nvim
alias vi=nvim
alias vim=nvim

# Hack to make aliases work for sudo
alias sudo='sudo '

# Misc. aliases
alias please='command sudo'
alias weather='command curl wttr.in'
alias '?'='command help'
alias rm='trash '
alias r='command ranger'
