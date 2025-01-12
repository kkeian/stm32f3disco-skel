/* use new unified syntax which uses new encoding for ARM equivalent instructions under Thumb-2 */
.syntax unified

msp: .word _etext
	.text
	.global reset
reset:
	push {r7}
	add r7, sp, #0

	.section .vector
	/* vector table must be "naturally aligned" to a power of 2 with
	the value being >= # exceptions supported * 4. "naturally aligned"
	means the next power of 2 above the # exceptions * 4. Min value
	is 128 bytes. source: ARM ARM for armv7-m processors. */
	/* GNU AS (GAS) .align assembler directive for ARM targets
	expects the first arg to be the # of lower-order (from least
	significant bit positions) bits which must be == 0. This is
	just another way of saying the power of 2 that the
	section must be aligned to, or the log_2(byteboundary). source:
	GNU as documentation .align directive section. */
	/* 96 interrupts defined for the vector table of
	STM32F303xxC processor on the STM32F303 Discovery source: the MCU
	Reference Manual. */
	/* 96 * 4 = 384. Next highest power of 2 =
	512 = desired byte boundary
	log_2(512) = 9 = # of lower order 0's in 512 */
	.align 9
/* as defined in processor Ref Manual:

*/
	.global vector_table
vector_table:
	.word msp
	.word reset
/*	.word nmi
	.word hard_fault
	.word mem_manage
	.word bus_fault
	.word usage_fault
*/

/* always end files in newline per GNU as(1) docs */