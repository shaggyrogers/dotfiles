#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# temps.sh
# ========
#
# Description:           Prints CPU and GPU temperatures for i3blocks.
# Author:                Michael De Pasquale
# Creation Date:         2019-01-20
# Modification Date:     2019-01-20
#
# Notes
# -----
# See https://askubuntu.com/a/34459
#
###############################################################################


CPU_TEMP=$(sensors coretemp-isa-0000 \
    | cat \
    | grep -oP -m 1 -e '[0-9]*\.[0-9](?=°C)' \
    | head -n 1 \
)
GPU_TEMP=$(sensors radeon-pci-0100 \
    | grep --colour=never '^temp1' \
    | sed -e 's/temp1:\s\++\?\(-\?[[:digit:]]\+\(\.[[:digit:]]\+\)\?\).*/\1/' \
    | head -n 1 \
)

#    \ | xargs printf '%+7s'
if [ "$1" == "cpu" ]; then
    FULL_TEXT=$(printf '%s°C\n' "$CPU_TEMP")
    SHORT_TEXT=$(printf '%s°C\n' "$CPU_TEMP")
    COLOUR=''
elif [ "$1" == "gpu" ]; then
    FULL_TEXT=$(printf 'GPU %s°C\n' "$GPU_TEMP")
    SHORT_TEXT=$(printf 'GPU %s°C\n' "$GPU_TEMP")
    COLOUR=''
else
    FULL_TEXT=$(printf '%s°C GPU %s°C\n' "$CPU_TEMP" "$GPU_TEMP")
    SHORT_TEXT=$(printf '%s°C GPU %s°C\n' "$CPU_TEMP" "$GPU_TEMP")
    COLOUR=''
fi

printf "$FULL_TEXT\n$SHORT_TEXT\n$COLOUR"

# vim: set ts=4 sw=4 tw=79 fdm=manual et :
