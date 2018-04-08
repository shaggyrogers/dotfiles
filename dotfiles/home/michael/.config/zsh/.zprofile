#!/usr/bin/env zsh
# -*- coding: UTF-8 -*-
###############################################################################
# .zprofile
# =========
#
# Description:           zsh wrapper for .profile.
# Author:                Michael De Pasquale <shaggyrogers>
# Creation Date:         2018-03-02
# Modification Date:     2018-03-02
# License:               MIT
#
###############################################################################

# Source .profile in bash emulation mode, if it exists
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
# ZSH_CUSTOM=/path/to/new-custom-folder

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# ISO8601 stronk
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# vim: set ts=4 sw=4 tw=79 fdm=marker et :
