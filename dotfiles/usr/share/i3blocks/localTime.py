#!/usr/bin/env python3.6
# -*- coding: UTF-8 -*-
"""
localTime.py
============

  Version:               1.0.0
  Author:                Michael De Pasquale
  Creation Date:         2017-11-27

  Description
  -----------
    Displays the current time in the i3 status bar, with icons from Weather
    Icons (http://erikflowers.github.io/weather-icons/)
"""

import datetime
import sys


# Formats the given date.
def formatDate(weekday, day, month, year):
    weekdays = {0: 'Mon',
                1: 'Tue',
                2: 'Wed',
                3: 'Thu',
                4: 'Fri',
                5: 'Sat',
                6: 'Sun'}
    weekday = str(weekdays.get(weekday))
    dateIcon = u'<span font_desc="FontAwesome">\uf073</span>'
    year = str(year)

    if len(year) == 4:
        year = year[2:]

    return '{Icon} {Weekday} {Day}-{Month}-{Year}'.format(Icon=dateIcon,
                                                          Weekday=weekday,
                                                          Day=day,
                                                          Month=month,
                                                          Year=year)


# Formats the given time.
def formatTime(hours, minutes):
    hourIcons = {0: u'\uf089',
                 1: u'\uf08a',
                 2: u'\uf08b',
                 3: u'\uf08c',
                 4: u'\uf08d',
                 5: u'\uf08e',
                 6: u'\uf08f',
                 7: u'\uf090',
                 8: u'\uf091',
                 9: u'\uf092',
                 10: u'\uf093',
                 11: u'\uf094'}
    icon = hourIcons.get(hours % 12)

    if icon is None:
        icon = hourIcons[0]

    return (f'<span font_desc='Weather Icons'>{icon}</span>'
            f'{hours:02d}:{mins:02d}')


def main(**args):
    today = datetime.datetime.today()
    date = formatDate(today.weekday(), today.day, today.month, today.year)
    time = formatTime(today.hour, today.minute)
    print("{Date} {Time}".format(Date=date, Time=time))
    return 0


# Allow importing without running script
if __name__ == '__main__':
    sys.exit(main(sys.argv))
