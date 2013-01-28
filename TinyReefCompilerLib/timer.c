/*
 * timer.c
 *
 *  Created on: 05/07/2010
 *      Author: igor
 */

#include "TinyReefLib.h"

void startTimerTinyReef(uint32_tr dt, void (*function)(), void (*Endfunction)())
{
	__asm__ __volatile__(
			"	.set	mips3		\n"
			"	li		$v0, %0		\n"
			"	syscall				\n"
			"	.set	mips0		\n"
			:
			: "g"(SYSCALL_TIMER)
			  );
}
