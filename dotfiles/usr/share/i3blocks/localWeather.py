#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
"""
localWeather.py
===============

  Version:               1.1.0
  Author:                Michael De Pasquale
  Creation Date:         2017-11-06
  License:               None

  Description
  -----------
  A simple script that retrieves BOM weather station data and outputs a pretty
  and concise summary.

  Usage
  -----
  Requires a font patched to have Weather Icons starting from U+E840.
  Font is by Erik Flowers: http://erikflowers.github.io/weather-icons/.

  To configure the script, find the BOM URI for the JSON-formatted weather
  data you want to display and set the value of BOM_API_URL. All VIC weather
  stations can be found at http://www.bom.gov.au/vic/observations/vicall.shtml

  To display the data, call the script from i3blocks/i3blocks-gaps or anything
  else that can display the pango markup language.
"""

import json
import math
import re
import requests
import sys


# Configuration
BOM_API_URI = 'http://www.bom.gov.au/fwo/IDV60801/IDV60801.94865.json'


def formatIcon(icon):
    """ Formats icon. Returns None if icon is not a string. """
    return icon


def getWindDirIcon(windDir):
    """ Returns an icon for the given compass direction. Returns None if
        unsuccessful.
    """
    compass = {'n':    u'\ue89c',  # wi-towards-n
               'nne':  u'\ue89a',  # wi-towards-ne
               'ne':   u'\ue89a',  # wi-towards-ne
               'ene':  u'\ue89a',  # wi-towards-ne
               'e':    u'\ue899',  # wi-towards-e
               'ese':  u'\ue89d',  # wi-towards-se
               'se':   u'\ue89d',  # wi-towards-se
               'sse':  u'\ue89d',  # wi-towards-se
               's':    u'\ue8a0',  # wi-towards-s
               'ssw':  u'\ue89e',  # wi-towards-sw
               'sw':   u'\ue89e',  # wi-towards-sw
               'wsw':  u'\ue89e',  # wi-towards-sw
               'w':    u'\ue8a1',  # wi-towards-w
               'wnw':  u'\ue89b',  # wi-towards-nw
               'nw':   u'\ue89b',  # wi-towards-nw
               'nnw':  u'\ue89b'}  # wi-towards-nw

    return compass.get(windDir.lower())


def getForecast(weather, cloud=None):
    """ Returns a short forecast string for the given weather data. """

    if cloud is None:
        return weather.lower()

    return weather.lower() if weather != '-' else cloud.lower()


def getForecastIcon(weather, cloud):
    """ Returns an icon for the weather forecast data. If if none is found, a
        default icon will be returned.
    """
    key = weather.lower() if weather != '-' else cloud.lower()
    key = re.sub('mostly ', '', key)

    # Neither day nor night
    icons = {'cloudy':         u'☁',  # u'\ue853',  # wi-cloudy
             'light showers':  u'🌦',  # u'\ue85a',  # wi-showers
             'partly cloudy':  u'⛅',  # u'\ue881',  # wi-cloud
             'showers':        u'🌧',  # u'\ue85a',  # wi-showers
             'sunny':          u'☀',  # u'\ue84d',  # wi-day-sunny
             'clear':          u'☀',  # u'\ue84d',  # wi-day-sunny
             'wind':           u'🌬',  # u'\ue840',  # wi-day-cloudy-gusts
             'storm':          u'⛈',  # u'\ue850',  # wi-day-thunderstorm
             'light-rain':     u'🌦',  # u'\ue84b'}  # wi-day-sprinkle
            }

    if key not in icons:
        return u'\ue84d'  # wi-day-sunny

    return icons.get(key)


def getTemperatureIcon(temp):
    """ Returns an icon for the temperature range. Will return an icon for any
        float value.
    """
    if isinstance(temp, str) or isinstance(temp, int):
        temp = float(temp)

    fltemp = math.floor(temp)

    # Get icon for temperature range
    if fltemp <= 0:
        return u''
    elif fltemp <= 9:
        return u''
    elif fltemp >= 10 and fltemp <= 19:
        return u''
    elif fltemp >= 20 and fltemp <= 24:
        return u''
    elif fltemp >= 25 and fltemp <= 29:
        return u''

    # fltemp >= 30:
    return u''


def main(*args):
    """ Retrieves BOM data and prints a formatted string. Returns 0 if
        successful or a nonzero exit code otherwise.
    """
    # GET data and parse as JSON
    response = requests.get(BOM_API_URI)

    if response.status_code != 200:
        print('Error: HTTP code {0}'.format(response.status_code))
        sys.exit(1)

    respData = json.loads(response.text)

    # Parse data and print formatted output
    latestData = respData['observations']['data'][0]
    shortOutput = ''
    output = ''

    # Weather
    if 'weather' in latestData:
        icon = formatIcon(getForecastIcon(latestData['weather'],
                                          latestData.get('cloud')))
        forecast = getForecast(latestData['weather'], latestData.get('cloud'))
        output += '{0} {1}  '.format(icon, forecast)
        shortOutput += '{0} {1}  '.format(icon, forecast)

    # Temperature
    if 'air_temp' in latestData:
        temp = u'{0:1.1f}'.format(float(latestData['air_temp']))
        icon = formatIcon(getTemperatureIcon(latestData['air_temp']))

        if 'apparent_t' in latestData:
            appTemp = u'{0:1.1f}'.format(float(latestData['apparent_t']))
            output += '{0} {1}°C ({2})  '.format(icon, temp, appTemp)
            shortOutput += '{0} {1}°C ({2})  '.format(icon, temp, appTemp)
        else:
            output += '{0} {1}°C  '.format(icon, temp)
            shortOutput += '{0} {1}°C  '.format(icon, temp)

    # Humidity
    if 'rel_hum' in latestData:
        icon = formatIcon('')
        output += u'{0} {1:1.0f}%  '.format(icon, float(latestData['rel_hum']))

    # Wind
    if 'wind_spd_kmh' in latestData:
        windSpeed = u'{0:1.0f}km/h'.format(float(latestData['wind_spd_kmh']))
        icon = formatIcon('')
        output += '{0} {1}'.format(icon, windSpeed)

    print(output)
    print(shortOutput)
    return 0


# Execute script if not imported
if __name__ == '__main__':
    sys.exit(main(sys.argv))
