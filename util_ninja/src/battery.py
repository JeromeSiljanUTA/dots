"""Get battery percentage, charging information, powerprofiles mode and push to
notification.

"""

import os
import subprocess

BATTERY_PATH = " /sys/class/power_supply/BAT0/"
os.environ["DISPLAY"] = ":0"


def choose_battery_icon(battery_level: int, charging: bool) -> str:
    # Choose a battery icon depending on the battery level.

    if battery_level > 80:
        battery_icon = "full"
    elif battery_level > 50:
        battery_icon = "good"
    elif battery_level > 20:
        battery_icon = "low"
    else:
        battery_icon = "caution"

    if charging:
        return f"battery-{battery_icon}-charging-symbolic"

    return f"battery-{battery_icon}-symbolic"


def get_battery_info() -> tuple[int, str, bool]:
    """Parse acpi data for battery level, remaining time until battery
    runs out, and chargin status.

    """
    battery_info = (
        subprocess.run(["acpi", "b"], stdout=subprocess.PIPE, check=True)
        .stdout.decode("utf-8")
        .split("\n")
    )

    # Pick last battery listed by acpi. The last element of battery_info is newline so ignore that.
    main_battery = [
        battery for battery in battery_info if "unavailable" not in battery
    ][-2]

    battery_level = int(main_battery.split(",")[1].split("%")[0])

    charging = "Discharging" not in main_battery

    try:
        remaining_time = f", {main_battery.split(',')[2].strip()}"
    except IndexError:
        remaining_time = ""

    return battery_level, remaining_time, charging


def get_power_profile() -> str:
    # Parse powerprofiles for power mode.

    result = subprocess.run(
        "powerprofilesctl", stdout=subprocess.PIPE, check=True
    ).stdout.decode("utf-8")
    profile_line = result.split("*")[-1].split("\n")[0]

    if "power-saver" in profile_line:
        power_profile = "Power Saver"
    elif "balanced" in profile_line:
        power_profile = "Balanced"
    else:
        power_profile = "Performance"

    return power_profile


def send_battery_notification():
    # Sends battery notification.
    battery_level, remaining_time, charging = get_battery_info()
    power_profile = get_power_profile()
    battery_icon = choose_battery_icon(battery_level, charging)

    message = (
        f"'Battery Level' '{battery_level}% {remaining_time} \n"
        f"Mode: {power_profile}' -i {battery_icon}"
    )

    os.system(f"dunstify -r 2 {message}")
