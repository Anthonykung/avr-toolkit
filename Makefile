SHELL := /bin/sh
.DEFAULT_GOAL := help

PROFILE ?= arduino-uno
FILE ?= examples/idle.c
BUILD_DIR ?= build

ifeq ($(wildcard profiles/$(PROFILE).mk),)
$(error Unknown PROFILE '$(PROFILE)'; see 'make profiles')
endif
include profiles/$(PROFILE).mk
include targets/$(TARGET).mk
include programmers/$(PROGRAMMER).mk

CC = avr-gcc
OBJCOPY = avr-objcopy
SIZE = avr-size
AVRDUDE = avrdude
AVRA = avra

EXT := $(suffix $(FILE))
STEM := $(basename $(notdir $(FILE)))
OUT := $(BUILD_DIR)/$(PROFILE)/$(STEM)
ELF := $(OUT).elf
HEX := $(OUT).hex
CFLAGS := -mmcu=$(MCU) -DF_CPU=$(F_CPU) -Os -std=gnu11 -Wall -Wextra -Werror
ASFLAGS := -mmcu=$(MCU) -x assembler-with-cpp

.PHONY: help profiles doctor ports build flash clean check-file
help:
	@printf '%s\n' 'AVR Toolkit' '  make profiles' '  make doctor' '  make ports' '  make build FILE=examples/idle.c PROFILE=arduino-uno' '  make flash FILE=examples/idle.c PROFILE=arduino-uno PORT=/dev/ttyACM0' '  make clean'

profiles:
	@for p in profiles/*.mk; do basename "$$p" .mk; done

doctor:
	@sh scripts/doctor.sh

ports:
	@sh scripts/ports.sh

check-file:
	@test -f "$(FILE)" || { echo "Source not found: $(FILE)" >&2; exit 1; }
	@case "$(EXT)" in .c|.S|.asm) ;; *) echo 'Use a .c, .S, or .asm source file' >&2; exit 1;; esac

build: check-file
	@mkdir -p "$(dir $(OUT))"
	@case "$(EXT)" in \
	  .c) $(CC) $(CFLAGS) "$(FILE)" -o "$(ELF)" && $(OBJCOPY) -O ihex -R .eeprom "$(ELF)" "$(HEX)" && $(SIZE) -C --mcu=$(MCU) "$(ELF)" ;; \
	  .S) $(CC) $(ASFLAGS) "$(FILE)" -o "$(ELF)" && $(OBJCOPY) -O ihex -R .eeprom "$(ELF)" "$(HEX)" && $(SIZE) -C --mcu=$(MCU) "$(ELF)" ;; \
	  .asm) $(AVRA) -o "$(HEX)" "$(FILE)" ;; \
	esac
	@echo "Built $(HEX)"

flash: build
	@test -n "$(PORT)" || test "$(NEEDS_PORT)" != 1 || { echo 'Set PORT to the bootloader serial port' >&2; exit 1; }
	$(AVRDUDE) -p $(AVRDUDE_PART) -c $(AVRDUDE_PROGRAMMER) $(if $(PORT),-P "$(PORT)") $(if $(BAUD),-b $(BAUD)) $(NO_ERASE) -U flash:w:"$(HEX)":i

clean:
	rm -rf "$(BUILD_DIR)"
