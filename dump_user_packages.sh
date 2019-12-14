#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# dump_user_packages.sh
# =====================
#
# Description:           Dumps user-installed apt packages to a file.
# Author:                jmiserez
#
# Notes
# -----
# Source:
#
#   https://askubuntu.com/questions/2389/generating-list-of-manually-
#         installed-packages-and-querying-individual-packages
#
###############################################################################

OUTFILE='./user_packages.txt'
apt-mark showmanual | sort -u > $OUTFILE
echo "Wrote $(cat $OUTFILE | wc -l) package names to $OUTFILE."

# vim: set ts=4 sw=4 tw=79 fdm=manual et :
