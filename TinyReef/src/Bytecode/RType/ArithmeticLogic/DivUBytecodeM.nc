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
 * Divide the contents of Reg.File[Rs] by Reg.File[Rt], treating both operands as unsigned
 * values. Store the quotient in the LOW register, and store the remainder in the HIGH
 * register. The quotient and remainder will always be positive values. No overflow
 * exception occurs under any circumstances. It is the programmer’s responsibility to test if
 * the divisor is zero before executing this instruction, because the results are undefined
 * when the divisor is zero.
 * 
 * @author Igor L Marques
 */
module DivUBytecodeM
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
    	 * 000000	sssss	ttttt	0000000000	011011
		*/
		
		uint8_t	registerRS;
		uint8_t	registerRT;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - DivUBytecodeM\n");
    	
    	//5 bits
    	registerRS = (uint8_t)(0x1F & (instruction >> 21));
    	dbg("TinyReefBytecode", "registerRS = %d \n", registerRS);
    	
    	//5 bits
    	registerRT = (uint8_t)(0x1F & (instruction >> 16));
    	dbg("TinyReefBytecode", "registerRT = %d \n", registerRT);
    	    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRS] = %d \n", context->registerFile[registerRS]);
    	dbg("TinyReefBytecode", "context->registerFile[registerRT] = %d \n", context->registerFile[registerRT]);
    	
    	context->registerFile[SR_LO] = (uint16_t)(context->registerFile[registerRS] / context->registerFile[registerRT]);
    	dbg("TinyReefBytecode", "context->registerFile[SR_LO] = %d \n", context->registerFile[SR_LO]);
    
    	context->registerFile[SR_HI] = (uint16_t)(context->registerFile[registerRS] % context->registerFile[registerRT]);
    	dbg("TinyReefBytecode", "context->registerFile[SR_HI] = %d \n", context->registerFile[SR_HI]);
    	
    	return SUCCESS;	
    }
       
}