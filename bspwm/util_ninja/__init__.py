"""util_ninja manages a wide range of system utilities, this module is the main
 interface.

"""

from battery import send_battery_notification


def main():
    # Gather battery data and push to notification.
    send_battery_notification()


if __name__ == "__main__":
    # This will only be run when the module is called directly.
    main()
