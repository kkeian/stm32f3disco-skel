// start address of GPIOE
unsigned *GPIOE = (unsigned *)0x48001000;

int main(void)
{
	// config pin 10 (blue LED) to GPOut mode
	//*GPIOE = (0x1 << 20);
	return 0;
}
