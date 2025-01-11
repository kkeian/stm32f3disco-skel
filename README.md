# Skeleton project for baremetal STM32F303 Discovery

## Files
- startup.s : startup file that initializes hardware and sets up runtime environment before asserting reset pin.
- link.ld : linker script specifying memory layout and where to put code segments in memory map.
- main.c : application code to run

## Debug
1. Plug in STM32 device to host computer via micro-USB connector on the board.
2. Start the GDB server:
```
st-util
```
3. Compile executable to ELF format.
```
make debug
```
4. Run debugger with your compiled file.
```
arm-none-eabi-gdb firmware.elf
```
5. Connect to the GDB server on default port.
```
(gdb) target extended localhost:4242
```
6. Load the program segments into the correct memory locations according to how the ELF was linked.
```
(gdb) load
```
7. Use GDB as usual.
```
b <line-no>
continue
r
bt
```
etc.

## Tools Used
stlink-org/stlink open source tools from github
- st-flash : to flash the program to the STM32 device.
- st-util : GDB server for remote debugging via ST-LINK debugger.
- arm-none-eabi-gdb : GNU Debugger
- arm-none-eabi-gcc : C compiler
- arm-none-eabi-nm : dump symbols in binary file
- arm-none-eabi-objdump : view object file contents
- arm-none-eabi-readelf : view ELF file contents