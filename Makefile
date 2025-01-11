LDFLAGS ?= -nolibc -nostdlib -fno-common -Wl,-Map=output.map -Tlink.ld
CFLAGS ?= -Wall -Werror -Wextra -mthumb -mcpu=cortex-m4 \
		  -ffreestanding -nostdlib -nolibc \
		  -ffunction-sections -fdata-sections
ASFLAGS ?= -mthumb -mimplicit-it=thumb -EL -mwarn-deprecated

# Compile program
firmware.elf: firmware.c
	arm-none-eabi-gcc $(CFLAGS) $(LDFLAGS) -c $< -o $@

.PHONY: debug
debug: firmware.c
	arm-none-eabi-gcc $(CFLAGS) -g3 -Og $(LDFLAGS) -c $< -o firmware.elf

.PHONY: startup
startup: startup.s
	arm-none-eabi-gcc -g3 -Og -mthumb -mcpu=cortex-m4 -ffreestanding -nostdlib\
					-nolibc -ffunction-sections -fdata-sections\
					$(LDFLAGS) $< -o firmware.elf

# Example compiler flags to convert C to assembly that can be compiled to run
# on the ARMv7-M which only accepts Thumb instructions.
# arm-none-eabi-gcc -g3 -Og -mthumb -mcpu=cortex-m4 -ffreestanding -nostdlib\
					-nolibc -ffunction-sections -fdata-sections\
					-S main.c -o main.s