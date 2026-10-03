# AVR Toolkit

A small, beginner-friendly starting point for building and flashing **classic AVR** programs in C, GNU assembly (`.S`), or AVRA assembly (`.asm`). Created by Anthony Kung to make the first build less mysterious. It uses the command-line AVR toolchain directly; it does not include the Arduino core or libraries.

## Start here

1. Install **GNU Make**, **avr-gcc** (including avr-libc, avr-objcopy, and avr-size), and **AVRDUDE**. Install **AVRA** only if you use `.asm`. On Debian/Ubuntu: `sudo apt install make gcc-avr avr-libc binutils-avr avrdude avra`. On macOS, use a maintained AVR toolchain package and install `make`, `avrdude`, and optional `avra` with your package manager. Check package availability for your OS version.
2. In a terminal, run `make doctor`, then `make profiles`.
3. Build a harmless example: `make build FILE=examples/idle.c PROFILE=arduino-uno`. It only loops; it does not control a pin. It can be built for each profile.
4. Copy an example into `work/` and edit that copy. Build it with `make build FILE=work/my-program.c PROFILE=...`.
5. Connect your board and run `make ports`. For serial bootloaders, enter bootloader mode if your board requires it. **Verify the exact MCU, clock, bootloader protocol, baud, power supply, and port before flashing.** Then run `make flash FILE=work/my-program.c PROFILE=... PORT=/dev/ttyACM0`. For USBasp, `PORT` can be omitted.

The output is `build/<profile>/<source-name>.hex`. `make clean` removes generated files. Use `make build FILE=examples/loop.S PROFILE=...` for GNU assembly. The supplied AVRA example targets ATmega32U4 only: `make build FILE=examples/loop.asm PROFILE=atmega32u4-avr109-8mhz`.

Run `sh scripts/smoke.sh` to build the C and GNU assembly examples for every built-in profile. It also checks the AVRA example when AVRA is installed.

## Built-in profiles

| Profile | MCU | Assumed system clock | Assumed programmer |
| --- | --- | --- | --- |
| `atmega32u4-avr109-8mhz` | ATmega32U4 | 8 MHz | AVR109-compatible serial bootloader |
| `atmega128-usbasp-16mhz` | ATmega128 | 16 MHz | USBasp ISP |
| `atmega128-avrisp-16mhz` | ATmega128 | 16 MHz | serial AVRISP compatible adapter |
| `arduino-uno` | ATmega328P | 16 MHz | Arduino serial bootloader, 115200 baud |
| `arduino-mega2560` | ATmega2560 | 16 MHz | Wiring serial bootloader, 115200 baud |
| `attiny85-usbasp` | ATtiny85 | factory 1 MHz system clock | USBasp ISP |

These are **configurations**, not guarantees about every board containing the same chip. The `atmega128` profiles require a 16 MHz board setup and a 16 MHz rated device at an appropriate supply voltage; they do not describe a named board. The ATmega32U4 profile assumes the board has an AVR109-compatible bootloader. The MCU datasheet alone cannot establish its presence or baud. Supply `BAUD=...` if required by your bootloader. The ATtiny85 profile uses the factory clock divider setting; change `F_CPU` if you have changed fuses or clock prescaling. `F_CPU` only informs compilation and timing calculations: it **does not change hardware clock fuses**.

For a different board, copy a profile, choose an existing target and programmer, and set the actual clock. Add a new target or programmer file only when needed. Run `avrdude -p ?` and `avrdude -c ?` to inspect IDs supported by your installed version. This project has five MCU targets, not universal AVR coverage.

## Programming notes

- Flashing writes program flash and can replace a running application. ISP programming may erase a bootloader. Verify your board's bootloader and memory layout before ISP flashing.
- Serial bootloaders need the port they expose **during programming**. Some boards switch ports on reset.
- No target here changes fuses, lock bits, or EEPROM.
- The example programs intentionally have no board pin assignments. A chip datasheet defines register behavior; a board schematic defines where LEDs, switches, motors, and connectors are wired.

See [profile evidence](docs/profile-evidence.md) for the manufacturer and board references, and [troubleshooting](docs/troubleshooting.md) for common failures.

## Contact

- Students: https://ta.anth.dev/
- Everyone else: https://anth.dev/
- Bugs and feature requests: GitHub Issues in the repository where you publish this toolkit.

## License

Apache License 2.0. See [LICENSE](LICENSE). The repository contains original examples and does not bundle manufacturer headers, board firmware, or course source material.
