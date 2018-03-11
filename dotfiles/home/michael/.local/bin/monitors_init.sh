#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# configure_monitors.sh
# =====================
#
# Description:           Configures up to 3 monitors using xrandr.
# Author:                Michael De Pasquale <shaggyrogers>
# Creation Date:         2018-02-28
# Modification Date:     2018-03-01
# License:               MIT
#
###############################################################################

# Add outputs here to enable them and assign them a position.
PRIMARY='DVI-D-2'
RIGHT='DVI-D-1'
LEFT=''

if [ -z "$PRIMARY" ]; then
    echo 'PRIMARY is not set, aborting.'
    exit 1
fi

# Get connected monitors
PRIMARY_CONNECTED=0
LEFT_CONNECTED=0
RIGHT_CONNECTED=0

ALL=$(\
    xrandr -q | \
    awk -F '[   ]+' '/[^\s] connected/ {for(i=1;i<NF;i++){if($i ~ /[0-9]+x[0-9]+/){print $1" "$i; next}}; print $1}')

# Parse connected monitors
echo "$ALL" | while LST= read -r i ; do
    NAME=$(echo $i | cut -d' ' -f 1);
    #RESOLUTION=$(echo "$i" | cut -d' ' -f 2 | grep -Po '[0-9]+x[0-9]+' \
    #        | tr 'x' ' ')
    #RESOLUTIONX=$(echo "$RESOLUTION" | cut -d' ' -f 1)
    #RESOLUTIONY=$(echo "$RESOLUTION" | cut -d' ' -f 2)
    if [ -z $NAME ]; then continue; fi
    echo $NAME

    [ "$NAME" == "$PRIMARY" ] && PRIMARY_CONNECTED=1
    [ "$NAME" == "$RIGHT" ] && RIGHT=1
    [ "$NAME" == "$LEFT" ] && LEFT=1
done

if [ ! $PRIMARY_CONNECTED == 0 ]; then
    echo 'Error: Primary monitor not found!'
    exit 1
fi

[ -n $RIGHT ] && xrandr --output "$RIGHT" --auto --right-of "$PRIMARY"
[ -n $LEFT ] && xrandr --output "$LEFT" --auto --left-of "$PRIMARY"

# vim: set ts=4 sw=4 tw=79 fdm=marker et :
