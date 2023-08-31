#!/usr/bin/python3

import subprocess

try:
    command = ["bluetoothctl", "devices"]
    device_list = (
        subprocess.run(command, capture_output=True, text=True, check=True)
        .stdout[:-1]
        .split("\n")
    )
except subprocess.CalledProcessError:
    print("Running command '{command}' failed")
