
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

file="$(cmus-remote -C 'echo {}')"

if ! [ -f "$file" ]; then
     echo "Could not find track $file." >&2
     exit 1
fi

kitty -c="from subprocess import call; call(['exfalso', '$file'])"
exit 0
