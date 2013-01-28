/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Jul 20, 2010.
 *
 */
  
#include "TinyReef.h"

module SetLedStateBytecodeM
{
	provides
	{
		interface TinyReefBytecode;
	}
	 
	uses
	{ 
		interface Leds;
	}
}

implementation
{
	command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
	{
   		dbg("TinyReefBytecode", "TinyReefBytecode.execute - SetLedStateBytecodeM\n");
    	
    	atomic
		{
			switch (context->registerFile[R_A0]) {
				case LEDS_LED0:
					if(LED_ON == context->registerFile[R_A1])
					{
						dbg("TinyReefLed", "Leds.led0On()\n");
						call Leds.led0On();
					}
					else
					{
						dbg("TinyReefLed", "Leds.led0Off()\n");
						call Leds.led0Off();
					}
					break;
				case LEDS_LED1:
					if(LED_ON == context->registerFile[R_A1])
					{
						dbg("TinyReefLed", "Leds.led1On()\n");
						call Leds.led1On();
					}
					else
					{
						dbg("TinyReefLed", "Leds.led1Off()\n");
						call Leds.led1Off();
					}
					break;
				case LEDS_LED2:
					if(LED_ON == context->registerFile[R_A1])
					{
						dbg("TinyReefLed", "Leds.led2On()\n");
						call Leds.led2On();
					}
					else
					{
						dbg("TinyReefLed", "Leds.led2Off()\n");
						call Leds.led2Off();
					}
					break;
				default:
					dbg("TinyReefLed", "Led number not supported\n");
					return FAIL;
					break;
			}
    	}

		return SUCCESS;
	}
}