#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# cmus-playpause-launch.sh
# ========================
#
# Author:                Michael De Pasquale
# Creation Date:         2018-01-27
# License:               None
#
# Description
# -----------
# Toggles play/pause or launches cmus if it is not running.
#
###############################################################################

if ! pgrep -x cmus ; then
  kitty --class=cmusmusicplayer --override background_opacity=0.7 \
                                --override background='#202020' \
                                'cmus' &
else
  cmus-remote -u
fi
