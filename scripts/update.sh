#!/usr/bin/env bash
###############################################################################
# update.sh
# =========
#
# Description:           Update any existing files in the dotfiles directory.
# Author:                Michael De Pasquale
# Creation Date:         2019-06-30
# Modification Date:     2019-12-26
#
###############################################################################

. ./common.sh


_echo_help() {
    loginfo "Options"
    loginfo ""
    loginfo "  --clean      Remove missing files."
    loginfo ""
    loginfo "  --yes        Assume 'yes' for all confirmation prompts."
    loginfo ""
    loginfo "  --help / -h  Show this message."
}

_OPT_CLEAN=0
_OPT_YES=0

while ! [ "$#" == '0' ]; do
    case "$1" in
        --clean)
            _OPT_CLEAN=1
            ;;
        --yes)
            _OPT_YES=1
            ;;
        --help|-h)
            _echo_help
            exit 0
            ;;
        *)
            logerror "Unrecognised option '$1'"
            _echo_help
            exit 255
            ;;
    esac

    shift 1
done

loginfo 'Updating...'
UPDATED=0; TOTAL=0; MISSING=0; ERRORS=0; REMOVED=0
IFS=$'\n'

for REPO_PATH in $(find '../dotfiles/' -type f); do
    let "TOTAL=TOTAL+1"
    FS_PATH="$(echo "$REPO_PATH" | sed 's/^\.\.\/\dotfiles//')"

    if ! [ -f "$FS_PATH" ]; then
        let "MISSING=MISSING+1"
        logwarning "Not found: '$FS_PATH'"

        if [ "$_OPT_CLEAN" == '1' ]; then
            if [ "$_OPT_YES" == '1' ] || confirm_yn "Remove '$REPO_PATH'?"; then
                loginfo "Removing '$REPO_PATH'"
                git rm "$REPO_PATH"
                let "REMOVED=REMOVED+1"
            fi
        fi

        continue
    fi

    if ! REPO_MD5="$(md5sum -b "$REPO_PATH" | awk '{print $1}' 2>/dev/null)"; then
        let "ERRORS=ERRORS+1"
        logerror "Unable to compute MD5 for '$REPO_MD5'"
        continue
    fi

    if ! FS_MD5="$(md5sum -b "$FS_PATH" | awk '{print $1}' 2>/dev/null)"; then
        let "ERRORS=ERRORS+1"
        logerror "Unable to compute MD5 for '$FS_PATH'"
        continue
    fi

    if [ "$REPO_MD5" == "$FS_MD5" ]; then
        logvdebug "'$FS_PATH' $FS_MD5 $REPO_MD5 OK"
        continue
    fi

    loginfo "'$FS_PATH' --> '$REPO_PATH'"

    if ! cp "$FS_PATH" "$REPO_PATH"; then
        logerror "Update failed for '$FS_PATH'"
        let "ERRORS=ERRORS+1"
    fi

    git add "$REPO_PATH"
    let 'UPDATED=UPDATED+1'
done

IFS=
logsuccess "Done: $UPDATED updated, $MISSING missing, $ERRORS errors of $TOTAL files"

if [ "$_OPT_CLEAN" == '1' ]; then
    logsuccess "$REMOVED missing files removed."
fi

git status --short --branch

# vim: set ts=4 sw=4 tw=79 fdm=manual ff=unix fenc=utf-8 et :
