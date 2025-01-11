ENTRY(_reset)

MEMORY {
	flash(rx) : ORIGIN = 0x8000000, LENGTH = 256k
	sram(rwx) : ORIGIN = 0x20000000, LENGTH = 40k
}

STACK_SZ = 0x400;

SECTIONS {
	.text :
	{
		KEEP(*(.vector*))
		*(.text*)
		*(.rodata*)
	} > flash

	.bss (NOLOAD) :
	{
		_sbss = . ;
		*(.bss*)
		_ebss = . ;
	} > sram

	.data :
	{
		_sdata = . ;
		*(.data*)
		_edata = . ;
	} > sram AT > flash

	.stack (NOLOAD) :
	{
		. = ALIGN(8);
		. = . + STACK_SZ;
		. = ALIGN(8);
	} > sram
}