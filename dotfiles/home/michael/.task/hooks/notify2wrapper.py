#!/usr/bin/env python3
"""
notify2wrapper.py
=================

  Version:               1.0.0
  Author:                Michael De Pasquale
  Creation Date:         2018-01-02
  License:               None

  Description
  -----------
  Wrapper for notify2 that makes it even easier to use and adds fuctionality.

  Dependencies
  ------------
  notify2               python3-notify2
  dbus                  python3-dbus, python3-dbus.mainloop.qt

  Usage
  -----
  Import and shorten the name:

    import notify2wrapper as notify

  Run as a script:

    notify2wrapper title [message] [icon] [hints]

  References/Links
  ----------------
  * Notification Protocol Spec: https://people.gnome.org/ \
    ~mccann/docs/notification-spec/notification-spec-latest.html
"""

import json
import sys

import notify2


class Notifier:
    """
    Creates notifications.

    Methods
    -------
    TODO
    """
    __instance = None
    __notify2 = False

    def __new__(cls, *args, **kwargs):
        """
        Create (if necessary) and return the singleton instance.
        """
        if cls.__instance is None:
            cls.__instance = super().__new__(cls, *args, **kwargs)

        return cls.__instance


    def __init__(self):
        """
        Initialise a new Notifier instance.
        """
        if not self.__notify2:
            self.__notify2 = notify2.init('notify2wrapper')

    def notify(self, title, message='', icon='', timeout=5000, hints={}):
        """
        Simple notify function.
        """
        notification = notify2.Notification(title, message, icon)

        for hint, value in hints:
            notification.set_hint(hint, value)

        notification.set_timeout(timeout)
        notification.show()


def main(*args):
    """
    Parses arguments, creates a Notifier and calls notify.
    """
    # notify2wrapper title [message] [icon] [hints]
    if len(args) == 0:
        print('Usage: notify2wrapper title [message] [icon] [hints]')
        sys.exit(1)

    notifier = Notifier()

    if len(args) == 1:
        notifier.notify(args[0])

    if len(args) == 2:
        notifier.notify(args[0], args[1])

    if len(args) == 3:
        notifier.notify(args[0], args[1], args[2])

    if len(args) == 4:
        notifier.notify(args[0], args[1], args[2], args[3])

    return 0


if __name__ == '__main__':
    sys.exit(main(*sys.argv[1:]))
