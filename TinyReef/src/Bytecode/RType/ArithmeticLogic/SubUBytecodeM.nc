/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Set 23, 2009.
 *
 */

#include "TinyReef.h"

/**
 * Subtract contents of Reg.File[Rt] from Reg.File[Rs] and store result in Reg.File[Rd].
 * No overflow exception is generated.
 *
 * @author Igor L Marques
 */ 
module SubUBytecodeM
{
	provides interface TinyReefBytecode;
}

implementation
{
    command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	5 bits	5 bits	5 bits	5 bits	6 bits
    	 * 000000	Rs		Rt 		Rd		padding	Function code
    	 * 
    	 * sample:
    	 * 000000	sssss	ttttt	ddddd	00000	100011
		*/
		
		uint8_t	registerRS;
		uint8_t	registerRT;
		uint8_t	registerRD;		
				
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - SubUBytecodeM\n");
    	
    	//5 bits
    	registerRS = (uint8_t)(0x1F & (instruction >> 21));
    	dbg("TinyReefBytecode", "registerRS = %d \n", registerRS);
    	
    	//5 bits
    	registerRT = (uint8_t)(0x1F & (instruction >> 16));
    	dbg("TinyReefBytecode", "registerRT = %d \n", registerRT);
    	    	
    	//5 bits
    	registerRD = (uint8_t) (0x1F & (instruction >> 11));
    	dbg("TinyReefBytecode", "registerRD = %d \n", registerRD);
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRS] = %d \n", context->registerFile[registerRS]);
    	dbg("TinyReefBytecode", "context->registerFile[registerRT] = %d \n", context->registerFile[registerRT]);
    	
    	context->registerFile[registerRD] = context->registerFile[registerRS] - context->registerFile[registerRT];
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRD] = %d \n", context->registerFile[registerRD]); 			
    
    	return SUCCESS;
    }
       
}