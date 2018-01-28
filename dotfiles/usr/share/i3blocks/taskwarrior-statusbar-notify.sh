#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# taskwarrior-activetime-notify.sh
# ================================
#
# Version:               1.0.0
# Author:                Michael De Pasquale
# Creation Date:         2018-01-09
# License:               None
#
# Description
# -----------
# Prints the time and sends a notification if it is within a range.
#
###############################################################################


Notifications=$1
activeMins=$(taskwarrior-productivity active-time)

# Get icon
if [[ -z $activeMins ]]; then
    echo ''
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

# Notifications
if [[ "$Notifications" == "Y" ]]; then

    if [[ "$activeMins" == "25" ]]; then
        notify2wrapper.py 'Task Information' '25 minutes remaining.' \
		'/home/michael/.local/share/icons/Paper Icons/Paper/512x512/actions/'
        play '/home/michael/.local/share/sounds/Notifications/droplet.mp3'

    elif [[ "$activeMins" == "40" ]]; then
        notify2wrapper.py 'Task Information' '10 minutes remaining.' \
		'/home/michael/.local/share/icons/Paper Icons/Paper/512x512/status/appointment-soon.png'
        play '/home/michael/.local/share/sounds/Notifications/break-forth.mp3'
    elif [[ "$activeMins" == "50" ]]; then
        notify2wrapper.py 'Task Information' '0 minutes remaining. ' \
		'/home/michael/.local/share/icons/Paper Icons/Paper/512x512/status/appointment-missed.png'
        play '/home/michael/.local/share/sounds/Notifications/oringz-w439.mp3'
    elif [[ "$activeMins" == "55" ]]; then
        notify2wrapper.py 'Task Information' '5 minutes over task time.' \
		'/home/michael/.local/share/icons/Paper Icons/Paper/512x512/status/appointment-missed.png'
        play '/home/michael/.local/share/sounds/Notifications/oringz-w447.mp3'
    elif [[ "$activeMins" == "60" ]]; then
        notify2wrapper.py 'Task Information' '10 minutes over task time.' \
		'/home/michael/.local/share/icons/Paper Icons/Paper/512x512/status/appointment-missed.png'
        play '/home/michael/.local/share/sounds/Notifications/engaged.mp3'
    elif [[ "$activeMins" == "65" ]]; then
        notify2wrapper.py 'Task Information' '15 minutes over time.' \
		'/home/michael/.local/share/icons/Paper Icons/Paper/512x512/status/appointment-missed.png'
        play '/home/michael/.local/share/sounds/Notifications/office-1.mp3'
        lock &
    fi
fi

# Format time
if (( $activeMins > 59 )); then
    printf $icon "%+2s" "$(echo $(( $activeMins / 60 ))h $(( $activeMins % 60 )))m"
else
    printf $icon "%+2s" "${activeMins}m"
fi

exit 0
