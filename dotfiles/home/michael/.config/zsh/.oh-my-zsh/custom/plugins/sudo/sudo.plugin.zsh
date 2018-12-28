#!/usr/bin/env zsh
# -*- coding: UTF-8 -*-
###############################################################################
# python_shell.plugin.zsh
# =======================
#
# Description:           sudo or sudoedit will be inserted before the command
# Author:                Dongweiming <ciici123@gmail.com>
# Creation Date:         2018-05-24
# Modification Date:     2018-12-26
#
# Notes
# -----
# Source: robbyrussell/oh-my-zsh/blob/master/plugins/sudo/sudo.plugin.zsh
#
###############################################################################

sudo_command_line() {
    [[ -z $BUFFER ]] && zle up-history

    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
        LBUFFER="${LBUFFER#$EDITOR }"
        LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == sudoedit\ * ]]; then
        LBUFFER="${LBUFFER#sudoedit }"
        LBUFFER="$EDITOR $LBUFFER"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}

zle -N sudo-command-line sudo_command_line

# Defined shortcut keys: Ctrl + S
bindkey "" sudo-command-line
