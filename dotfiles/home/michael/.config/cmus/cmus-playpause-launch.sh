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
  ~/.local/bin/kitty --class=cmusmusicplayer --override background_opacity=0.65 \
                                --override background='#202020' \
                                'cmus' &
else
  cmus-remote -u
fi
