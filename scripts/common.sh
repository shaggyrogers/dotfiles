#!/usr/bin/env bash
###############################################################################
# common.sh
# =========
#
# Description:           Shared shell functions.
# Author:                Michael De Pasquale
# Creation Date:         2019-10-27
# Modification Date:     2019-12-16
#
###############################################################################


# Terminal text formatting
_text_bold_disable() { printf "\x01\x1b[22m\x02";            }
_text_bold()         { printf "\x01\x1b[1m\x02";             }
_text_colour_256()   { printf "\x01\x1b[38;2;$1;$2;$3m\x02"; }
_text_reset()        { printf "\x01\x1b[39m\x02";            }

_text_vdebug()   { _text_colour_256 129 138 143; }
_text_debug()    { _text_colour_256 167 177 183; }
_text_info()     { _text_colour_256 207 216 220; }
_text_warning()  { _text_colour_256 255 100 26;  }
_text_error()    { _text_colour_256 255 14  40;  }
_text_critical() { _text_colour_256 204 71  234; }
_text_success()  { _text_colour_256 87  187 73;  }
_text_prompt()   { _text_colour_256 38 211 255;  }

# Logging
_log() {
    _TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
    [ -t 1 ] && _IS_TERM='true' || _IS_TERM='false'
    _LEVEL="$1"
    _R="$2"
    _G="$3"
    _B="$4"
    shift 4

    printf '%s[%s %+8s] %s %s%s\n' \
        "$($_IS_TERM && _text_colour_256 $_R $_G $_B && _text_bold)" \
        "$_TIMESTAMP" \
        "$_LEVEL" \
        "$($_IS_TERM && _text_bold_disable)$@" \
        "$($_IS_TERM && _text_reset)" 2>&1

    unset _TIMESTAMP _IS_TERM _LEVEL _R _G _B
}

logvdebug()   { _log 'VDEBUG'   129 138 143 "$@"; }
logdebug()    { _log 'DEBUG'    167 177 183 "$@"; }
loginfo()     { _log 'INFO'     207 216 220 "$@"; }
logwarning()  { _log 'WARNING'  255 100 26  "$@"; }
logerror()    { _log 'ERROR'    255 14  40  "$@"; }
logcritical() { _log 'CRITICAL' 204 71  234 "$@"; }
logsuccess()  { _log 'SUCCESS'  87  187 73  "$@"; }

# confirm_yn([prompt='Confirm?'], [strict=0])
confirm_yn() {
    [ "$#" != "0" ] && _PROMPT="$1" && shift 1 || _PROMPT='Confirm?'
    [ "$#" != "0" ] && _STRICT="$1" && shift 1 || _STRICT='0'
    [ "$_STRICT" != "0" ] && _HINT="[Y/n]" || _HINT="[y/n]"

    sleep 0.2
    [ -t 1 ] \
        && _PROMPT="$(_text_prompt)$_PROMPT" \
        && _HINT="$(_text_bold)$_HINT$(_text_bold_disable; _text_reset)"
    printf "%s %s " "$_PROMPT" "$_HINT"
    sleep 0.1

    _STTY_BAK="$(stty -g)"
    stty raw -echo
    _RESP=$(head -c 1)
    stty "$_STTY_BAK"
    echo $_RESP

    if [ "$_RESP" = "y" ] && ! [ "$_STRICT" = '0' ]; then
        printf "$(_text_prompt)You must enter 'Y' exactly to confirm.$(_text_reset)\n"
        return 1
    fi

    if echo "$_RESP" | grep '^[Yy]' > /dev/null; then
        return 0
    fi

    return 1
}

# Packages
# apt_install_deps(package1, package2, ... packageN)
apt_install_deps() {
    ! [[ -z ${_TO_INSTALL+is_empty} ]] && logwarning "_TO_INSTALL set?"
    _TO_INSTALL=""
    _TO_INSTALL_COUNT=0

    while [[ "$#" != "0" ]]; do
        P=$1
        shift 1

        if dpkg -l "$P" > /dev/null; then
            continue
        fi

        _TO_INSTALL="$_TO_INSTALL $P";
        let '_TO_INSTALL_COUNT+=1'
    done

    if [[ "$_TO_INSTALL_COUNT" != "0" ]]; then
        loginfo "Installing $_TO_INSTALL_COUNT missing dependencies: $TO_INSTALL" 2>&1
        sudo apt-get install -y $TO_INSTALL
    fi

    unset _TO_INSTALL
    unset _TO_INSTALL_COUNT
    return 0
}

