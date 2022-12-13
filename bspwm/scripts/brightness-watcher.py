#!/usr/bin/env python3

import inotify.adapters
import sys
import time

brightness_file = "/sys/class/backlight/intel_backlight/brightness"
max_brightness_file = "/sys/class/backlight/intel_backlight/max_brightness"


def scale_value():
    with open(max_brightness_file, "r") as f:
        max_val = int(f.read())
    with open(brightness_file, "r") as f:
        curr_val = int(f.read())
    return int(curr_val / max_val * 100)


def _main():
    i = inotify.adapters.Inotify()

    i.add_watch("/sys/class/backlight/intel_backlight")

    for event in i.event_gen(yield_nones=False):
        (_, type_names, path, filename) = event
        if filename == "brightness" and type_names == ["IN_CLOSE_WRITE"]:
            print(f"{scale_value()}")
            sys.stdout.flush()


if __name__ == "__main__":
    _main()
