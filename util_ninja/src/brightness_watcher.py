#!/home/jerome/misc/projects/programming/basic_venv/bin/python3
"""Manages brightness notifications
"""

import os

import inotify.adapters

brightness_file = "/sys/class/backlight/intel_backlight/brightness"
max_brightness_file = "/sys/class/backlight/intel_backlight/max_brightness"


def scale_value() -> int:
    with open(max_brightness_file, "r", encoding="UTF-8") as f:
        max_val = int(f.read())
    with open(brightness_file, "r", encoding="UTF-8") as f:
        curr_val = int(f.read())
    return round(int(curr_val / max_val * 100) + 0.5)


def start():
    i = inotify.adapters.Inotify()

    i.add_watch("/sys/class/backlight/intel_backlight")

    for event in i.event_gen(yield_nones=False):
        (_, type_names, _, filename) = event
        if filename == "brightness" and type_names == ["IN_CLOSE_WRITE"]:
            scaled_brightness = scale_value()
            if scaled_brightness > 50:
                icon = "brightness-high"
            else:
                icon = "brightness-low"
            os.system(
                f"dunstify -r 4 'Brightness' -h "
                f"int:value:{scaled_brightness} -i {icon}"
            )
