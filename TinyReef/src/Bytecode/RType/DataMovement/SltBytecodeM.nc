/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Set 08, 2009.
 *
 */

#include "TinyReef.h"

/**
 * If the contents of Reg.File[Rs] are less than the contents of Reg.File[Rt], then
 * Reg.File[Rd] is set to one, otherwise Reg.File[Rd] is set to zero; assuming the two’s
 * complement number system representation.
 *
 * @author Igor L Marques
 */  
module SltBytecodeM
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
    	 * 000000	sssss	ttttt	ddddd	00000	101010
		*/
		
		uint8_t	registerRS;
		uint8_t	registerRT;
		uint8_t	registerRD;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - SltBytecodeM\n");
    	
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
    	
    	if ((int32_t)context->registerFile[registerRS] < (int32_t)context->registerFile[registerRT] )
    	{
    		context->registerFile[registerRD] = 1; 
    	}
    	else
    	{
    		 context->registerFile[registerRD] = 0;
    	}
        	
    	dbg("TinyReefBytecode", "context->registerFile[registerRD] = %d \n", context->registerFile[registerRD]);	
    	
    	return SUCCESS;     	 
    }
       
}