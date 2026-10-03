#!/bin/sh
set -eu
for profile in \
    atmega32u4-avr109-8mhz \
    atmega128-usbasp-16mhz \
    atmega128-avrisp-16mhz \
    arduino-uno \
    arduino-mega2560 \
    attiny85-usbasp
do
    make build PROFILE="$profile" FILE=examples/idle.c
    make build PROFILE="$profile" FILE=examples/loop.S
done
if command -v avra >/dev/null 2>&1; then
    make build PROFILE=atmega32u4-avr109-8mhz FILE=examples/loop.asm
fi
echo 'All available example build checks passed.'
