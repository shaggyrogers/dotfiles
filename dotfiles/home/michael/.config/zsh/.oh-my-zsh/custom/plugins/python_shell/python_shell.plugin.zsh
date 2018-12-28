#!/usr/bin/env zsh
# -*- coding: UTF-8 -*-
###############################################################################
# python_shell.plugin.zsh
# =======================
#
# Description:           Customised IPython shell
# Author:                Michael De Pasquale <shaggyrogers>
# Creation Date:         2018-05-24
# Modification Date:     2018-12-26
# License:               MIT
#
###############################################################################
 
python3shell() {

    ipython3 \
        --autocall=1 \
        --autoindent \
        --automagic \
        --pprint \
        --color-info \
        --no-banner \
        --no-confirm-exit \
        --nosep \
        --colors=linux \
        -ic "$(cat <<-EOF
import base64
import datetime
import getpass
from IPython.terminal.prompts import Prompts, Token
import json
import math
import matplotlib
import numpy
import os
from pygments.style import Style
import re
import requests
import sh
import socket
import string
import struct
import sys

class MickPrompt(Prompts):
    def in_prompt_tokens(self, cli=None):
        dirsym = ''
        cwd = os.getcwd()
        match = re.match('^/home/([^/]+)/?.*', os.getcwd())

        if match and match.group(1) == getpass.getuser():
            dirsym = ''
            cwd = re.sub('^/home/([^/]+)/?', '', cwd)

        res =  [(Token.Literal.String, ' '),
                (Token.Literal.String, '  '), 
                (Token.Digraph, getpass.getuser()),
                (Token.Digraph, '  '), 
                (Token.Comment, socket.gethostname()),
                (Token.Comment, '  '), 
                (Token.Keyword.Constant, dirsym),
                (Token.Keyword.Constant, '  ')] 
            
        for dir in cwd.split('/'):
            if len(dir) == 0:
                break

            res.append((Token.Digraph, dir))
            res.append((Token.Digraph, '  '))

        res.append((Token.Prompt, '\n'))
        return res

ip = get_ipython()
ip.prompts = MickPrompt(ip)
EOF
        )"; \
        echo -ne "\033]0\007" # Reset title on exit
}

alias psh=python3shell

# vim: set ts=4 sw=4 tw=79 fdm=marker et :
