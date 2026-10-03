# Troubleshooting

## A tool is missing

Run `make doctor`. C and `.S` builds need avr-gcc, avr-libc, avr-objcopy, and avr-size. `.asm` builds additionally need AVRA. Flashing needs AVRDUDE. Use the package manager for your platform, then reopen the terminal so PATH updates.

## The source builds, but the board does nothing

The supplied examples are deliberately pin-neutral infinite loops. They demonstrate the build pipeline and will not blink an LED. For hardware behavior, obtain the **board schematic**, identify a safe output pin, and write a board-specific program. Check clock and power assumptions separately from the MCU datasheet.

## Wrong device signature

Check the physical MCU marking and the selected profile. Do not bypass signature checks. An ATmega32 and ATmega32U4 are different devices.

## Serial port missing or access denied

Run `make ports` before and after entering the bootloader. Disconnect serial monitors. On Linux, check the device's group and your membership; on macOS, check `/dev/cu.*`. A USB cable may provide power without data.

## AVR109 or Arduino upload timeout

Confirm the board really has the matching bootloader, the port is its bootloader port, and the baud is correct. For the ATmega32U4 profile, set `BAUD=...` from the board documentation. Reset timing differs by board. A blank chip cannot accept an AVR109 serial upload until a compatible bootloader is installed.

## USBasp cannot talk to a slow chip

Check ISP wiring, target power, and common ground. A factory ATtiny85 runs its CPU at 1 MHz. Its ISP clock may need to be slowed using the programmer's jumper or a supported AVRDUDE `-B` setting. This toolkit does not change fuses.

## `.asm` assembler errors

AVRA syntax and device definitions differ from GNU AVR assembly. Use `.S` for avr-gcc assembler-with-preprocessor sources, or `.asm` for AVRA. The supplied `.asm` example is specifically for ATmega32U4. For other devices, use their AVRA-supported device name and correct definitions. Do not mix the two syntaxes.

## Timing is wrong

`F_CPU` must match the **actual system clock after prescalers**, not merely the oscillator frequency printed on a schematic. Check fuses, clock division, and board revisions. Changing the Makefile value does not set fuses.
