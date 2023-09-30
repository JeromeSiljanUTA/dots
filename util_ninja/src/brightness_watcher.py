#!/home/jerome/misc/projects/programming/basic_venv/bin/python3
"""Manages brightness notifications
"""

import os

import inotify.adapters

backlight_directory = "/sys/class/backlight/intel_backlight/"
brightness_file = f"{backlight_directory}brightness"
max_brightness_file = f"{backlight_directory}max_brightness"


def scale_value() -> int:
    # Read brightness value from file and scale from 0-100
    with open(max_brightness_file, "r", encoding="UTF-8") as f:
        max_val = int(f.read())
    with open(brightness_file, "r", encoding="UTF-8") as f:
        curr_val = int(f.read())
    return round(int(curr_val / max_val * 100) + 0.5)


def start():
    # Monitor backlight file for changes
    i = inotify.adapters.Inotify()

    i.add_watch(backlight_directory)

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
