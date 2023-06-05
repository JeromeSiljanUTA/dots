#!/usr/bin/env python3
import sys
import os

from pulsectl import Pulse, PulseLoopStop

with Pulse() as pulse:

    def callback(ev):
        raise PulseLoopStop

    def current_status(sink):
        return round(sink.volume.value_flat * 100), sink.mute == 1

    while True:
        try:
            sinks = {s.index: s for s in pulse.sink_list()}
            if len(sys.argv) > 1:
                # Sink index from command line argument if provided
                sink_index = int(sys.argv[1])
                if not sink_index in sinks:
                    raise KeyError(
                        f"Sink index {sink_index} not found in list of sinks."
                    )
            else:
                # Automatic determination of default sink otherwise
                default_sink_name = pulse.server_info().default_sink_name
                try:
                    sink_index = next(
                        index
                        for index, sink in sinks.items()
                        if sink.name == default_sink_name
                    )
                except StopIteration:
                    raise StopIteration("No default sink was found.")

            pulse.event_mask_set("sink")
            pulse.event_callback_set(callback)
            last_value, last_mute = current_status(sinks[sink_index])

            while True:
                pulse.event_listen()
                sinks = {s.index: s for s in pulse.sink_list()}
                default_sink_name = pulse.server_info().default_sink_name
                sink_index = next(
                    index
                    for index, sink in sinks.items()
                    if sink.name == default_sink_name
                )
                value, mute = current_status(sinks[sink_index])
                if value != last_value or mute != last_mute:
                    # print(str(value) + ("!" if mute else ""))
                    message = str(value)
                    if mute:
                        os.system(
                            f"dunstify -r 3 'Volume Muted' [{value}%] -h int:value:0"
                        )
                    else:
                        if value > 80:
                            icon = "audio-volume-high-symbolic"
                        elif value > 30:
                            icon = "audio-volume-medium-symbolic"
                        else:
                            icon = "audio-volume-low-symbolic"

                        os.system(
                            # f"dunstify -r 3 Volume {value}% -h int:value:{message} -i {icon}"
                            f"dunstify -r 3 Volume -h int:value:{message} -i {icon}"
                        )
                    last_value, last_mute = value, mute
                sys.stdout.flush()

        except Exception as e:
            print(f"ERROR: {e}", file=sys.stderr)
            pass
