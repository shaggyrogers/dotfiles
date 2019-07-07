#!/bin/sh
###############################################################################
# .xinitrc
# ========
#
# Author:                Michael De Pasquale
# Creation Date:         2017-??-??
# Modification Date:     2018-09-29
# License:               MIT
#
# Description
# -----------
# Changes X settings. Executed by xinit when logging in.                     
###############################################################################

# Execute .xsessionrc
if [ -r ~/.xsessionrc ]; then
    ~/.xsessionrc
fi

#Run i3 (if it isn't already running)
if ! pgrep "i3$"; then
    exec i3
fi

# Return exit code 0 for succeess
exit 0

# vim: set ts=4 sw=4 tw=79 fdm=manual et : 
