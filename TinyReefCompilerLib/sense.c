/*
 * send.c
 *
 *  Created on: 23/07/2010
 *      Author: igor
 */

#include "TinyReefLib.h"

void senseTinyReef(SenseTypes_enum SenseType, uint8_tr* dataMemoryAddress,
		uint8_tr dataLength)
{
	__asm__ __volatile__(
			"	.set	mips3		\n"
			"	li		$v0, %0		\n"
			"	syscall				\n"
			"	.set	mips0		\n"
			: /* no outputs */
			: "g"(SYSCALL_SENSE)
			  );
}



