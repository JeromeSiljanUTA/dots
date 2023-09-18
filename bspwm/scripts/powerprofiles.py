#!/usr/bin/python3

import subprocess

import re


def get_current_power_profile() -> str:
    # Parse powerprofilesctl to get current profile.

    command = ["powerprofilesctl", "get"]
    powerprofiles_get_proc = subprocess.run(
        command,
        capture_output=True,
        check=True,
        text=True,
    )
    return powerprofiles_get_proc.stdout[:-1]


def get_available_power_profiles() -> str:
    # Parse powerprofilesctl to get current profile.

    command = ["powerprofilesctl", "list"]
    powerprofiles_get_proc = subprocess.run(
        command,
        capture_output=True,
        check=True,
        text=True,
    )

    # Split each line on newline, replace asterisk (denotes current profile)
    # with blank so that strip removes asterisk, remove last character which is
    # colon, and join to a string with newline as delimeter.
    return "\n".join(
        [
            line.replace("*", "").strip()[:-1]
            for line in powerprofiles_get_proc.stdout.split("\n")
            if "    " not in line and line != ""
        ]
    )


def get_rofi_selection() -> str:
    """Get current profile and available profiles, show rofi menu and return
    selection.
    """

    with subprocess.Popen(
        ["echo", "-e", get_available_power_profiles()], stdout=subprocess.PIPE
    ) as echo_proc:
        rofi_proc = subprocess.run(
            [
                "rofi",
                "-dmenu",
                "-mesg",
                f"Current profile: {get_current_power_profile()}",
            ],
            stdin=echo_proc.stdout,
            capture_output=True,
            text=True,
            check=True,
        )

    # Trim newline when returning
    return rofi_proc.stdout[:-1]


def change_power_profile(selected_profile: str):
    # Change current power profile.
    command = ["powerprofilesctl", "set", selected_profile]
    subprocess.run(
        command,
        capture_output=True,
        check=True,
        text=True,
    )


def main():
    # Gather powerprofiles and push to rofi, change profile based on selection.
    change_power_profile(get_rofi_selection())


if __name__ == "__main__":
    # This will only be run when the module is called directly.
    main()
