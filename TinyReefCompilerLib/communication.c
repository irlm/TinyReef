/*
 * send.c
 *
 *  Created on: 18/05/2010
 *      Author: igor
 */

#include "TinyReefLib.h"

void startReceiveTinyReef(uint8_tr* data, uint8_tr dataLength, void(*function)(), void (*Endfunction)())
{
	__asm__ __volatile__(
				"	.set	mips3		\n"
				"	li		$v0, %0		\n"
				"	syscall				\n"
				"	.set	mips0		\n"
				: /* no outputs */
				: "g"(SYSCALL_RECEIVE)
				  );
}

void sendTinyReef(uint16_tr DestinationAddress, uint8_tr id, uint8_tr* dataMemoryAddress, uint8_tr dataLength)
{

	__asm__ __volatile__(
			"	.set	mips3		\n"
			"	li		$v0, %0		\n"
			"	syscall				\n"
			"	.set	mips0		\n"
			: /* no outputs */
			: "g"(SYSCALL_SEND)
			  );
}



