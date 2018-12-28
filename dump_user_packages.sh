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

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
OUTFILE=$SCRIPT_DIR'/user_packages.txt'

printf "$(comm -23 <(apt-mark showmanual | sort -u) \
            <(gzip -dc /var/log/installer/initial-status.gz | \
            sed -n 's/^Package: //p' | sort -u))" > $OUTFILE
echo "Wrote $(cat $OUTFILE | wc -l) package names to $OUTFILE."

# vim: set ts=4 sw=4 tw=79 fdm=manual et :
