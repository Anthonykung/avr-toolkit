#!/bin/sh
set -eu
missing=0
for tool in make avr-gcc avr-objcopy avr-size avrdude; do
    if command -v "$tool" >/dev/null 2>&1; then
        printf 'OK      %s: %s\n' "$tool" "$(command -v "$tool")"
    else
        printf 'MISSING %s\n' "$tool"
        missing=1
    fi
done
if command -v avra >/dev/null 2>&1; then
    printf 'OK      avra: %s (optional for .asm)\n' "$(command -v avra)"
else
    printf 'OPTIONAL avra: needed only for .asm sources\n'
fi
if [ "$missing" -eq 0 ]; then
    echo 'Toolchain looks available. Hardware and bootloader still need verification.'
else
    echo 'Install the missing tools; see README.md.'
fi
exit "$missing"
