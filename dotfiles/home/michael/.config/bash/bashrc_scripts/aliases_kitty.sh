#!/bin/bash
# -*- coding: UTF-8 -*-
###############################################################################
# kitty_aliases.sh
# ================
#
# Description:           Defines aliases for xterm/kitty terminal extensions
# Author:                Michael De Pasquale
# Creation Date:         2017-12-30
# Modification Date:     2018-03-03
# License:               MIT
#
###############################################################################

# Abort if we don't have truecolor support or terminal is not kitty
if [ "$TERM" != 'xterm-kitty' ] || [ "$(tput colors)" != "256" ]; then
    return
fi

# xterm extensions {{{
# Text styles {{{
alias _ft_normal='command printf "\x1b[0m"'
alias _ft_bold='command printf "\x1b[1m"'
alias _ft_bold_clear='command printf "\x1b[22m"'
alias _ft_underline='command printf "\x1b[4m"'
alias _ft_underline_clear='command printf "\x1b[24m"'
alias _ft_inverse='command printf "\x1b[7m"'
alias _ft_inverse_clear='command printf "\x1b[27m"'
alias _ft_strikethrough='command printf "\x1b[9m"'
alias _ft_strikethrough_clear='command printf "\x1b[29m"'
# }}}

# Text colors {{{
function _ft_color_rgb() {
    if [[ $# -lt 3 ]] || ! verify_rgb $1 $2 $3; then return 1; fi
    printf "\x1b[38;2;$1;$2;$3m"
    return 0
}

function _bg_color_rgb() {
    if [[ $# -lt 3 ]] || ! verify_rgb $1 $2 $3; then return 1; fi
    printf "\x1b[48;2;$1;$2;$3m"
    return 0
}
# }}}

# Kitty extensions {{{
# Underline Style {{{
alias _kitty_ul_clear='command printf "\x1b[4:0m"'
alias _kitty_ul_line='command printf "\x1b[4:1m"'
alias _kitty_ul_dline='command printf "\x1b[4:2m"'
alias _kitty_ul_curly='command printf "\x1b[4:3m"'
alias _kitty_ul_line2='command printf "\x1b[4m"'
alias _kitty_ul_clear='command printf "\x1b[24m"'
# }}}

# Underline color {{{
function _kitty_ul_color_rgb() {
    if [[ $# -lt 3 ]] || ! verify_rgb $1 $2 $3; then return 1; fi
    command printf "\x1b[58;2;$1;$2;$3m"
    return 0
}

alias _kitty_ul_color_clear='command printf "\x1b[24m"'
# }}}
# }}}

# vim: set ts=4 sw=4 tw=79 fdm=marker et :
