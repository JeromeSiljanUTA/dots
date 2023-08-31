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

device_list = [device.split(" ", 2)[1:] for device in device_list]
device_dict = {device[1]: device[0] for device in device_list}
device_dict["Disconnect"] = "Disconnect"
device_names = "\n".join(device_dict.keys())


with subprocess.Popen(
    ["echo", "-e", device_names], stdout=subprocess.PIPE
) as echo_proc:
    rofi_proc = subprocess.run(
        ["rofi", "-dmenu"],
        stdin=echo_proc.stdout,
        capture_output=True,
        text=True,
        check=True,
    )

try:
    selected_device_id = device_dict[rofi_proc.stdout[:-1]]
except KeyError:
    print("No rofi selection made")

if selected_device_id == "Disconnect":
    disconnect_device_proc = subprocess.run(["bluetoothctl", "disconnect"], check=True)
else:
    connect_device_proc = subprocess.run(
        ["bluetoothctl", "connect", selected_device_id], check=True
    )
