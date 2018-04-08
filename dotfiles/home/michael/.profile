#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# .profile
# ========
#
# Description:           Executed by bash for login shells.
# Author:                Michael De Pasquale <shaggyrogers>
# Creation Date:         2018-03-01
# Modification Date:     2018-03-01
# License:               MIT
#
# Note
# ----
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
#
###############################################################################

function pathmunge () { # {{{
    local newdir="$1"
    local after="${$2:-0}"

    if  [ ! -z "$newdir" ] || [ ! -d "$newdir" ]; then
        echo 'WARN: path "'$newdir'" is invalid or does not exist.'
        exit 1;
    fi

    if [ "${PATH/$value}" != "$PATH" ]; then
        if [ $after == "0" ]; then
            export PATH="$PATH:$1"
        else
            export PATH="$1:$PATH"
        fi
    fi
}
# }}}

# Add directories to PATH {{{
pathmunge="$HOME/.local/bin"
pathmunge="$HOME/bin"
# }}}


# Export environment variables {{{
if [ -z "$EDITOR" ];then export EDITOR=nvim; fi
if [ -z "$FILEBROWSER" ];then export FILEBROWSER=ranger; fi
if [ -z "$GOPATH" ]; then export GOPATH="$HOME/.local/go"; fi
if [ -z "$TASKDATA" ]; then export TASKDATA="/var/taskd"; fi
if [ -z "$XDG_CACHE_HOME" ]; then export XDG_CACHE_HOME="$HOME/.cache"; fi
if [ -z "$XDG_CONFIG_HOME" ]; then export XDG_CONFIG_HOME="$HOME/.config"; fi
if [ -z "$XDG_DATA_HOME" ]; then export XDG_DATA_HOME="$HOME/.local/share"; fi
# }}}

# vim: set ts=4 sw=4 tw=79 fdm=marker et :
