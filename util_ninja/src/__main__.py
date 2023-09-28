"""This module is the main interface to util_ninja.

"""
from argparse import ArgumentParser
from battery import send_battery_notification
from bluetooth import activate_bluetooth_rofi
from brightness_watcher import start

parser = ArgumentParser(
    prog="util_ninja",
    description="Manages a wide range of system utilities.",
)


parser.add_argument("-a", "--action", required=True)
parser.add_argument("-d", "--start-daemons", required=True)
args = parser.parse_args()


def main():
    match args.action:
        case "battery":
            # Gather battery data and push to notification.
            send_battery_notification()
        case "bluetooth":
            # Display and handle rofi for bluetooth
            activate_bluetooth_rofi()
        case _:
            pass


if __name__ == "__main__":
    # This will only be run when the module is called directly.
    main()
