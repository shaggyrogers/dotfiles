#!/usr/bin/env python3.7
# -*- coding: UTF-8 -*-
# pylint: disable=invalid-name,logging-format-interpolation
"""
  localWeather.py
  ===============

  Description:           Displays BOM weather station data in i3blocks.
  Author:                Michael De Pasquale
  Creation Date:         2017-11-06
  Modification Date:     2020-08-28
  License:               MIT

  Requires
  --------
  * Nerd fonts (http://nerdfonts.com/).
  * An emoji font which supports emoji 10 or later.
  * Python 3.7.0 or later
    - requests

  Usage
  -----
  To configure the script, find the BOM URI for the JSON-formatted weather
  data you want to display and set the value of BOM_API_URL. All VIC weather
  stations can be found at http://www.bom.gov.au/vic/observations/vicall.shtml

"""

import json
import logging
import math
import re
import sys
from typing import Union

import requests


# Configuration
BOM_API_URI = "http://www.bom.gov.au/fwo/IDV60801/IDV60801.94865.json"


def getWindDirIcon(windDir: str) -> str:  # {{{
    """ Returns an icon for the given compass direction. Returns None if
        unsuccessful.
    """
    return {
        "n": "\ue89c",  # wi-towards-n
        "nne": "\ue89a",  # wi-towards-ne
        "ne": "\ue89a",  # wi-towards-ne
        "ene": "\ue89a",  # wi-towards-ne
        "e": "\ue899",  # wi-towards-e
        "ese": "\ue89d",  # wi-towards-se
        "se": "\ue89d",  # wi-towards-se
        "sse": "\ue89d",  # wi-towards-se
        "s": "\ue8a0",  # wi-towards-s
        "ssw": "\ue89e",  # wi-towards-sw
        "sw": "\ue89e",  # wi-towards-sw
        "wsw": "\ue89e",  # wi-towards-sw
        "w": "\ue8a1",  # wi-towards-w
        "wnw": "\ue89b",  # wi-towards-nw
        "nw": "\ue89b",  # wi-towards-nw
        "nnw": "\ue89b",
    }.get(
        windDir.lower().strip()
    )  # }}}


def getForecast(weather: str, cloud: str = None) -> str:  # {{{
    """ Returns a short forecast string for the given weather data. """
    weather = weather.lower().strip()

    if weather == "-":
        return cloud.lower() if cloud else None

    return weather  # }}}


def getForecastIcon(weather: str, cloud: str) -> str:  # {{{
    """ Returns an icon for the weather forecast data. If if none is found, a
        default icon will be returned.
    """
    key = getForecast(weather, cloud)

    if not key:
        return ""

    key = re.sub("mostly ", "", key)

    # Neither day nor night
    icons = {
        "cloudy": "☁️",
        "light showers": "🌦",
        "partly cloudy": "⛅",
        "showers": "🌧",
        "sunny": "☀️",
        "clear": "☀️",
        "wind": "💨",
        "storm": "⛈",
        "light-rain": "🌦",
    }

    return icons.get(key, "")  # }}}


def getTemperatureIcon(temp: Union[float, int, str]) -> str:  # {{{
    """ Returns an icon for the given temperature, in degrees C.  """
    fltemp = math.floor(float(temp))

    # Get icon for temperature range
    # pylint: disable=bad-continuation
    for trange, icon in [
        (0, "❄️"),
        (9, ""),
        (19, ""),
        (24, ""),
        (29, ""),
        (39, ""),
    ]:
        if fltemp <= trange:
            return icon

    assert fltemp >= 40
    return "🔥"  # }}}


def main() -> None:  # {{{
    """ Retrieves BOM data and prints a formatted string. Returns 0 if
        successful or a nonzero exit code otherwise.
    """
    logging.basicConfig()
    log = logging.getLogger(__name__)
    log.setLevel(10)

    # GET data and parse as JSON
    # log.debug("Retrieving %s" % BOM_API_URI)
    response = requests.get(BOM_API_URI)

    if response.status_code != 200:
        print("Error: HTTP code {0}".format(response.status_code))
        sys.exit(1)

    respData = json.loads(response.text)
    # log.debug(json.dumps(respData, indent=4, separators=(", ", ": "), sort_keys=True))

    # Parse data and print formatted output
    latestData = respData["observations"]["data"][0]
    shortOutput = ""
    output = ""

    # Weather
    if "weather" in latestData:
        icon = getForecastIcon(latestData["weather"], latestData.get("cloud"))
        forecast = getForecast(latestData["weather"], latestData.get("cloud"))
        output += "{0} {1}  ".format(icon, forecast)
        shortOutput += "{0} {1}  ".format(icon, forecast)

    # Temperature
    if "air_temp" in latestData:
        temp = "{0:1.1f}".format(float(latestData["air_temp"]))
        icon = getTemperatureIcon(latestData["air_temp"])

        # if "apparent_t" in latestData:
        #     appTemp = "{0:1.1f}".format(float(latestData["apparent_t"]))
        #     output += "{0} {1}°C ({2})  ".format(icon, temp, appTemp)
        #     shortOutput += "{0} {1}°C ({2})  ".format(icon, temp, appTemp)

        # else:
        output += "{0} {1}°C  ".format(icon, temp)
        shortOutput += "{0} {1}°C  ".format(icon, temp)

    # Humidity
    if "rel_hum" in latestData:
        output += "{0} {1:1.0f}%  ".format("💧", float(latestData["rel_hum"]))

    # Wind
    if "wind_spd_kmh" in latestData:
        windSpeed = "{0:1.0f}km/h".format(float(latestData["wind_spd_kmh"]))
        output += "{0} {1}".format("💨", windSpeed)

    print(output)
    print(shortOutput)
    return 0  # }}}


if __name__ == "__main__":
    sys.exit(main())

#  vim: set ts=4 sw=4 tw=79 fdm=marker ff=unix fenc=utf-8 et :
