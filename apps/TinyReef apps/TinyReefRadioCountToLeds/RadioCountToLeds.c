/*
 * RadioCountToLeds.c
 *
 *  Created on: 13/07/2010
 *      Author: igor
 */

#include "RadioCountToLeds.h"

radio_count_msg_t packet;

uint16_tr counter;

void milliTimerEvent()
{
	counter++;

	radio_count_msg_t send;

	send.counter = counter;

	sendTinyReef(AM_BROADCAST_ADDR, AM_TINYREEF_APPLICATION, (void *)&send, sizeof(radio_count_msg_t));
}

void receiveEvent()
{
	if (packet.counter & 0x1)
	{
		setLedStateTinyReef(LED_RED, LED_ON);
	}
	else
	{
		setLedStateTinyReef(LED_RED, LED_OFF);
	}

	if (packet.counter & 0x2)
	{
		setLedStateTinyReef(LED_GREEN, LED_ON);
	}
	else
	{
		setLedStateTinyReef(LED_GREEN, LED_OFF);
	}

	if (packet.counter & 0x4)
	{
		setLedStateTinyReef(LED_YELLOW, LED_ON);
	}
	else
	{
		setLedStateTinyReef(LED_YELLOW, LED_OFF);
	}
}

void _start()
{
	startReceiveTinyReef((uint8_tr*)&packet, (uint8_tr)sizeof(radio_count_msg_t), &receiveEvent, &exitTinyReef);

	startTimerTinyReef(250 , &milliTimerEvent, &exitTinyReef);

	exitTinyReef();
}

