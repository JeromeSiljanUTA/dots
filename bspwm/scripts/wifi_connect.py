#!/usr/bin/python3

import subprocess

import re

# Terminal ANSI escape sequence
ansi_escape = re.compile(
    r"""
    \x1B  # ESC
    (?:   # 7-bit C1 Fe (except CSI)
        [@-Z\\-_]
    |     # or [ for CSI, followed by a control sequence
        \[
        [0-?]*  # Parameter bytes
        [ -/]*  # Intermediate bytes
        [@-~]   # Final byte
    )
""",
    re.VERBOSE,
)


class Network:
    def __init__(self, ssid, security_type, strength, connected):
        self.connected = connected
        self.ssid = ssid
        self.security_type = security_type
        self.strength = strength

    def __str__(self):
        return f"{self.ssid:<30.30s}\t{self.security_type:<5.5s}\t{self.strength:<5.5s}"


def clean_networks(raw_network_list):
    """Takes stdout of `iwctl station DEVICE get-networks` or `iwctl
    known-networks list` and removes Terminal ANSI
    as well as headers

    :param raw_network_list: stdout of `iwctl station DEVICE get-networks`
    or `iwctl known-networks list`
    :type raw_network_list: str
    :returns: List of rows in stdout of command

    """
    # Remove terminal ASCII codes
    res = ansi_escape.sub("", raw_network_list)
    # Remove out blank and header lines
    return [network for network in res.split("\n")[4:] if network != ""]


def populate_networks(raw_network_list, query_type):
    """Depending on query type, creates a dictionary of networks and their
    characteristics. The dictionary can either hold Network objects or a blank
    string.

    :param raw_network_list:
    :type raw_network_list:
    :param query_type:
    :type query_type:
    :returns:

    """
    networks_dict = {}
    for network_string in raw_network_list:
        network_split = network_string.split()

        if query_type == "get-networks":
            connected = False
            if network_split[0] == ">":
                connected = True
                network_split.pop(0)

            SSID = " ".join(network_split[:-2])

            networks_dict[SSID] = Network(
                ssid=SSID,
                security_type=network_split[-2],
                strength=network_split[-1],
                connected=connected,
            )
        else:
            SSID = " ".join(network_split[:-5])
            networks_dict[SSID] = ""

    return networks_dict


def get_connected_network():
    for network in networks_dict.values():
        if network.connected:
            return network.ssid


def connect_network(ssid, passphrase=None):
    if passphrase:
        subprocess.run(
            [
                "iwctl",
                "station",
                "wlan0",
                "connect",
                ssid,
                "--passphrase",
                passphrase,
            ],
            check=True,
        )

    else:
        subprocess.run(
            ["iwctl", "station", "wlan0", "connect", ssid],
            check=True,
        )


try:
    command = ["iwctl", "known-networks", "list"]
    known_networks = subprocess.run(
        command,
        capture_output=True,
        check=True,
        text=True,
    )
    known_networks_list = clean_networks(known_networks.stdout)
    known_networks_dict = populate_networks(
        known_networks_list,
        "known-networks",
    )

    subprocess.run(["iwctl", "station", "wlan0", "scan"], check=True)
    command = ["iwctl", "station", "wlan0", "get-networks"]
    get_networks = subprocess.run(
        command,
        capture_output=True,
        check=True,
        text=True,
    )
    get_networks_list = clean_networks(get_networks.stdout)
    networks_dict = populate_networks(get_networks_list, "get-networks")

    network_rofi = "\n".join((str(network) for network in networks_dict.values()))

    with subprocess.Popen(
        ["echo", "-e", network_rofi], stdout=subprocess.PIPE
    ) as echo_proc:
        rofi_proc = subprocess.run(
            [
                "rofi",
                "-dmenu",
                "-mesg",
                f"Connected to {get_connected_network()}",
                "-display-columns",
            ],
            stdin=echo_proc.stdout,
            capture_output=True,
            text=True,
            check=True,
        )

    try:
        selected_network = networks_dict[rofi_proc.stdout[:-1]]
        print(selected_network)

        if selected_network.ssid in known_networks_dict:
            print(f"Previously connected to {selected_network.ssid}")
            connect_network(selected_network.ssid)
        else:
            print(f"Never connected to {selected_network.ssid}")
            rofi_proc = subprocess.run(
                [
                    "rofi",
                    "-dmenu",
                    "-password",
                    "-mesg",
                    f"Passphrase for {selected_network.ssid}",
                ],
                capture_output=True,
                text=True,
                check=True,
            )

            wifi_password = rofi_proc.stdout[:-1]

            connect_network(selected_network.ssid, wifi_password)

    except KeyError:
        print("No rofi selection made")


except subprocess.CalledProcessError:
    print(f"Running command '{command}' failed")
