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
 * 
 * Add contents of Reg.File[Rs] to sign extended Imm value, store result in Reg.File [Rt].
 * If overflow occurs in the two’s complement number system, an exception is generated.
 * 
 * @author Igor L Marques
 * 
 */ 
module AddIBytecodeM
{
	provides interface TinyReefBytecode;
}

implementation
{
    command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	5 bits	5 bits	16 bits
    	 * 001000	Rs		Rt 		Immediate
    	 * 
    	 * sample:
    	 * 001000	sssss	ttttt	iiiiiiiiiiiiiiii
		*/   
   
   		uint8_t	registerRS;
		uint8_t	registerRT;
		uint16_t immediate;
		
		int64_t result;
		
		int8_t ret = FAIL;
			
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - AddIBytecodeM\n");
    	
    	//5 bits
    	registerRS = (uint8_t)(0x1F & (instruction >> 21));
    	dbg("TinyReefBytecode", "registerRS = %d \n", registerRS);
    	
    	//5 bits
    	registerRT = (uint8_t)(0x1F & (instruction >> 16));
    	dbg("TinyReefBytecode", "registerRT = %d \n", registerRT);
    	
    	//16 bits
    	immediate = (uint16_t)(0xFFFF & instruction);
    	dbg("TinyReefBytecode", "constant = %d \n", immediate);
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRS] = %d \n", context->registerFile[registerRS]);
    	
    	
    	result = context->registerFile[registerRS] + immediate;
    	
    	if((result >= MIN_VALUE) && (result <= MAX_VALUE))
    	{
    		context->registerFile[registerRT] = (int32_t)result;
    		dbg("TinyReefBytecode", "context->registerFile[registerRT] = %d \n", context->registerFile[registerRT]);	
    	
    		ret = SUCCESS;
    	}
    	
    	return ret; 
    }
   
}