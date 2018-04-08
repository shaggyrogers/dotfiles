#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
"""
  commands.py
  ==============

  Description:           Custom commands for ranger.
  Author:                Michael De Pasquale <shaggyrogers>
  Creation Date:         2018-03-03
  Modification Date:     2018-03-03
  License:               MIT

"""

from ranger.api.commands import Command


class fasd(Command):
    """ Uses fasd to jump to a frecently/recently used directory
        Source: https://github.com/ranger/ranger/wiki/Commands
    """

    def execute(self):
        import subprocess

        arg = self.rest(1)

        if arg:
            directory = subprocess.check_output(
                ["fasd", "-d"]+arg.split(), universal_newlines=True
            ).strip()
            self.fm.cd(directory)
