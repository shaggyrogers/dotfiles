#!/usr/bin/env bash
###############################################################################
# common.sh
# =========
#
# Description:           Shared shell functions.
# Author:                Michael De Pasquale
# Creation Date:         2019-10-27
# Modification Date:     2024-04-05
#
###############################################################################


# Terminal text formatting
_text_bold_disable() { printf "\x01\x1b[22m\x02";            }
_text_bold()         { printf "\x01\x1b[1m\x02";             }
_text_colour_256()   { printf "\x01\x1b[38;2;$1;$2;$3m\x02"; }
_text_reset()        { printf "\x01\x1b[39m\x02";            }

_text_vdebug()   { _text_colour_256 129 138 143; }
_text_debug()    { _text_colour_256 167 177 183; }
_text_info()     { _text_colour_256 207 216 220; }
_text_warning()  { _text_colour_256 255 100 26;  }
_text_error()    { _text_colour_256 255 14  40;  }
_text_critical() { _text_colour_256 204 71  234; }
_text_success()  { _text_colour_256 87  187 73;  }
_text_prompt()   { _text_colour_256 38 211 255;  }

# Logging
_log() {
    _TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
    [ -t 1 ] && _IS_TERM='true' || _IS_TERM='false'
    _LEVEL="$1"
    _R="$2"
    _G="$3"
    _B="$4"
    shift 4

    printf '%s[%s %+8s] %s %s%s\n' \
        "$($_IS_TERM && _text_colour_256 $_R $_G $_B && _text_bold)" \
        "$_TIMESTAMP" \
        "$_LEVEL" \
        "$($_IS_TERM && _text_bold_disable)$@" \
        "$($_IS_TERM && _text_reset)" 2>&1

    unset _TIMESTAMP _IS_TERM _LEVEL _R _G _B
}

logvdebug()   { _log 'VDEBUG'   129 138 143 "$@"; }
logdebug()    { _log 'DEBUG'    167 177 183 "$@"; }
loginfo()     { _log 'INFO'     207 216 220 "$@"; }
logwarning()  { _log 'WARNING'  255 100 26  "$@"; }
logerror()    { _log 'ERROR'    255 14  40  "$@"; }
logcritical() { _log 'CRITICAL' 204 71  234 "$@"; }
logsuccess()  { _log 'SUCCESS'  87  187 73  "$@"; }

# confirm_yn([prompt='Confirm?'], [strict=0])
confirm_yn() {
    [ "$#" != "0" ] && _PROMPT="$1" && shift 1 || _PROMPT='Confirm?'
    [ "$#" != "0" ] && _STRICT="$1" && shift 1 || _STRICT='0'
    [ "$_STRICT" != "0" ] && _HINT="[Y/n]" || _HINT="[y/n]"

    sleep 0.2
    [ -t 1 ] \
        && _PROMPT="$(_text_prompt)$_PROMPT" \
        && _HINT="$(_text_bold)$_HINT$(_text_bold_disable; _text_reset)"
    printf "%s %s " "$_PROMPT" "$_HINT"
    sleep 0.1

    _STTY_BAK="$(stty -g)"
    stty raw -echo
    _RESP=$(head -c 1)
    stty "$_STTY_BAK"
    echo $_RESP

    if [ "$_RESP" = "y" ] && ! [ "$_STRICT" = '0' ]; then
        printf "$(_text_prompt)You must enter 'Y' exactly to confirm.$(_text_reset)\n"
        return 1
    fi

    if echo "$_RESP" | grep '^[Yy]' > /dev/null; then
        return 0
    fi

    return 1
}


# vim: set ts=4 sw=4 tw=79 fdm=manual ff=unix fenc=utf-8 et :
