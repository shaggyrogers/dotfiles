#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
"""
myFortune.py
============

  Version:               1.0.0
  Author:                Michael De Pasquale
  Creation Date:         2018-01-25
  License:               None

  Description
  -----------
  Outputs a randomly selected 'fortune'
"""

import os
import random
import sys

# Misc. quotes/aphorisms/'oblique strategies' from
# * Oblique Strategies, 4th Edition, with modifications
# * Unofficial 'oblique strategies' from a variety of sources
# * Phrases about common programming-related problems
# * https://github.com/RobBlackwell/oblique-strategies-for-programmers
# * Programming-related 'Oblique Strategies' by Kevin Lawler
def main(*args):
    """Entry point. Returns 0 for success or a nonzero exit code otherwise"""
    # Load
    allObliqueStrategies = []


    with open(os.path.expanduser('~/.config/bash/fortunes.txt'), 'r') as f:
        line = f.readline()

        while line:
            allObliqueStrategies.append(line)
            line = f.readline()

    # Select random and print
    random.seed()
    print(random.choice(allObliqueStrategies))

    return 0


# Allow importing without execution
if __name__ == '__main__':
    sys.exit(main(sys.argv))
