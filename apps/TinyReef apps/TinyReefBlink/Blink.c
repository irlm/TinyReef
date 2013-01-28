/*
 * CallSend.c
 *
 *  Created on: 18/05/2010
 *      Author: igor
 */

#include "TinyReefLib.h"


void Timer0firedTask()
{
	toggleLedTinyReef(LED_RED);
}

void Timer1firedTask()
{
	toggleLedTinyReef(LED_GREEN);
}


void Timer2firedTask()
{
	toggleLedTinyReef(LED_YELLOW);
}


void _start()
{
	startTimerTinyReef(250 , &Timer0firedTask, &exitTinyReef);
	startTimerTinyReef(500 , &Timer1firedTask, &exitTinyReef);
	startTimerTinyReef(1000, &Timer2firedTask, &exitTinyReef);

	exitTinyReef();
}

