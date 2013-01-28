/*
 * exit.c
 *
 *  Created on: 28/05/2010
 *      Author: igor
 */

#include "TinyReefLib.h"

void exitTinyReef(void)
{
	__asm__ __volatile__(
			"	.set	mips3				\n"
			"	li		$v0, %0		# exit	\n"
			"	syscall						\n"
			"	.set	mips0				\n"
			: /* no outputs */
			: "g"(SYSCALL_EXIT)
			  );

}
