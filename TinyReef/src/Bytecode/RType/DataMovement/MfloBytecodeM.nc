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
 * Load Reg.File[Rd] with a copy of the value currently in special register LOW.
 *
 * @author Igor L Marques
 */  
module MfloBytecodeM
{
	provides interface TinyReefBytecode;
}

implementation
{
    command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	10 bits		5 bits	5 bits	6 bits
    	 * 000000	padding		Rd		padding	Function code
    	 * 
    	 * sample:
    	 * 000000	0000000000	ddddd	00000	010010
		*/
		
		uint8_t	registerRD;		
				
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - MfloBytecodeM\n");
    	
    	//5 bits
    	registerRD = (uint8_t) (0x1F & (instruction >> 11));
    	dbg("TinyReefBytecode", "registerRD = %d \n", registerRD);
    	
    	context->registerFile[registerRD] = context->registerFile[SR_LO];
 
    	dbg("TinyReefBytecode", "context->registerFile[registerRD] = %d \n", context->registerFile[registerRD]); 
 
    	return SUCCESS;    	
    }
       
}