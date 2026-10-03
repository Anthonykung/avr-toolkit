#!/bin/sh
set -eu
found=0
for path in /dev/ttyACM* /dev/ttyUSB* /dev/cu.usbmodem* /dev/cu.usbserial*; do
    if [ -e "$path" ]; then
        printf '%s\n' "$path"
        found=1
    fi
done
if [ "$found" -eq 0 ]; then
    echo 'No common Linux/macOS serial ports found. Reconnect the board or enter its bootloader.'
fi
