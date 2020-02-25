# -*- coding: UTF-8 -*-
###############################################################################
# aliases.plugin.zsh
# ===================
#
# Description:           Defines custom aliases for shell commands.
# Author:                Michael De Pasquale
# Creation Date:         2018-03-04
# Modification Date:     2018-12-26
# License:               MIT
#
###############################################################################

# Applications{{{
alias b=ranger
alias calc='wcalc -l --color --remember'
alias e=$EDITOR

# Disable nested ranger instances - exit shell instead
function ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        command ranger "$@"
    else
        exit
    fi
}
# }}}

# cd{{{
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'
# }}}

# Shell{{{
# A space at the start prevents commands being saved in history
alias c=' clear'
alias clear=' clear'
alias exit=' exit'
alias history=' history'
alias pwd=' pwd'

alias chown='chown -c --preserve-root'
alias mkdir='mkdir -pv'

# rm moves files to trash instead
alias rm='trash-put '
 
# Allows aliases to work for sudo
alias sudo='sudo '
# }}}

# Misc.{{{
alias sau="sudo apt update; sudo apt upgrade -y; notify-send -i \
    '/home/michael/.local/share/icons/material-design-icons/file/svg/\
    production/ic_file_download_48px.svg' 'apt' 'Upgrades complete.'"
alias todos="ag '(^[A-Za-z0-9_]|^)(TODO(S)?|FIXME|FINISH)([^A-Za-z0-9_]|$)'"
# }}}

#  vim: set ts=4 sw=4 tw=79 fdm=marker et : 
