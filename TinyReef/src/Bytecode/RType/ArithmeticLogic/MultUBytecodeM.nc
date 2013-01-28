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
 * Multiply the contents of Reg.File[Rs] by Reg.File[Rt] and store the lower 32-bits of the
 * product in the LOW register, and store the upper 32-bits of the product in the HIGH
 * register. The two operands are treated as unsigned positive values. No overflow exception
 * occurs under any circumstances.
 * 
 * @author Igor L Marques
 */
module MultUBytecodeM
{
	provides interface TinyReefBytecode;
}

implementation
{
    command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	5 bits	5 bits	10 bits		6 bits
    	 * 000000	Rs		Rt 		padding		Function code
    	 * 
    	 * sample:
    	 * 000000	sssss	ttttt	00000000000	011000
		*/
		
		uint8_t	registerRS;
		uint8_t	registerRT;
		
		uint64_t result;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - MultUBytecodeM\n");
    	
    	//5 bits
    	registerRS = (uint8_t)(0x1F & (instruction >> 21));
    	dbg("TinyReefBytecode", "registerRS = %d \n", registerRS);
    	
    	//5 bits
    	registerRT = (uint8_t)(0x1F & (instruction >> 16));
    	dbg("TinyReefBytecode", "registerRT = %d \n", registerRT);
    	    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRS] = %d \n", context->registerFile[registerRS]);
    	dbg("TinyReefBytecode", "context->registerFile[registerRT] = %d \n", context->registerFile[registerRT]);
		
		result = context->registerFile[registerRS] * context->registerFile[registerRT];
		
		context->registerFile[SR_HI] = ( 0xFFFFFFFF & (result >> 32));
		context->registerFile[SR_LO] = ( 0xFFFFFFFF & result);
		
		return SUCCESS;	
    }
       
}