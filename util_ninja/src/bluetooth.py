"""Get bluetooth paired devices, connect to bluetooth devices. Display through
rofi.

"""

import subprocess


def get_devices(device_type: str) -> dict:
    # Get paired devices by parsing bluetoothctl. Device type is 'devices'.

    try:
        command = ["bluetoothctl", device_type]
        device_list = (
            subprocess.run(command, capture_output=True, text=True, check=True)
            .stdout[:-1]
            .split("\n")
        )
        device_list = [device.split(" ", 2)[1:] for device in device_list]
        device_dict = {device[1]: device[0] for device in device_list}
        device_dict["Disconnect"] = "Disconnect"
        return device_dict

    except subprocess.CalledProcessError:
        print(f"Running command '{command}' failed")


def show_rofi_menu(device_dict: dict) -> str:
    # Show rofi menu and return selection.
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

    return device_dict[rofi_proc.stdout[:-1]]


def handle_rofi_selection(selected_device_id: str):
    # Disconnect or connect to devices based on selected device id.
    if selected_device_id == "Disconnect":
        subprocess.run(["bluetoothctl", "disconnect"], check=True)
    else:
        subprocess.run(
            [
                "bluetoothctl",
                "connect",
                selected_device_id,
            ],
            check=True,
        )


def activate_bluetooth_rofi():
    # Pulls all the functions together.
    handle_rofi_selection(show_rofi_menu(get_devices("devices")))
