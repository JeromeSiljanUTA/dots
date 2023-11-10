#!/home/jerome/misc/projects/programming/basic_venv/bin/python3
"""Sends notification when desktop focus changes."""

import subprocess
import os

DESKTOP_SUBSCRIBE_CMD = "bspc subscribe desktop_focus"
CURRENT_DESKTOP_CMD = "bspc query -D -d --names"
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
        send_desktop_notification()


def send_desktop_notification():
    """Gets currently focused desktop and sends the corresponding
    notification."""

    focused_desktop = subprocess.run(
        CURRENT_DESKTOP_CMD.split(" "), check=True, capture_output=True
    ).stdout.decode()[:-1]
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

    subprocess.run(f"dunstify -r 1 {focused_desktop} -i {icon}".split(" "), shell=False)
