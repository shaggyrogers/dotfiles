#!/usr/bin/env bash
###############################################################################
# update.sh
# =========
#
# Description:           Update any existing files in the dotfiles directory.
# Author:                Michael De Pasquale
# Creation Date:         2019-06-30
# Modification Date:     2019-07-08
#
###############################################################################

IFS=$'\n'

for REPO_PATH in $(find './dotfiles/'); do
    FS_PATH="$(echo "$REPO_PATH" | sed 's/^\.\?\/\?dotfiles//')"
    ! [ -f "$FS_PATH" ] && continue

    if ! REPO_MD5="$(md5sum -b "$REPO_PATH" | awk '{print $1}' 2>/dev/null)"; then
        echo "Error calculating MD5 for $REPO_MD5"
        continue
    fi
    if ! FS_MD5="$(md5sum -b "$FS_PATH" | awk '{print $1}' 2>/dev/null)"; then
        echo "Error calculating MD5 for $FS_PATH"
        continue
    fi

    [ "$REPO_MD5" == "$FS_MD5" ] && continue

    echo "'$FS_PATH' --> '$REPO_PATH'"
    cp "$FS_PATH" "$REPO_PATH"
done
