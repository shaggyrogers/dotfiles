#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# sanitise.sh
# ===========
#
# Author:                Michael De Pasquale
# Creation Date:         2018-01-28
# Modification Date:     2018-06-06
# License:               MIT
#
# Description
# -----------
# Removes sensitive information from firefox preferences.
#
###############################################################################

# Single-key y/n prompt
function confirm {
    read -sn 1 -p "$* [Y/N]? "
    [[ ${REPLY:0:1} == [Yy] ]] && printf '\n'
}

# Sanitise a file
function sanitise {
    local FILEPATH=$1
    local EXPRS=$2

    # Check that file actually exists
    if [ ! -e $FILEPATH ]; then
        echo "Skipping nonexistent file $FILEPATH"
        return 1
    fi

    # Build sed expressions for preview and edit
    SHOWMATCHES=''
    DELETEMATCHES=''

    for p in $(echo "$EXPRS"); do
        SHOWMATCHES+="s/.*$p.*/DELETE:&/g; "
        DELETEMATCHES+="/.*$p.*/d; "
    done

    # Print edit preview
    printf "\n$FILEPATH\nEdit Preview\n%s\n" \
        "==================================================================="
    cat "$FILEPATH" | sed -E "$SHOWMATCHES" | sed 's/DELETE:DELETE://g' \
        | grep --color -E '^DELETE:|$'

    printf "%s\n" \
        "==================================================================="

    # prompt user to delete matches
    if confirm 'Delete matches?'; then
        sed -E "$DELETEMATCHES" -i "$FILEPATH"
        echo 'Done.'
    else
        echo "Skipped '$FILEPATH'"
    fi

    return 0
}
# cd into script dir
cd $(dirname "$(readlink -f "$0")")

# Configuration
USERNAME='michael'
FIREFOXPREFS='dotfiles/home/michael/.config/firefox/qzv15m25.Michael/prefs.js'
FIREFOXPREFS2='dotfiles/home/michael/.config/firefox/qzv15m25.Michael/user.js'
FIREFOXEXPR=$(printf '\.(\w+[-_]?)+([Tt]ime|Date) ' && \
              printf '\.last-time-of-changing ' && \
              printf '\..*([Bb]uild|[Dd]evice)[Ii][Dd] ' && \
              printf '\.most[Rr]ecent[Dd]ate ' && \
              printf '\.[Ss]essions\. ' && \
              printf '\.([Dd]river|[Aa]pp)?[Vv]ersion ' && \
              printf '\.last([Uu]pdate|[Vv]ersion) ' && \
              printf '\.[Uu]ser[Aa]gent[Ii][Dd] ' && \
              printf '\.lastDaily[[:alpha:]] ' && \
              printf '\.last[Ss]uggestions[Pp]rompt[Dd]ate ' && \
              printf '\.mostRecentDateSetAsDefault ' && \
              printf '\.last_update_(seconds|time) ' && \
              printf '\.blocklist\.last_etag ' && \
              printf 'noscript\.[[:alpha:]] ' && \
              printf 'network\.proxy\. ' && \
              printf 'media\.gmp- ' && \
              printf 'print_printer ' && \
              printf '\.database\.lastMaintenance ' && \
              printf '\.cohortSample ' && \
              printf '\.last\.places\.sqlite ' && \
              printf '\.startup\.last_success ' && \
              printf '\.blocklist\.[[:alpha:]]+\.checked ' && \
              printf '\..*([Cc]lient[Ii][Dd]|[Bb]uild[Ii][Dd])' )

sanitise "$FIREFOXPREFS" "$FIREFOXEXPR"
sanitise "$FIREFOXPREFS2" "$FIREFOXEXPR"

exit 0
