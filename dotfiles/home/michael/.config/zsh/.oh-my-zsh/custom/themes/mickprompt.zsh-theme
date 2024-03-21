#!/usr/bin/env zsh
# -*- coding: UTF-8 -*-
###############################################################################
# mickprompt.plugin.zsh
# =====================
#
# Description:           Configures custom zsh prompt
# Author:                Michael De Pasquale
# Creation Date:         2018-01-25
# Modification Date:     2019-04-06
# License:               MIT
#
# Notes
# -----
# * Requires a terminal with truecolor support.
# * Requires nerd fonts
#
###############################################################################

# Ensure truecolor support, not virtual console
if [[ "$TERM" == 'linux' ]] || [[ "$(tput colors)" != "256" ]]; then 
    echo "mickprompt: terminal $TERM not supported" >&2
    return
fi

# Style {{{
SEPARATOR=''  # Other possibilities:      
LAST_BG_FG=''

function ft_color { # {{{
    echo -n "%{[38;2;$1;$2;$3m%}"
} # }}}
function bg_color { # {{{
    LAST_BG_FG="%{[38;2;$1;$2;$3m%}"
    echo -n "%{[48;2;$1;$2;$3m%}"
} # }}}
function ft_style_clear { # {{{
    echo -n "%{[0m%}"
} # }}}
function ft_style_b { # {{{
    echo -n "%{[1m%}"
} # }}}
# _nextseg(fg_color(r, g, b), [bg_color(r, g, b)], [bold]) : 
# Add the next segment. Adds a separator, if the segment is not the first.
function _nextseg { # {{{
    ft_style_clear
    local FG="$LAST_BG_FG"

    # Add separator
    if ! [ "$FG" = '' ]; then
        [ -n "$6" ] && bg_color $4 $5 $6
        echo -n "$FG$SEPARATOR"
        ft_style_clear
    fi

    # Apply style for next segment
    [ "$7" = '1' ] && ft_style_b
    [ -n "$3" ] && ft_color $1 $2 $3
    [ -n "$6" ] && bg_color $4 $5 $6
} # }}}
# }}}

# Sections {{{
function _seg_return_code() { # {{{
    local retcode="$1"

    if [[ "$retcode" != "0" ]]; then 
        _nextseg 48 60 66 255 87 34 1
        printf " $retcode "
    else
        _nextseg 48 60 66 208 243 140 1
        printf "  "
    fi
} # }}}
function _seg_username() { # {{{
    _nextseg 207 216 220 88 88 88
    printf " $USER "
} # }}}
function _seg_hostname() { # {{{
    _nextseg 163 173 179 68 68 68
    printf " $(hostname) "
} # }}}
function _seg_pipenv() { # {{{
    if [ -z "$VIRTUAL_ENV" ] || ! basename $VIRTUAL_ENV &> /dev/null; then 
        return
    fi

    VENV=$(basename $VIRTUAL_ENV)
    _nextseg 0 54 45 0 191 165
    printf "  $VENV "

} # }}}
function _seg_cwd() { # {{{
    _nextseg 253 246 227 0 135 175

    if printf "$(pwd)" | grep "^/home/$USER" > /dev/null; then
        printf '  '
    else
        printf '  '
    fi

    local CURPATH=$(pwd | sed -r "s/\/home\/$USER\/?/ /; s/^\s*//g")
    [[ "${CURPATH:0:1}" == "/" ]] && local CURPATH="${CURPATH:1}"

    if [[ "$CURPATH" != '' ]]; then
        _nextseg 207 216 220 88 88 88
        printf " $(printf "$CURPATH" | sed 's/\//  /g') "
    fi
} # }}}
function _seg_jobs() { # {{{
    JOBS_RUNNING="$(jobs -rp | wc -l)" 
    JOBS_STOPPED="$(jobs -sp | wc -l)" 

    if [ "$JOBS_RUNNING" = '0' ] && [ "$JOBS_STOPPED" = '0' ]; then
        return
    fi

    _nextseg 55 58 58 174 141 196
    ! [ "$JOBS_RUNNING" = '0' ] && printf "  %s" "$JOBS_RUNNING"
    ! [ "$JOBS_STOPPED" = '0' ] && printf " %s" "$JOBS_RUNNING"
} # }}}
function _seg_git() {  # {{{
    # NOTE: Taken from agnoster theme (prompt_git)
    (( $+commands[git] )) || return


    local PL_BRANCH_CHAR
    () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=' '         #  
    }

    local ref dirty mode repo_path
    repo_path=$(git rev-parse --git-dir 2>/dev/null)

    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        dirty=$(parse_git_dirty)
        ref=$(git symbolic-ref HEAD 2> /dev/null) || \
            ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"

        if [[ -n $dirty ]]; then
            _nextseg 54 64 70 255 215 20
        else
            _nextseg 46 17 5 240 140 30
        fi

        if [[ -e "${repo_path}/BISECT_LOG" ]]; then
            mode=" "
        elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
            mode=" "
        elif [[ -e "${repo_path}/rebase" || \
            -e "${repo_path}/rebase-apply" || \
            -e "${repo_path}/rebase-merge" || \
            -e "${repo_path}/../.dotest" ]]; then
            mode=" "
        fi


        setopt promptsubst
        autoload -Uz vcs_info

        zstyle ':vcs_info:*' enable git
        zstyle ':vcs_info:*' get-revision true
        zstyle ':vcs_info:*' check-for-changes true
        zstyle ':vcs_info:*' stagedstr "$(ft_color 26 255 10)"
        zstyle ':vcs_info:*' unstagedstr "$(ft_color 0 255 255)"
        zstyle ':vcs_info:*' formats ' %u%c'
        zstyle ':vcs_info:*' actionformats ' %u%c'

        vcs_info
        echo -n "${ref/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode}"
    fi

    #       
    #                    
} # }}}
function _seg_ranger() { # {{{
    if [ $RANGER_LEVEL ]; then
        _nextseg 250 166 181 127 87 134
        printf "  " 
        #c
    fi
} # }}}
#}}}

# Prompt {{{
function _prompt() { #{{{
    # Add segments
    _seg_return_code $?
    _seg_jobs
    _seg_ranger
    _seg_username
    _seg_hostname
    _seg_cwd
    _seg_git
    _seg_pipenv

    # Add newline and symbol for command entry
    ft_style_clear
    _nextseg 207 216 220
    printf '\n'

    # Clear font style
    ft_style_clear
} # }}}

# Run prompt if argument is 1
#[ "$1" = '1' ] && _prompt

PROMPT='%{%f%b%k%}$(_prompt) '
# }}}

#  vim: set ts=4 sw=4 tw=79 fdm=marker et : 