# make_dpkg_control(name, version, architecture, priority, section, summary, desc, depends, homepage)
make_dpkg_control() {
    _PKG_NAME="$1"
    _PKG_VERSION="$2"
    _PKG_ARCH="$3"
    _PKG_PRIORITY="$4"
    _PKG_SECTION="$5"
    _PKG_SUMMARY="$6"
    _PKG_DESCRIPTION="$7"
    _PKG_DEPENDS="$8"
    _PKG_HOMEPAGE="$9"
    mkdir -p "DEBIAN"
    (
        echo "Package: $_PKG_NAME"
        echo "Version: $_PKG_VERSION"
        echo "Architecture: $_PKG_ARCH"
        echo "Priority: $_PKG_PRIORITY"
        echo "Section: $_PKG_SECTION"
        echo "Origin: Local user <$(whoami)>"
        echo "Maintainer: Local user <$(whoami)>"
        [ -n "$_PKG_DEPENDS" ] && echo "Depends: $_PKG_DEPENDS"
        [ -n "$_PKG_HOMEPAGE" ] && echo "Homepage: $_PKG_HOMEPAGE"
        echo "Description: $_PKG_SUMMARY"
        echo "  $_PKG_DESCRIPTION"
    ) > 'DEBIAN/control'
}


# VCS
# git_get_branch_head(path)
git_get_branch_head() (
    cd "$1" || return 255
    git status --branch --porcelain=v2 | grep -oP '(?<=# branch.head )\S+' | tr -d '\n'
    return $?
)

# git_get_latest_version(path)
git_get_latest_version() (
    cd "$1" || return 255
    git tag -li 'v*' | cat | sort -V | tail -n 1 | tr -d '\n'
    return $?
)

# git_checkout_branch(path, braanch)
git_checkout_branch() (
    logdebug "$1 $2"
    cd "$1" \
            && git remote update \
            && git remote set-head origin --auto \
            && git fetch --tags \
            && git checkout HEAD -- . \
            && git clean -f -d \
            && git reset HEAD -- . \
            && git checkout "$2"
    _EXIT_CODE=$?

    if [ "$_EXIT_CODE" != '0' ]; then
        return $_EXIT_CODE
    fi

    if git_get_branch_head "." | grep -oP '\(?detached\(?' > /dev/null; then
        logdebug "Skipping pull due to detached HEAD"
        return 0
    fi

    git pull \
        --ff-only \
        --no-commit  \
        --rebase=true  \
        --no-autostash  \
        --force \
        --strategy=recursive \
        -X theirs
)

# git_clone_repo(url, path)
git_clone_repo() {
    REPO="$1"
    REPO_DIR_PATH="$2"

    # Check if repo exists
    if ! git_get_branch_head "$REPO_DIR_PATH" > /dev/null; then
        loginfo "Cloning repository '$REPO' to '$REPO_DIR_PATH'"
        git clone "$REPO" "$REPO_DIR_PATH"
        _CODE=$?

        if [ "$_CODE" != "0" ]; then
            logerror "Failed with code $_CODE"
            return $_CODE
        fi
    fi

    # Update
    loginfo 'Updating repository...'
    git_checkout_branch "$REPO_DIR_PATH" master

    # Confirm
    _HEAD="$(git_get_branch_head "$REPO_DIR_PATH")"
    loginfo "On branch '$_HEAD'"

    if ! [ "$_HEAD" = 'master' ]; then
        logerror "Failed, branch.head='$_HEAD', expected 'master'"
        return 1
    fi

    return 0
}

# vim: set ts=4 sw=4 tw=79 fdm=manual ff=unix fenc=utf-8 et :
