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
#include "TinyReefMemory.h"

/**
 * Add contents of Reg.File[Rs] to Reg.File[Rt] and store result in Reg.File[Rd].
 * If overflow occurs in the two’s complement number system, an exception is generated.
 *
 * @author Igor L Marques
 */  
module AddBytecodeM
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
    	 * 000000	sssss	ttttt	ddddd	00000	100000
		*/
		
		uint8_t	registerRS;
		uint8_t	registerRT;
		uint8_t	registerRD;
		
		int64_t result;
		
		int8_t ret = FAIL;		
				
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - AddBytecodeM\n");
    	
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
    	
    	
    	result = context->registerFile[registerRS] + context->registerFile[registerRT];
    	
    	if((result >= MIN_VALUE) && (result <= MAX_VALUE))
    	{
    		context->registerFile[registerRD] = (int32_t)result;
    		dbg("TinyReefBytecode", "context->registerFile[registerRD] = %d \n", context->registerFile[registerRD]);	
    	
    		ret = SUCCESS;
    	}
    	
    	return ret;     	 
    }
       
}