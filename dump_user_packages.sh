#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# dump_user_packages.sh
# =====================
#
# Author:                jmiserez
#
# Description
# -----------
# Dumps user-installed apt packages to a file.
#
# Source: https://askubuntu.com/questions/2389/generating-list-of-manually-
#         installed-packages-and-querying-individual-packages
#
# Slightly modified.
#
###############################################################################

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
OUTFILE=$SCRIPT_DIR'/user_packages.txt'

printf "$(comm -23 <(apt-mark showmanual | sort -u) \
            <(gzip -dc /var/log/installer/initial-status.gz | \
            sed -n 's/^Package: //p' | sort -u))" > $OUTFILE
echo "Wrote $(cat $OUTFILE | wc -l) package names to $OUTFILE."

exit 0
