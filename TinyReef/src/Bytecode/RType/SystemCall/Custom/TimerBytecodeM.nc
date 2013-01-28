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

module TimerBytecodeM
{
	provides interface TinyReefBytecode;
	uses
	{
		interface Timer<TMilli> as TimerMilli[uint8_t id];
		interface TinyReefEventHandler as EventHandler;
	} 
}
implementation
{
	
	command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	error_t ret = FAIL;
    		
    	uint8_t	id = 0;
		uint32_t memoryAddress = 0x0;
		uint32_t endEventAddress = 0x0;
		uint32_t dt = 0x0;
		
		if(context != NULL)
		{
			dbg("TinyReefBytecode", "TinyReefBytecode.execute - TimerBytecodeM\n");
	    	
	    	// register the timer.Fired handler
			dt = 0xFFFF & (context->registerFile[R_A0]);
			dbg("TinyReefBytecode", "dt = %d \n", dt);
			
	    	memoryAddress = context->registerFile[R_A1];
	    	dbg("TinyReefBytecode", "MemoryAddress = 0x%8X \n", memoryAddress);
	    	
	    	endEventAddress = context->registerFile[R_A2];
	    	dbg("TinyReefBytecode", "MemoryAddress = 0x%8X \n", endEventAddress);
    	    			
			// register the handler
			ret = call EventHandler.registerEvent(context, memoryAddress, endEventAddress, &id);
	
			if(SUCCESS == ret)
			{
			  	dbg("TinyReefBytecode", "startPeriodic[%d](%d).\n", id, dt);
				call TimerMilli.startPeriodic[id](dt);
			}
		}
		
		return ret;
	}

	event void TimerMilli.fired[uint8_t id]()
	{
		error_t	ret;
		
		dbg("TinyReefBytecode", "fired[%d].\n", id);
		ret = call EventHandler.executeEvent(id);
		
		if(FAIL == ret)
		{
			dbg("TinyReefBytecode", "FAIL timer[%d].\n", id);
			call TimerMilli.stop[id]();
		}
	}

	default command void TimerMilli.startPeriodic[uint8_t id](uint32_t dt)
	{
		dbg("TinyReefBytecode", "Invalid timer: [%d].\n", id);
	}

	default command void TimerMilli.stop[uint8_t id]()
	{
		dbg("TinyReefBytecode", "Invalid timer: [%d].\n", id);
	}
}