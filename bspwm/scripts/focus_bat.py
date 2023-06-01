import subprocess
import sys
import time


def get_nodes():
    node_list_state = subprocess.run(
        ["bspc query --nodes"], shell=True, check=True, capture_output=True
    )

    node_list = node_list_state.stdout.decode("UTF-8").splitlines()

    focused_nodes_state = subprocess.run(
        ["bspc query --nodes --desktop"], shell=True, check=True, capture_output=True
    )

    focused_nodes = focused_nodes_state.stdout.decode("UTF-8").splitlines()

    sleepy_nodes = [node for node in node_list if node not in focused_nodes]

    return sleepy_nodes, focused_nodes


def get_pids(node_list):
    pid_list = []
    for node in node_list:
        xprop_dump = subprocess.run(
            [f"xprop -id {node}"], shell=True, check=True, capture_output=True
        )
        # parse output of xprop for pid
        pid = int(
            [
                line
                for line in xprop_dump.stdout.decode("UTF-8").splitlines()
                if "PID" in line
            ][0].split()[2]
        )
        pid_list.append(pid)

    return pid_list


while True:
    line = sys.stdin.readline()

    while True:
        try:
            sleepy_nodes, focused_nodes = get_nodes()
            break
        except subprocess.CalledProcessError:
            continue

    print(f"sleepy pids: {get_pids(sleepy_nodes)}")
    print(f"focused: {get_pids(focused_nodes)}")
