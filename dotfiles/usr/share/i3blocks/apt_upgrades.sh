#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# apt_upgrades.sh
# ===============
#
# Version:               1.0.0
# Author:                Michael De Pasquale
# Creation Date:         2017-11-06
# License:               None
#
# Description
# -----------
# Prints the number of apt package upgrades. Returns 1 if there are none.
#
###############################################################################

# Simulate apt-get upgrade and get the number of upgrades
updates=$(apt-get -q --simulate -u upgrade --assume-no | \
          grep -Poe '[0-9]{1,5} to upgrade' | \
          grep -Poe '[0-9]+')

# Hide when there are no updates
if [ "$updates" == "0" ]; then
    exit 1
fi

echo -n $updates
exit 0
