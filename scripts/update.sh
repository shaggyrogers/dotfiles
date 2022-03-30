#!/usr/bin/env bash
###############################################################################
# update.sh
# =========
#
# Description:           Update any existing files in the dotfiles directory.
# Author:                Michael De Pasquale
# Creation Date:         2019-06-30
# Modification Date:     2022-03-30
#
###############################################################################

. ./common.sh

# TODO: Option to update local versions using repo
# FIXME: Checksums are apparently computed even if we don't have read
# permission for a file, this instead fails at the update stage?

# Print a help message.
_echo_help() {
    loginfo "Updates the git repo containing my configuration files."
    loginfo ""
    loginfo "Options"
    loginfo "======="
    loginfo ""
    loginfo "  --clean        Remove missing files."
    loginfo ""
    loginfo "  --yes          Assume 'yes' for all confirmation prompts."
    loginfo "                 Only used if --clean is provided."
    loginfo ""
    loginfo "  --help / -h    Show this message."
}

# Parse options
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

# Change internal field separator to newlines. This is needed to properly
# handle file paths with whitespace in the loop below.
IFS=$'\n'

# Compute md5 for each file in the repo and compare with the local versions,
# if they exist, and update the repo if a local dotfile changed.
for REPO_PATH in $(find '../dotfiles/' -type f); do
    let "TOTAL=TOTAL+1"
    FS_PATH="$(echo "$REPO_PATH" | sed 's/^\.\.\/\dotfiles//')"

    # Check if corresponding local file exists
    if ! [ -f "$FS_PATH" ]; then
        let "MISSING=MISSING+1"
        logwarning "Not found: '$FS_PATH'"

        # Remove from repo if requested
        if [ "$_OPT_CLEAN" == '1' ]; then
            if [ "$_OPT_YES" == '1' ] || confirm_yn "Remove '$REPO_PATH'?"; then
                loginfo "Removing '$REPO_PATH'"
                git rm "$REPO_PATH"
                let "REMOVED=REMOVED+1"
            fi
        fi

        continue
    fi

    # Compute local and repo file checksums, skip file if either fails
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

    # Check if local OR repo file changed by comparing checksums, skip file if
    # no change detected
    if [ "$REPO_MD5" == "$FS_MD5" ]; then
        logvdebug "'$FS_PATH' $FS_MD5 $REPO_MD5 OK"

        continue
    fi

    # Either file changed - replace repo version with local version
    loginfo "'$FS_PATH' --> '$REPO_PATH'"

    if ! cp "$FS_PATH" "$REPO_PATH"; then
        # Copy failed for unknown reason (probably don't have read permission)
        logerror "Update failed for '$FS_PATH'"
        let "ERRORS=ERRORS+1"
    fi

    # Update repo file
    git add "$REPO_PATH"
    let 'UPDATED=UPDATED+1'
done

# Reset IFS in case we forget it was changed earlier...
IFS=

# Print git status and counters
logsuccess "Done, git status:"
git status --short --branch
logsuccess "$UPDATED updated, $MISSING missing, $ERRORS errors of $TOTAL files"

# Print number of deleted files, hint if missing files were not deleted
if [ "$_OPT_CLEAN" == '1' ]; then
    logsuccess "$REMOVED missing files removed."
elif ! [ "$MISSING" == '0' ]; then
    logwarning "$MISSING missing files not removed." \
        "To remove these files, run again using the --clean option."
fi


# vim: set ts=4 sw=4 tw=79 fdm=manual ff=unix fenc=utf-8 et :
