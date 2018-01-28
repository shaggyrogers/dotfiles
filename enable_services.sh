#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# enable_services.sh
# ==================
#
# Author:                Michael De Pasquale
# Creation Date:         2018-01-27
# License:               None
#
# Description
# -----------
# Enables the systemd services.
#
###############################################################################

echo 'Enabling user services...'
systemctl --user enable psd.service

echo 'Enabling system services...'
sudo systemctl enable fstrim.timer
