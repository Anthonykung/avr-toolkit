# Profile evidence and limits

The MCU datasheet establishes device capabilities and register definitions. It does **not** establish which oscillator, bootloader, programmer, baud, or external circuit is installed on a particular board. Confirm those from the board schematic, firmware documentation, and the physical board.

| Profile | Datasheet fact | Board or configuration assumption |
| --- | --- | --- |
| ATmega32U4, 8 MHz, AVR109 | The ATmega16U4/32U4 datasheet defines the ATmega32U4 and its speed/voltage limits. | 8 MHz and AVR109 are board/bootloader choices. The reference board schematic shows an 8 MHz source and 3.3 V rail. The installed bootloader and its baud must be verified on the actual board. |
| ATmega128, 16 MHz, USBasp or AVRISP | The ATmega128-16 speed grade supports 16 MHz at 4.5-5.5 V. | A 16 MHz clock, suitable supply, ISP wiring, and selected programmer are external hardware choices. There is no universal ATmega128 board default. |
| Arduino Uno R3 | ATmega328P is the MCU. | Arduino's Uno R3 documentation states 16 MHz; Arduino AVR Boards configuration states `arduino` protocol and 115200 baud. |
| Arduino Mega 2560 Rev3 | ATmega2560 is the MCU. | Arduino's Mega 2560 documentation states a 16 MHz crystal; Arduino AVR Boards configuration states `wiring` protocol and 115200 baud. |
| ATtiny85, factory clock | The ATtiny25/45/85 datasheet states an 8 MHz internal oscillator with CKDIV8 programmed at shipment, yielding a 1 MHz system clock. | USBasp is an external ISP programmer choice, not a property of the chip. Fuse changes can invalidate the 1 MHz default. |

## Primary references

- [Microchip ATmega16U4/32U4 complete datasheet](https://ww1.microchip.com/downloads/en/devicedoc/atmel-7766-8-bit-avr-atmega16u4-32u4_datasheet.pdf)
- [Microchip ATmega128/L complete datasheet](https://ww1.microchip.com/downloads/en/DeviceDoc/doc2467.pdf)
- [Microchip ATtiny25/45/85 datasheet](https://ww1.microchip.com/downloads/en/devicedoc/atmel-2586-avr-8-bit-microcontroller-attiny25-attiny45-attiny85_datasheet.pdf)
- [Arduino Uno R3 board documentation](https://docs.arduino.cc/hardware/uno-rev3/)
- [Arduino Mega 2560 Rev3 board documentation](https://docs.arduino.cc/hardware/mega-2560/)
- [Arduino AVR Boards profile definitions](https://github.com/arduino/ArduinoCore-avr/blob/master/boards.txt)
- [AVRDUDE supported parts](https://avrdudes.github.io/avrdude/8.1/avrdude_46.html) and [programmers](https://avrdudes.github.io/avrdude/8.1/avrdude_45.html)

The repository does not copy headers or examples from these sources.
