#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# enable_services.sh
# ==================
#
# Description:           Enables systemd services.
# Author:                Michael De Pasquale
# Creation Date:         2018-01-27
# License:               None
#
###############################################################################

systemctl --user enable psd.service
sudo systemctl enable fstrim.timer

# vim: set ts=4 sw=4 tw=79 fdm=manual et :
