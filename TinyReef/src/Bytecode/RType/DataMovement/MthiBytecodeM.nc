/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   May 04, 2010.
 *
 */

#include "TinyReef.h"

/**
 * Load special register HIGH with a copy of the value currently in Reg.File[Rs].
 *
 * @author Igor L Marques
 */  
module MthiBytecodeM
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
    	 * 000000	sssss	000000000000000	010001
		*/
		
		uint8_t	registerRS;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - MthiBytecodeM\n");
    	
    	//5 bits
    	registerRS = (uint8_t)(0x1F & (instruction >> 21));
    	dbg("TinyReefBytecode", "registerRS = %d \n", registerRS);
    	
    	context->registerFile[SR_HI] = context->registerFile[registerRS];
 
    	dbg("TinyReefBytecode", "context->registerFile[SR_HI] = %d \n", context->registerFile[SR_HI]); 
 
    	return SUCCESS;    	
    }
       
}