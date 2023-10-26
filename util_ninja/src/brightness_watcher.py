#!/home/jerome/misc/projects/programming/basic_venv/bin/python3
"""
Manges brightness notifications
"""

import sys
import os
import time

import inotify.adapters

WATCH_DIR = "/sys/class/backlight/intel_backlight/"
BRIGHTNESS_FILE = "/sys/class/backlight/intel_backlight/brightness"
MAX_BRIGHTNESS_FILE = "/sys/class/backlight/intel_backlight/max_brightness"


def scale_value() -> int:
    # Scales brightness to 0-100.
    with open(MAX_BRIGHTNESS_FILE, "r") as f:
        max_val = int(f.read())
    with open(BRIGHTNESS_FILE, "r") as f:
        curr_val = int(f.read())
    return round(int(curr_val / max_val * 100) + 0.5)


def brightness_watcher():
    # Sets inotify watcher on backlight directory and handles events.
    i = inotify.adapters.Inotify()

    i.add_watch(WATCH_DIR)

    for event in i.event_gen(yield_nones=False):
        (_, type_names, path, filename) = event
        if filename == "brightness" and type_names == ["IN_CLOSE_WRITE"]:
            scaled_brightness = scale_value()
            if scaled_brightness > 70:
                icon = "display-brightness-high-symbolic"
            elif scaled_brightness > 40:
                icon = "display-brightness-medium-symbolic"
            elif scaled_brightness > 15:
                icon = "display-brightness-low-symbolic"
            else:
                icon = "display-brightness-off-symbolic"

            os.system(
                f"dunstify -r 4 'Brightness' -h int:value:{scaled_brightness} -i {icon}"
            )


def brightness_watcher_loop():
    # Sets brightness watcher to go in a loop forever.
    brightness_watcher()


"""
    while True:
        try:
            brightness_watcher()
        except:
            pass

"""
