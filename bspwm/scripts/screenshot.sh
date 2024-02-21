#!/bin/bash

file_name=~/"$(date -Iseconds)".png

maim -su "$file_name"

xclip -selection clipboard -t image/png -i "$file_name"

