#!/usr/bin/env bash
###############################################################################
# make-neovim.sh
# ==============
#
# Description:           Build a package containing the latest neovim release.
# Author:                Michael De Pasquale
# Creation Date:         2019-07-30
# Modification Date:     2019-12-04
#
# Notes
# -----
# After installation, you may need to manually generate help file tags.
# To do this, run the following command from neovim:
#
#     exec 'helptags '.$VIMRUNTIME.'/doc'
#
###############################################################################

. ./common.sh

TIMESTAMP="$(date -u "+%Y%m%dT%H%M%SZ")"
PACKAGE_BIN_ROOT="pkg"
REPO_ROOT="src"
REPO_PATH="$REPO_ROOT/neovim"
PACKAGE_BUILD_ROOT="package-build"

rm -rf "$PACKAGE_BUILD_ROOT/neovim"
rm -rf "$PACKAGE_BUILD_ROOT/neovim-runtime"
mkdir -p "$REPO_ROOT" "$PACKAGE_BUILD_ROOT" "$PACKAGE_BIN_ROOT"


loginfo 'Checking dependencies'

if ! apt_install_deps \
        autoconf automake cmake g++ gettext libtool libtool-bin ninja-build \
        pkg-config unzip ; then
    exit 1
fi

loginfo 'Retrieving/updating repository'

if ! git_clone_repo 'https://github.com/neovim/neovim.git' "$REPO_PATH"; then
    logerror 'Failed!'
    exit 1
fi

RELEASE="$(git_get_latest_version "$REPO_PATH")"
loginfo "Found release: $RELEASE"

if [ -z "$RELEASE" ] || ! git_checkout_branch "$REPO_PATH" "tags/$RELEASE"; then
    logerror 'Error: could not get latest release.'
    exit 2
fi


# neovim_build(path, release)
neovim_build() (
    _PATH="$1"
    _RELEASE="$2"
    cd "$_PATH"

    loginfo 'Cleaning build directory'
    make distclean

    loginfo 'Building, please wait.'
    make CMAKE_BUILD_TYPE=Release
    CODE="$?"

    if [ "$CODE" != "0" ]; then
        logerror "Error building neovim $_RELEASE: make exited with code $CODE"
        return 3
    fi

    loginfo 'Verifying build success'

    if ! [ -f "./build/bin/nvim" ] || ! ./build/bin/nvim --version ; then
        logerror 'Error: apparent build failure'
        return 4
    fi

    _BUILD_VERSION="$(./build/bin/nvim --version | grep -oP "(?<=^NVIM v)[0-9.]+$" | tr -d '\n')"

    if [ "v$_BUILD_VERSION" != "$_RELEASE" ]; then
        logerror "Error: build version is incorrect (got v$_BUILD_VERSION, expected $_RELEASE)"
        return 4
    fi

    echo "Built: $_BUILD_VERSION"
    return 0
)

# if ! neovim_build "$REPO_PATH" "$RELEASE"; then
#     logerror 'Build failed'
#     exit 10
# fi

loginfo 'Creating packages'

PKG_NVIM_NAME="neovim_$RELEASE-$TIMESTAMP-local"
PKG_RUNTIME_NAME="neovim-runtime_$RELEASE-$TIMESTAMP-local"
PKG_NVIM_PATH="$PACKAGE_BUILD_ROOT/$PKG_NVIM_NAME"
PKG_RUNTIME_PATH="$PACKAGE_BUILD_ROOT/$PKG_RUNTIME_NAME"

mkdir -p "$PKG_NVIM_PATH/usr/local/bin"
mkdir -p "$PKG_RUNTIME_PATH/usr/local/share/nvim"

if ! cp -nv "$REPO_PATH/build/bin/nvim" "$PKG_NVIM_PATH/usr/local/bin/nvim"; then
    logerror "Failed to copy neovim binary!"
    exit 1
fi

if ! cp -nvR "$REPO_PATH/runtime" "$PKG_RUNTIME_PATH/usr/local/share/nvim/runtime"; then
    logerror "Failed to copy neovim runtime!"
    exit 1
fi

INFO="$(
    echo "  Neovim is a fork of Vim focused on modern code and features,"
    echo "  rather than running in legacy environments."
)"
DEPENDS="$(
    echo -n 'neovim-runtime (>= 0.2.2-3), libc6 (>= 2.14),'
    echo -n ' libjemalloc1 (>= 2.1.1), libluajit-5.1-2 (>= 2.0.4+dfsg),'
    echo -n ' libmsgpackc2 (>= 2.1.0), libtermkey1 (>= 0.19),'
    echo -n ' libunibilium4 (>= 2.0), libuv1 (>= 1.8.0), libvterm0 (>= 0~bzr635)'
)"

RELEASE_VERS="$(echo "$RELEASE" | grep -oP '(?<=^v)\d+(\.\d+)*')"
(
    cd $PKG_NVIM_PATH \
    && make_dpkg_control \
    'neovim' \
    "$RELEASE_VERS" \
    "$(dpkg --print-architecture | tr -d '\n')" \
    'extra' \
    'universe/editors' \
    'heavily refactored vim fork' \
    "$INFO" \
    "$DEPENDS" \
    'https://neovim.io/'
)

(
    cd $PKG_RUNTIME_PATH \
    && make_dpkg_control \
    'neovim-runtime' \
    "$RELEASE_VERS" \
    'all' \
    'extra' \
    'universe/editors' \
    'heavily refactored vim fork (runtime files)' \
    'This package contains the architecture independent runtime files used by neovim.' \
    '' \
    'https://neovim.io/'
)

loginfo 'Building packages'

if ! dpkg-deb -b "$PACKAGE_BUILD_ROOT/$PKG_NVIM_NAME" || \
        ! dpkg-deb -b "$PACKAGE_BUILD_ROOT/$PKG_RUNTIME_NAME"; then
    logerror "Unable to build neovim or neovim-runtime!"
    exit 2
fi

loginfo 'Cleaning up'
mv "$PACKAGE_BUILD_ROOT/$PKG_NVIM_NAME.deb" "$PACKAGE_BIN_ROOT/neovim-$RELEASE.deb"
mv "$PACKAGE_BUILD_ROOT/$PKG_RUNTIME_NAME.deb" "$PACKAGE_BIN_ROOT/neovim-runtime-$RELEASE.deb"
rm -rf "$PKG_NVIM_PATH" "$PKG_RUNTIME_PATH"

loginfo "Info for $PACKAGE_BIN_ROOT/neovim-$RELEASE.deb"
dpkg-deb -I "$PACKAGE_BIN_ROOT/neovim-$RELEASE.deb"
loginfo "Info for $PACKAGE_BIN_ROOT/neovim-runtime-$RELEASE.deb"
dpkg-deb -I "$PACKAGE_BIN_ROOT/neovim-runtime-$RELEASE.deb"

logsuccess "Done"
exit 0

# vim: set ts=4 sw=4 tw=79 fdm=manual ff=unix fenc=utf-8 et :
