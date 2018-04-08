#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# get-window-criteria.sh
# ======================
#
# Author:                ack006 (see link below)
# Creation Date:         2018-01-27
#
# Description
# -----------
# A short summary of this script and its purpose.
# Taken from
# https://faq.i3wm.org/question/2172/how-do-i-find-the-criteria-for-use-with-
# i3-config-commands-like-for_window-eg-to-force-splashscreens-and-dialogs-to-
# show-in-floating-mode/?answer=2174#post-id-2174
#
# Known problem: when WM_NAME is used as fallback for the 'title="<string>"'
# criterion, quotes in "<string>" are not escaped properly. This is a problem
# with the output of `xprop`, reported upstream: https://bugs.freedesktop.org/
# show_bug.cgi?id=66807
###############################################################################

PROGNAME=`basename "$0"`

# Check for xwininfo and xprop
for cmd in xwininfo xprop; do

    if ! which $cmd > /dev/null 2>&1; then
        echo "$PROGNAME: $cmd: command not found" >&2
        exit 1
    fi
done

match_int='[0-9][0-9]*'
match_string='".*"'
match_qstring='"[^"\\]*(\\.[^"\\]*)*"' # NOTE: Adds 1 backreference

{
    # Run xwininfo, get window id
    window_id=`xwininfo -int | sed -nre "s/^xwininfo: Window id: ($match_int) .*$/\1/p"`
    echo "id=$window_id"

    # Run xprop, transform its output into i3 criteria. Handle fallback to
    # WM_NAME when _NET_WM_NAME isn't set
    xprop -id $window_id |
    sed -nr \
    -e "s/^WM_CLASS\(STRING\) = ($match_qstring), ($match_qstring)$/instance=\1\nclass=\3/p" \
    -e "s/^WM_WINDOW_ROLE\(STRING\) = ($match_qstring)$/window_role=\1/p" \
    -e "/^WM_NAME\(STRING\) = ($match_string)$/{s//title=\1/; h}" \
    -e "/^_NET_WM_NAME\(UTF8_STRING\) = ($match_qstring)$/{s//title=\1/; h}" \
    -e '${g; p}'
 } | sort | tr "\n" " " | sed -r 's/^(.*) $/[\1]\n/'

exit 0
