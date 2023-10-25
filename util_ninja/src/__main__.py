"""This module is the main interface to util_ninja.

"""
from argparse import ArgumentParser
from battery import send_battery_notification
from bluetooth import activate_bluetooth_rofi
from theme_switch import update_dunst, update_xsettingsd, replace_rofi_config

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
            # Display and handle rofi for bluetooth
            activate_bluetooth_rofi()
        case "theme":
            update_dunst(args.theme)
            update_xsettingsd(args.theme)
            replace_rofi_config(args.theme)


if __name__ == "__main__":
    # This will only be run when the module is called directly.
    main()
