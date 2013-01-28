/*
 * RadioSenseToLeds.c
 *
 *  Created on: 23/07/2010
 *      Author: igor
 */

#include "TinyReefLib.h"

void milliTimerEvent()
{
	uint8_tr var;

	setLedStateTinyReef(LED_RED, LED_OFF);
	for (var = 0; var < 100; var++) {
		__asm__ __volatile__(
								"	.set	mips3		\n"
								"	sw	$ra, 28($sp)	\n"
								"	.set	mips0		\n"
								  );

	}
	setLedStateTinyReef(LED_RED, LED_ON);
}

void _start()
{
	startTimerTinyReef(250 , &milliTimerEvent, &exitTinyReef);

	exitTinyReef();
}

