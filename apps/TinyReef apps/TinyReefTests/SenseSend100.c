/*
 * SenseSend100.c
 *
 *  Created on: 27/07/2010
 *      Author: igor
 *
 *  500 ms
 */

#include "Tests.h"

void timer()
{
	uint8_tr var;

	uint8_tr data = 0;

	test_msg_t send;

	setLedStateTinyReef(LED_RED, LED_OFF);
	for (var = 0; var < 100; var++) {

		senseTinyReef(VOLTAGE, &data, sizeof(uint8_tr));

		send.data = data;
		sendTinyReef(AM_BROADCAST_ADDR, AM_TINYREEF_APPLICATION, (void *)&send, sizeof(test_msg_t));
	}

	setLedStateTinyReef(LED_RED, LED_ON);

}


void _start()
{
	startTimerTinyReef(4500, &timer, &exitTinyReef);

	exitTinyReef();
}
