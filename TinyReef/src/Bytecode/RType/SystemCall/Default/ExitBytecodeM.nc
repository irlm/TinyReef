/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   May 28, 2010.
 *
 */

#include "TinyReef.h"
#include "TinyReefProcessState.h"

module ExitBytecodeM
{
	provides
	{
		interface TinyReefBytecode;
	} 
}

implementation
{

	command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - ExitBytecodeM\n");

		dbg("TinyReefC", "context->state =%d.\n", context->state);
		
		context->state |= DONE_TERMINATED;

		return SUCCESS;
	}

}