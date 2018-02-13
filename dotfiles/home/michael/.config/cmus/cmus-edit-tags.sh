#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# cmus_edit_tags.sh
# =================
#
# Version:               1.0.0
# Author:                Michael De Pasquale
# Creation Date:         2018-01-27
# License:               None
#
# Description
# -----------
# Launches mp3info in a kitty instance with the selected track as input.
#
# Requirements
# ------------
# * mp3info
#
###############################################################################

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
file="$(cmus-remote -C 'echo {}')"

if [ -f "$file" ]; then
    /usr/bin/env kitty -c=\
        "from subprocess import call; call(['mp3info', '-i', '$file'])"
else
     echo "Could not find track $file." >&2
fi
