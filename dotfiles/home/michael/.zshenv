#!/usr/bin/env zsh
# -*- coding: UTF-8 -*-
###############################################################################
# .zshenv
# =======
#
# Description:           Wrapper for $ZDOTDIR/.zshenv, sets the zsh directory.
# Author:                Michael De Pasquale <shaggyrogers>
# Creation Date:         2018-03-02
# Modification Date:     2018-03-07
# License:               MIT
#
###############################################################################

# Set zsh directory {{{
if [ -z "$XDG_CONFIG_HOME" ]; then
    ZDOTDIR=$HOME'/.config/zsh'
else
    ZDOTDIR=$XDG_CONFIG_HOME'/zsh'
fi
# }}}

. $ZDOTDIR/.zshenv

# vim: set ts=4 sw=4 tw=79 fdm=marker et :
