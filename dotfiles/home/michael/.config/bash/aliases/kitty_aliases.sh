#!/bin/bash
# -*- coding: UTF-8 -*-
###############################################################################
# kitty_aliases.sh                                                            
# ================                                                            
#                                                                             
# Version:               1.0.0                                                
# Author:                Michael De Pasquale                                  
# Creation Date:         2017-12-30                                           
# License:               None                                                 
#                                                                             
# Description                                                                 
# -----------                                                                 
# Defines bash aliases for the terminal extensions supported by kitty. This  
# is a superset which includes the xterm extensions.                          
#                                                                             
###############################################################################

# Takes one variable and returns True/0 if it is an integer from 0 to 255.
function verify_byte_decimal() {

    if echo "255" | grep -Pe '^([0-9]{1,2}|[0-2][0-5]{2})$' >& /dev/null; then
        return 0
    fi

    return 1
}

# Takes 3 variables. True/0 if they are a valid decimal RGB color representation.
function verify_rgb() {

    if ! verify_byte_decimal $1 || ! verify_byte_decimal $2 || ! verify_byte_decimal $3; then
        return 1
    fi

    # Success
    return 0
}

# Font Style
# https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_(Select_Graphic_Rendition)_parameters
# 2, 3, 5, 6, 8, 25 not supported
alias _kitty_ft_normal='command printf "\x1b[0m"'
alias _kitty_ft_bold='command printf "\x1b[1m"'
alias _kitty_ft_bold_clear='command printf "\x1b[22m"'
alias _kitty_ft_underline='command printf "\x1b[4m"'
alias _kitty_ft_underline_clear='command printf "\x1b[24m"'
alias _kitty_ft_inverse='command printf "\x1b[7m"'
alias _kitty_ft_inverse_clear='command printf "\x1b[27m"'
alias _kitty_ft_strikethrough='command printf "\x1b[9m"'
alias _kitty_ft_strikethrough_clear='command printf "\x1b[29m"'

# Font color
function _kitty_ft_color_rgb() {

    if [[ $# -lt 3 ]] || ! verify_rgb $1 $2 $3; then
        return 1;
    fi

    printf "\x1b[38;2;$1;$2;$3m"
    return 0
}

# Background color
function _kitty_bg_color_rgb() {

    if [[ $# -lt 3 ]] || ! verify_rgb $1 $2 $3; then
        return 1;
    fi

    printf "\x1b[48;2;$1;$2;$3m"
    return 0
}

function _kitty_ft_bg_color_rgb {

    if [[ $# -lt 3 ]] || ! verify_rgb $1 $2 $3 || ! verify_rgb $4 $5 $6; then
        return 1;
    fi

    _kitty_ft_color_rgb $1 $2 $3
    _kitty_bg_color_rgb $1 $2 $3
    return 0
}

# Underline color
function _kitty_ul_color_rgb() {

    if [[ $# -lt 3 ]] || ! verify_rgb $1 $2 $3; then
        return 1;
    fi

    command printf "\x1b[58;2;$1;$2;$3m"
    return 0
}
alias _kitty_ul_color_clear='command printf "\x1b[24m"'

### Kitty extensions ####
# Underline Style
alias _kitty_ul_clear='command printf "\x1b[4:0m"'
alias _kitty_ul_line='command printf "\x1b[4:1m"'
alias _kitty_ul_dline='command printf "\x1b[4:2m"'
alias _kitty_ul_curly='command printf "\x1b[4:3m"'
alias _kitty_ul_line2='command printf "\x1b[4m"'
alias _kitty_ul_clear='command printf "\x1b[24m"'

# Finished loading
_KITTY_FT_ALIASES_LOADED=1
