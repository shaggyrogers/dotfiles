#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Set GOPATH if not set
if [ -z GOPATH ]; then
    export GOPATH="$HOME/.local/go/"
fi

# Set TASKDDATA if not set
if [ -z TASKDATA ]; then
    export TASKDATA="/var/taskd"
fi

# if running bash, run $HOME/.bashrc
echo -n 'Checking terminal emulator...'
if [ -n "$BASH_VERSION" ]; then
    echo 'found bash.'
    if [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc"
    fi
else
    echo 'Warning: could not find bash.'
fi

# Check if user bin dirs aren't in path and exist, and if so add them to PATH.
# They are prepended, so they will be checked first.
if [[ ! {"$PATH" =~ "$HOME/.local/bin"} && -d "$HOME/.local/bin" ]]; then
    PATH="$HOME/.local/bin:$PATH"
    echo "Added $HOME/.local/bin to PATH."
fi
if [[ ! {"$PATH" =~ "$HOME/bin"} && -d "$HOME/bin" ]]; then
    PATH="$HOME/bin:$PATH"
    echo "Added $HOME/bin to PATH."
fi

# Single-key y/n prompt
function confirm {
    read -sn 1 -p "$* [Y/N]? "
    [[ ${REPLY:0:1} == [Yy] ]] && printf '\n'
}

# Graphical session only
if xhost >& /dev/null; then

    # Check if unified remote is running, if not start it Start unified remote in background
    echo -n 'Checking if Unified Remote server has been started...'
    if [ ! "$(pgrep 'urserver')" ]; then
        echo 'Not started, starting in background.'
        /opt/urserver/urserver-start --no-manager &
    else
        echo 'Already started.'
    fi

    # Launch startup applications
    if [ "$(uptime | grep -Po ':\d\d:' | tr -d ':\n' | wc -m)" == 1 ]; then

    TMP_CUR_DIR=$(pwd)
    cd "$HOME/.local/taskwarriorc2/"
    . run.sh &
    cd $TMP_CUR_DIR
    TMP_CUR_DIR=

    . $HOME/.local/bin/lock

    fi

    # # Check if VPS is mounted, and mount in the background if it isn't
    # echo -n 'Checking if VPS has been mounted...'
    # if [ ! "$(ls -A /home/michael/aws_vps)" ]; then
    #     echo 'Not mounted, starting in background.'
    #     sshfs aws_vps:/ /home/michael/aws_vps/ &
    # else
    #     echo 'Already mounted.'
    # fi
fi
