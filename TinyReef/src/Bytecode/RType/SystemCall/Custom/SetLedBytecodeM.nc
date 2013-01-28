/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques, Jobson Ronan
 * History:   Set 8, 2009.
 *
 */
  
#include "TinyReef.h"

module SetLedBytecodeM
{
	provides interface TinyReefBytecode;
	uses interface Leds;
}

implementation
{
	command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
	{
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - SetLedBytecodeM\n");
    	
    	dbg("TinyReefLed", "Leds.set(%d)\n", context->registerFile[R_A0]);
		call Leds.set((uint8_t)(context->registerFile[R_A0]));
		
		return SUCCESS;
	}
}