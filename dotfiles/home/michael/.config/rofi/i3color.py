#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
"""
i3color.sh
==========

  Author:                Oliver Kraitschy http://okraits.de
  Creation Date:         2018-02-26
  License:               GPLv2

  Description
  -----------
  Usage: rofi <your-options> $(i3-color-rofi)

  See https://github.com/okraits/rofi-tools
"""

from os import getenv
import sys

# SETTINGS
config_path = getenv("HOME") + "/.i3/config"

# variables
config_file = None
lines = None
normal_bg = None
normal_fg = None
selected_bg = None
selected_fg = None
normal_bg_var = False
normal_fg_var = False
selected_bg_var = False
selected_fg_var = False
cmd_string = ""

def read_config(path):
    """ Reads an i3 config file. Returns None if unsuccessful. """
    home = getenv('HOME')
    dirs = [path,
            home+'/.i3/config',
            getenv('XDG_CONFIG_HOME', home + '/.config') + '/i3/config',
            '/etc/i3/config']

    for cur in dirs:
        try:
            result = open(cur, "r")
        except IOError:
            continue
        else:
            return result

    return None

if __name__ == "__main__":
    config_file = read_config(config_path)

    if config_file is None :
        sys.exit('Could not read config file.')

    # read all lines into a list
    lines = config_file.readlines()
    config_file.close()

    # loop over lines and find matches
    for line in lines:
        cols = line.split()

        # for all lines not empty
        if len(cols) > 0:

            # normal background
            if cols[0] == "client.unfocused":
                normal_bg = cols[2]

                if normal_bg[0] == "$":
                    normal_bg_var = True

                # normal foreground
                normal_fg = cols[3]

                if normal_fg[0] == "$":
                    normal_fg_var = True
            # selected background
            if cols[0] == "client.focused":
                selected_bg = cols[2]

                if selected_bg[0] == "$":
                    selected_bg_var = True

                # selected foreground
                selected_fg = cols[3]

                if selected_fg[0] == "$":
                    selected_fg_var = True

    # at least one variable was used, we need to find the real values
    if normal_bg_var or normal_fg_var or selected_bg_var or selected_fg_var:

        for line in lines:
            cols = line.split()

            # for all lines starting with "set"
            if len(cols) > 0 and cols[0] == "set":

                if normal_bg_var and cols[1] == normal_bg:
                    normal_bg = cols[2]

                if normal_fg_var and cols[1] == normal_fg:
                    normal_fg = cols[2]

                if selected_bg_var and cols[1] == selected_bg:
                    selected_bg = cols[2]

                if selected_fg_var and cols[1] == selected_fg:
                    selected_fg = cols[2]

    if normal_bg is not None:
        cmd_string += "-bg " + normal_bg + " "

    if normal_fg is not None:
        cmd_string += "-fg " + normal_fg + " "

    if selected_bg is not None:
        cmd_string += "-hlbg " + selected_bg + " "

    if selected_fg is not None:
        cmd_string += "-hlfg " + selected_fg + " "

    print(cmd_string)
    exit(0)
