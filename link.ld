ENTRY(reset)

MEMORY {
	flash(rx) : ORIGIN = 0x8000000, LENGTH = 256k
	sram(rwx) : ORIGIN = 0x20000000, LENGTH = 40k
}

/* use 1 KB stack */
STACK_SZ = 0x400;

SECTIONS {
	.text :
	{
		KEEP(*(.vector*))
		*(.text*)
		*(.rodata*)
		_etext = . ;
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

	.stack (NOLOAD) : ALIGN(0x8)
	{
		/* align stack on 8 byte boundaries per AAPCS requirements */

		/* Note - the below ALIGN is shown on Interrupt blog baremetal series but
		doesn't express the idea of alignment how you'd necessarily expect:
		. = ALIGN(8);
		the reason it might not work as you expect is that inside an output section,
		all addresses are relative to the output section's specified or heuristically
		determined start address.

		If you use the above ALIGN as an output section command it can leave a hole
		in memory at the start of the section's memory addresses.

		Instead, if you want to align the output section's beginning contents, you should use the ALIGN builtin
		as an output section optional attribute and not as an output section command inside
		the block.

		Think about if you decided to use . = ALIGN(8), and why you wouldn't want that:
		Having a hole inside the section at the start of the section's memory doesn't
		convey the idea of having a properly aligned contiguous block of memory.

		If there must be a hole in memory to properly align its contents,
		having it exist outside sections which makes more sense
		because the programmer view each section's contents as a completely valid
		contiguous memory block.
		This concept is obscured by including the hole in memory inside of the output section.
		*/
		_sstack = .; /* Debug only */
		. = . + STACK_SZ;
		. = ALIGN(0x8); /* this is effectual though and pads the end of this output
					  section before moving onto the next output section */
		_estack = .;
	} > sram
}