/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Apr 26, 2010.
 *
 */

#include "TinyReef.h"

/**
 * Load the PC with an the address that is in Reg.File[Rs].
 * 
 * (Use this instructions to return from a function call.)
 *
 * @author Igor L Marques
 */  
module JmprBytecodeM
{
	provides interface TinyReefBytecode;
}

implementation
{
    command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	5 bits	15 bits			6 bits
    	 * 000000	Rs		padding			Function code
    	 * 
    	 * sample:
    	 * 000000	sssss	000000000000000	001000
		*/
		
		uint8_t	registerRS;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - JmprBytecodeM\n");
    	
    	//5 bits
    	registerRS = (uint8_t)(0x1F & (instruction >> 21));
    	dbg("TinyReefBytecode", "registerRS = %d \n", registerRS);
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRS] = %d \n", context->registerFile[registerRS]);
    	
    	context->PC = context->registerFile[registerRS];
    	
    	return SUCCESS;    	
    }
       
}