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
 * 
 * Add contents of Reg.File[Rs] to sign extended Imm value, store result in Reg.File[Rt].
 * No overflow exception is generated.
 * 
 * @author Igor L Marques
 * 
 */ 
module AddIUBytecodeM
{
	provides interface TinyReefBytecode;
}

implementation
{
    command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	5 bits	5 bits	16 bits
    	 * 001001	Rs		Rt 		Immediate
    	 * 
    	 * sample:
    	 * 001001	sssss	ttttt	iiiiiiiiiiiiiiii
		*/   
   
   		uint8_t	registerRS;
		uint8_t	registerRT;
		int16_t immediate;
			
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - AddIUBytecodeM\n");
    	
    	//5 bits
    	registerRS = (uint8_t)(0x1F & (instruction >> 21));
    	dbg("TinyReefBytecode", "registerRS = %d \n", registerRS);
    	
    	//5 bits
    	registerRT = (uint8_t)(0x1F & (instruction >> 16));
    	dbg("TinyReefBytecode", "registerRT = %d \n", registerRT);
    	
    	//16 bits
    	immediate = (int16_t)(0xFFFF & instruction);
    	dbg("TinyReefBytecode", "constant = %d \n", immediate);
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRS] = 0x%8X \n", context->registerFile[registerRS]);
    	
    	context->registerFile[registerRT] = context->registerFile[registerRS] + immediate;
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRT] = 0x%8X \n", context->registerFile[registerRT]);
    	
    	return SUCCESS;
    }
   
}