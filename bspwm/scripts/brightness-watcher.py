#!/home/jerome/misc/projects/programming/basic_venv/bin/python3
"""
Manges brightness notifications
"""

import sys
import os
import time

import inotify.adapters

brightness_file = "/sys/class/backlight/intel_backlight/brightness"
max_brightness_file = "/sys/class/backlight/intel_backlight/max_brightness"


def scale_value():
    with open(max_brightness_file, "r") as f:
        max_val = int(f.read())
    with open(brightness_file, "r") as f:
        curr_val = int(f.read())
    return round(int(curr_val / max_val * 100) + 0.5)


def _main():
    i = inotify.adapters.Inotify()

    i.add_watch("/sys/class/backlight/intel_backlight")

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
            # print(f"{scale_value()}")
            # sys.stdout.flush()


while True:
    try:
        if __name__ == "__main__":
            _main()
    except:
        pass
