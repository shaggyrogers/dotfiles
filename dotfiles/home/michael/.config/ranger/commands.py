#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
"""
  commands.py
  ==============

  Description:           Custom commands for ranger.
  Author:                Michael De Pasquale <shaggyrogers>
  Creation Date:         2018-03-03
  Modification Date:     2018-05-10
  License:               MIT

"""

from ranger.api.commands import Command


class fasd(Command):
    """
        Uses fasd to jump to a frecently/recently used directory
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


class mkcd(Command):
    """
        Creates a directory with the name <dirname> and enters it.
        Source: https://github.com/ranger/ranger/wiki/Custom-Commands
    """

    def execute(self):
        from os.path import join, expanduser, lexists
        from os import makedirs
        import re

        dirname = join(self.fm.thisdir.path, expanduser(self.rest(1)))
        if not lexists(dirname):
            makedirs(dirname)

            match = re.search('^/|^~[^/]*/', dirname)
            if match:
                self.fm.cd(match.group(0))
                dirname = dirname[match.end(0):]

            for m in re.finditer('[^/]+', dirname):
                s = m.group(0)
                if s == '..' or (s.startswith('.') and not
                                 self.fm.settings['show_hidden']):
                    self.fm.cd(s)
                else:
                    ## We force ranger to load content before calling `scout`.
                    self.fm.thisdir.load_content(schedule=False)
                    self.fm.execute_console('scout -ae ^{}$'.format(s))
        else:
            self.fm.notify("file/directory exists!", bad=True)

class toggle_flat(Command):
    """ Flattens or unflattens the current directory view, with limit 1.
        Source: https://github.com/ranger/ranger/wiki/Commands
    """

    def execute(self):
        if self.fm.thisdir.flat == 0:
            self.fm.thisdir.unload()
            self.fm.thisdir.flat = 1
            self.fm.thisdir.load_content()
        else:
            self.fm.thisdir.unload()
            self.fm.thisdir.flat = 0
            self.fm.thisdir.load_content()
