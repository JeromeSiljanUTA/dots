#!/home/jerome/misc/projects/programming/basic_venv/bin/python3
"""Sends notification when desktop focus changes."""

import subprocess
import os

DESKTOP_SUBSCRIBE_CMD = "bspc subscribe report desktop_focus"
os.environ["DISPLAY"] = ":0"


def desktop_subscribe_loop():
    # Run desktop subscribe command and handle output.
    desktop_subscribe = subprocess.Popen(
        DESKTOP_SUBSCRIBE_CMD.split(" "), stdout=subprocess.PIPE
    )
    while True:
        report = desktop_subscribe.stdout.readline()
        if not report and desktop_subscribe.poll() is not None:
            break
        send_desktop_notification(report.decode())


def send_desktop_notification(report: str):
    """Takes output of desktop subscribe command and sends the corresponding
    notification."""

    if "desktop_focus" not in report:
        focused_desktop = next(
            desktop for desktop in report.split(":") if desktop[0] in ("O", "F")
        )[1:]

        match focused_desktop:
            case "Terminal":
                icon = "terminal-symbolic"
            case "Notes":
                icon = "notes-symbolic"
            case "Emacs":
                icon = "emacs-symbolic"
            case "Firefox":
                icon = "firefox-symbolic"
            case "Comms":
                icon = "messengerfordesktop-symbolic"
            case "IDE":
                icon = "programming-symbolic"
            case "Files":
                icon = "file-manager-symbolic"
            case "Media":
                icon = "library-music-symbolic"
            case _:
                icon = "preferences-desktop-display"

        subprocess.run(
            f"dunstify -r 1 {focused_desktop} -i {icon}".split(" "), shell=False
        )
