"""This module is the main interface to util_ninja.

"""
from argparse import ArgumentParser
from battery import send_battery_notification

parser = ArgumentParser(
    prog="util_ninja",
    description="Manages a wide range of system utilities.",
)


parser.add_argument("-a", "--action", required=True)
args = parser.parse_args()


def main():
    match args.action:
        case "battery":
            # Gather battery data and push to notification.
            send_battery_notification()


if __name__ == "__main__":
    # This will only be run when the module is called directly.
    main()
