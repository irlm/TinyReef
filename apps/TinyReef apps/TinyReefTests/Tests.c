/*
 * RadioSenseToLeds.c
 *
 *  Created on: 23/07/2010
 *      Author: igor
 */

#include "Tests.h"

test_msg_t packet;

void milliTimerEvent()
{
	uint8_tr data = 0;

	radio_sense_msg_t send;

	senseTinyReef(VOLTAGE, &data, sizeof(uint8_tr));

	send.data = data;

	sendTinyReef(AM_BROADCAST_ADDR, AM_TINYREEF_APPLICATION, (void *)&send, sizeof(radio_sense_msg_t));
}

void receiveEvent()
{
	if (packet.data & 0x1)
	{
		setLedStateTinyReef(LED_RED, LED_ON);
	}
	else
	{
		setLedStateTinyReef(LED_RED, LED_OFF);
	}

	if (packet.data & 0x2)
	{
		setLedStateTinyReef(LED_GREEN, LED_ON);
	}
	else
	{
		setLedStateTinyReef(LED_GREEN, LED_OFF);
	}

	if (packet.data & 0x4)
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
	startReceiveTinyReef((uint8_tr*)&packet, (uint8_tr)sizeof(radio_sense_msg_t), &receiveEvent, &exitTinyReef);

	startTimerTinyReef(250 , &milliTimerEvent, &exitTinyReef);

	exitTinyReef();
}

