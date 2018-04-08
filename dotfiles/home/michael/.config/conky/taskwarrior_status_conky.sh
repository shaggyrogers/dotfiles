#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# taskwarrior_status_conky.sh
# ===========================
#
# Version:               1.0.0
# Author:                Michael De Pasquale
# Creation Date:         2018-01-17
# License:               None
#
# Description
# -----------
# Prints the active task and time since start.
#
###############################################################################

activeMins=$(taskwarrior-productivity active-time | tr -d '\n')

# Icons
if [[ -z $activeMins ]]; then
    printf ''
    exit 0
fi

icon=''

if (( $activeMins < 20 )); then
    icon=''
elif (( $activeMins < 30 )); then
    icon=''
elif (( $activeMins < 40 )); then
    icon=''
elif (( $activeMins < 50 )); then
    icon=''
elif (( $activeMins > 49 )); then
    icon=''
fi

if (( $activeMins > 59 )); then
    out="$icon  $(( $activeMins / 60 )):$(( $activeMins % 60))"
else
    out="$icon  ${activeMins}"
fi

printf "%s %s" " $(taskwarrior-productivity active-name | tr -d '\n')" $out
exit 0
