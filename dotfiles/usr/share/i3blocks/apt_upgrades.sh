#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# apt_upgrades.sh
# ===============
#
# Description:           Prints the number of apt package upgrades.
#                        Returns 1 if there are none.
# Author:                Michael De Pasquale
# Creation Date:         2017-11-06
# Modification Date:     2020-08-28
# License:               MIT
#
###############################################################################

# Simulate apt-get upgrade and get the number of upgrades
_UPDATES=$(apt-get -q --simulate -u upgrade --assume-no | \
            grep -Poe '\d{1,4}(?= to upgrade)')
_CODE=$?

# Hide (in i3blocks) when there are no updates or if unsuccesful
if [ "$_CODE" != '0' ] || [ "$_UPDATES" = '0' ]; then
    exit 1
fi

echo -n "$_UPDATES"
exit 0

# vim: set ts=4 sw=4 tw=79 fdm=manual ff=unix fenc=utf-8 et :
