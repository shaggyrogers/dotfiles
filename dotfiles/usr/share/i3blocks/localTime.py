#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
# pylint: disable=invalid-name
"""
localTime.py
============

  Description:           Displays the current time in the i3 status bar.
  Author:                Michael De Pasquale
  Creation Date:         2017-11-27
  Modification Date:     2020-08-28
  License:               MIT

  Notes
  -----
  Requires nerd fonts (http://nerdfonts.com/).
"""

from datetime import datetime
import sys


def formatDate(weekday: int, day: int, month: int, year: int) -> str:
    """ Formats the given date. """
    weekday = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][weekday]
    return f"📅{weekday} {year}-{month}-{day}"


def formatTime(hours: int, minutes: int) -> str:
    """ Formats the given time. """
    icon = [
        ["🕛", "🕧"],
        ["🕐", "🕜"],
        ["🕑", "🕝"],
        ["🕒", "🕞"],
        ["🕓", "🕟"],
        ["🕔", "🕠"],
        ["🕕", "🕡"],
        ["🕖", "🕢"],
        ["🕗", "🕣"],
        ["🕘", "🕤"],
        ["🕙", "🕥"],
        ["🕚", "🕦"],
    ][hours % 12][minutes // 30]

    return f"{icon}{hours:02d}:{minutes:02d}"


def main() -> None:
    """ Prints a string representing the date and time. """
    now = datetime.now()
    date = formatDate(now.weekday(), now.day, now.month, now.year)
    time = formatTime(now.hour, now.minute)
    print(f"{date} {time}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

#  vim: set ts=4 sw=4 tw=79 fdm=marker ff=unix fenc=utf-8 et :
