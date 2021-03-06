/*
 * led.c
 *
 *  Created on: 05/07/2010
 *      Author: igor
 */

#include "TinyReefLib.h"

void toggleLedTinyReef(LED led)
{
	__asm__ __volatile__(
						"	.set	mips3		\n"
						"	li		$v0, %0		\n"
						"	syscall				\n"
						"	.set	mips0		\n"
						: /* no outputs */
						: "g"(SYSCALL_TOGGLE_LED)
						  );
}
