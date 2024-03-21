#!/bin/sh
###############################################################################
# .xinitrc
# ========
#
# Author:                Michael De Pasquale
# Description:           Changes X settings.
#
###############################################################################

# Execute .xsessionrc
if [ -r ~/.xsessionrc ]; then
    ~/.xsessionrc
fi

exit 0

# vim: set ts=4 sw=4 tw=79 fdm=manual et : 
