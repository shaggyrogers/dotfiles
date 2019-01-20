#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
# pylint: disable=invalid-name, import-error
"""
clementineNowPlaying.py
=======================

  Description:           Retrieves the current song in Clementine.
  Author:                Michael De Pasquale
  Creation Date:         2018-01-28
  Modification Date:     2019-01-20
  License:               MIT

"""

import sys

from pydbus import SessionBus

# Configuration
MaxCharacters = 48
ScrollFactor = 3


def main():
    """ Entry point for this script. """
    # Get mpris2
    bus = SessionBus()
    mpris = bus.get("org.mpris.MediaPlayer2.clementine",
                    "/org/mpris/MediaPlayer2")

    if mpris is None or mpris.Metadata is None:
        sys.exit(1)

    # Get metadata
    md = mpris.Metadata
    status = mpris.PlaybackStatus.strip().lower()

    if status is None or mpris.Position is None:
        sys.exit(0)

    # Parse metadata
    statusIcons = {'paused': u'\uf04c',
                   'playing': u'\uf04b',
                   'stopped': u'\uf04d'}
    status = statusIcons[status] if status in statusIcons else '?'
    artist = md.get("xesam:artist")
    album = md.get("xesam:album")
    track = md.get("xesam:title")
    bitrate = md.get("bitrate")

    if artist is None:
        artist = "Unknown Artist"

    elif isinstance(artist, list) and artist:
        artist = artist[0]

    album = album if album is not None else "Unknown Album"
    track = track if track is not None else "Unknown Track"

    # Build result string
    icons = f'\uf025 {status} '
    result = f'{artist} - {album} - {track}'

    if bitrate is not None:
        result = f'{result} @ {bitrate} kbps'

    # Apply scroll effect based on the time and print result
    pos = mpris.Position
    posSeconds = (float(pos) / 1000000.0)
    strPos = int(posSeconds * ScrollFactor) % len(result)
    result = result[strPos:] + "    " + result[0:strPos]
    print(icons + result[:MaxCharacters])

    return 0


# Allow import without running script
if __name__ == '__main__':
    sys.exit(main())
