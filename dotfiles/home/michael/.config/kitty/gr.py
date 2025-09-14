#!/usr/bin/env python
# vim:fileencoding=utf-8
"""
  gr.py
  =====

  Description:           Executed when starting kitty.
  License:               GPL v3 Copyright: 2017, Kovid Goyal <kovid at kovidgoyal.net>
  Authors:               Kovid Goyal, Michael De Pasquale

"""

import os
import sys
import zlib
from base64 import standard_b64encode


def write(data):
    sys.stdout.buffer.write(data)


def clear_screen():
    write(b"\033[2J")


def move_cursor(x, y):
    write("\033[{};{}H".format(y, x).encode("ascii"))


def write_gr_cmd(cmd, payload):
    cmd = ",".join("{}={}".format(k, v) for k, v in cmd.items())
    w = write
    w(b"\033_G"), w(cmd.encode("ascii")), w(b";"), w(payload), w(b"\033\\")
    sys.stdout.flush()


def display(data, width, height, x, y, z, ncols=0, nrows=0):
    move_cursor(x, y)
    cmd = {
        "a": "T",
        "s": width,
        "v": height,
        "c": ncols,
        "r": nrows,
        "S": len(data),
        "z": z,
    }
    data = zlib.compress(data)
    cmd["o"] = "z"
    data = standard_b64encode(data)

    while data:
        chunk, data = data[:4096], data[4096:]
        m = 1 if data else 0
        cmd["m"] = m
        write_gr_cmd(cmd, chunk)
        cmd.clear()


def display_png_file(path):
    cmd = {"a": "T", "t": "f", "f": "100"}
    path = os.path.abspath(path)

    if not isinstance(path, bytes):
        path = path.encode(sys.getfilesystemencoding() or "utf-8")

    data = standard_b64encode(path)
    write_gr_cmd(cmd, data)


def main():
    clear_screen()
    display_png_file(os.path.expanduser("~/.config/kitty/Logo.png"))
    write(b"\n")


if __name__ == "__main__":
    os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
    main()
