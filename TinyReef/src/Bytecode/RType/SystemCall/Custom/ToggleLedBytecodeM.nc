/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Set 24, 2009.
 *
 */

module ToggleLedBytecodeM
{
	provides interface TinyReefBytecode;
	uses interface Leds;
}

implementation
{
	command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
	{
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - SetLedBytecodeM\n");
    	
    	atomic
		{
			switch (context->registerFile[R_A0]) {
				case LEDS_LED0:
					dbg("TinyReefLed", "Leds.led0Toggle()\n");
					call Leds.led0Toggle();
					break;
				case LEDS_LED1:
					dbg("TinyReefLed", "Leds.led1Toggle()\n");
					call Leds.led1Toggle();
					break;
				case LEDS_LED2:
					dbg("TinyReefLed", "Leds.led2Toggle()\n");	
					call Leds.led2Toggle();
					break;
				default:
					dbg("TinyReefLed", "Led number not supported\n");
					break;
			}
    	}

		return SUCCESS;
	}
}