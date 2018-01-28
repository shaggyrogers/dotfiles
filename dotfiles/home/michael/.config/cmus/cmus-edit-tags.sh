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
# A short summary of this script and its purpose.
#
# Requirements
# ------------
# * Required applications go here.
#
# Usage
# -----
# How to use this script. Can leave this out if there are no arguments.
#
###############################################################################

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
file="$(cmus-remote -C 'echo {}')"

if [ -f "$file" ]
then
        /usr/bin/env kitty -c=\
            "from subprocess import call; call(['mp3info', '-i', '$file'])"
else
         echo "Oop, couldn't find selected track" >&2
     fi
