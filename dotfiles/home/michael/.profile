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

# Set GOPATH
if [ -z GOPATH ]; then
    export GOPATH="$HOME/.local/go/"
fi

# Set TASKDDATA
if [ -z TASKDATA ]; then
    export TASKDATA="/var/taskd"
fi

# source .bashrc
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi

# Add user binary dirs
if [[ ! {"$PATH" =~ "$HOME/.local/bin"} && -d "$HOME/.local/bin" ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [[ ! {"$PATH" =~ "$HOME/bin"} && -d "$HOME/bin" ]]; then
    PATH="$HOME/bin:$PATH"
fi

# Graphical sessions only:
if xhost >& /dev/null; then

    # Run unified remote server
    if [ ! "$(pgrep 'urserver')" ]; then
        /opt/urserver/urserver-start --no-manager &
    fi

    # Lock screen
    if [ "$(uptime | grep -Po ':\d\d:' | tr -d ':\n' | wc -m)" == 1 ]; then
        . $HOME/.local/bin/lock
    fi

    # # Mount VPS
    # if [ ! "$(ls -A /home/michael/aws_vps)" ]; then
    #     sshfs aws_vps:/ /home/michael/aws_vps/ &
    # fi
fi
