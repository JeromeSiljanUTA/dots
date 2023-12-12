#!/home/jerome/misc/projects/programming/basic_venv/bin/python3
"""This module is the main interface to util_ninja.

"""
from argparse import ArgumentParser
from battery import send_battery_notification
from bluetooth import activate_bluetooth_rofi
from brightness_watcher import brightness_watcher_loop
from desktop_notifier import desktop_subscribe_loop
from theme_switch import (
    update_dunst,
    update_xsettingsd,
    replace_rofi_config,
    replace_gtk3_config,
    update_emacsclient,
    check_theme,
    set_state,
)

parser = ArgumentParser(
    prog="util_ninja",
    description="Manages a wide range of system utilities.",
)


parser.add_argument("-a", "--action", required=True)
parser.add_argument("-t", "--theme", required=False)
args = parser.parse_args()


def main():
    match args.action:
        case "battery":
            # Gather battery data and push to notification.
            send_battery_notification()
        case "bluetooth":
            # Display and handle rofi for bluetooth.
            activate_bluetooth_rofi()
        case "brightness":
            # Start program that displays changes in brightness.
            brightness_watcher_loop()
        case "desktop":
            desktop_subscribe_loop()
        case "theme":
            # Change dunst, xsettings, and rofi config based on theme.
            if check_theme(args.theme):
                set_state(args.theme)
                update_dunst(args.theme)
                update_xsettingsd(args.theme)
                replace_rofi_config(args.theme)
                replace_gtk3_config(args.theme)
                update_emacsclient(args.theme)
            else:
                raise ValueError('Theme must be either "dark" or "light".')


if __name__ == "__main__":
    # This will only be run when the module is called directly.
    main()
