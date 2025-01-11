LDFLAGS ?= -nolibc -nostdlib -belf32-littlearm -nocommon -Wl,-Map=output.map -Tlink.ld
CFLAGS ?= -Wall -Werror -Wextra -mthumb -mcpu=cortex-m4 \
		  -ffreestanding -nostdlib -nolibc \
		  -ffunction-sections -fdata-sections

# Compile program
firmware.elf: firmware.c
	arm-none-eabi-gcc $(CFLAGS) $(LDFLAGS) -c $< -o $@

.PHONY: debug
debug: firmware.c
	arm-none-eabi-gcc $(CFLAGS) -g3 -Og $(LDFLAGS) -c $< -o firmware.elf