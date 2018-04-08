#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
"""
  mrd.py
  ==============

  Description:           Uses fasd to jump to a frecently used directory
  Author:                Ranger Team
                         -->https://github.com/ranger/ranger/wiki/Commands

  Creation Date:         unknown
  Modification Date:     unknown
  License:               unknown

"""

from ranger.api.commands import Command


class fasd(Command):
    """ :fasd - Jump to directory using fasd """

    def execute(self):
        import subprocess

        arg = self.rest(1)

        if arg:
            directory = subprocess.check_output(
                ["fasd", "-d"]+arg.split(), universal_newlines=True
            ).strip()
            self.fm.cd(directory)
